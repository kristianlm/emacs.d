;;; multi-mode.el --- support for multiple major modes

;; copyright (c) 2003, 2004, 2007, 2009  free software foundation, inc.

;; author: dave love <fx@gnu.org>
;; keywords: languages, extensions, files
;; created: sept 2003
;; $revision: 1.13 $
;; url: http://www.loveshack.ukfsn.org/emacs

;; this file is free software; you can redistribute it and/or modify
;; it under the terms of the gnu general public license as published by
;; the free software foundation, either version 3 of the license, or
;; (at your option) any later version.

;; this file is distributed in the hope that it will be useful,
;; but without any warranty; without even the implied warranty of
;; merchantability or fitness for a particular purpose.  see the
;; gnu general public license for more details.

;; you should have received a copy of the gnu general public license
;; along with gnu emacs.  if not, see <http://www.gnu.org/licenses/>.

;;; commentary:

;; this is a framework for a sort of meta mode which provides support
;; for multiple major modes in different regions (`chunks') of a
;; buffer -- sort of.  actually, multiple indirect buffers are used,
;; one per mode (apart from the base buffer, which has the default
;; mode).  a post-command hook selects the correct buffer for the mode
;; around point.  this is done on the basis of calling the elements of
;; `multi-chunk-fns' and taking the value corresponding to a start
;; position closest to point.

;; [i originally tried maintaining information about the local major
;; mode on a text property maintained by font-lock along with a
;; `point-entered' property to control changing the indirect buffer.
;; this worked less well for reasons i've forgotten, unfortunately.
;; the post-command hook seems to be efficient enough in the simple
;; cases i've tried, and is most general.]

;; using indirect buffers ensures that we always have the correct
;; local buffer properties like the keymap and syntax table, including
;; the local variable list.  there are other implementations of this
;; sort of thing, e.g. for literate programming, but as far as i know,
;; they all work either by continually re-executing the major mode
;; functions or by swapping things like the keymap in and out
;; explicitly.  using indirect buffers seems to be the right thing and
;; is at least potentially more robust, for instance for things like
;; specific subprocesses associated with the buffer for ispell or
;; whatever.  (however, it has the potential confusion of there
;; actually being multiple buffers, even if they mostly act like one.
;; it also may interact badly with other modes using
;; `post-command-hook', as with flyspell.)  also, it's fairly simple.

;; maybe it won't turn out to be the best approach, but it currently
;; seems to me to be better than the approach used by mmm mode
;; <url:http://mmm-mode.sourceforge.net/>, and is a lot less code.  i
;; suspect doing the job any better would require fairly serious
;; surgery on buffer behaviour.  for instance, consider being able
;; programmatically to treat discontinuous buffer regions as
;; continuous according to, say, text properties.  that would work
;; rather like having multiple gaps which the most primitive movement
;; functions skip.

;; the other major difference to mmm mode is that we don't operate on
;; more-or-less static regions in different modes which need to be
;; re-parsed explicitly and/or explicitly inserted.  instead they're
;; dynamically defined, so that random editing dtrt.

;; things like font-lock and imenu need to be done piecewise over the
;; chunks.  some functions, such as indentation, should be executed
;; with the buffer narrowed to the current chunk.  this ensures they
;; aren't thrown by syntax in other chunks which could confuse
;; `parse-partial-sexp'.

;; the intention is that other major modes can be defined with this
;; framework for specific purposes, e.g. literate programming systems,
;; e.g. literate haskell, mixing haskell and latex chunks.  see the
;; example of haskell-latex.el, which can activate the literate mode
;; just by adding to `haskell-mode-hook'.  the multiple modes can also
;; be chosen on the basis of the file contents, e.g. noweb.el.

;; problems:
;; * c-x c-v in the indirect buffer just kills both buffers.  (perhaps an
;;   emacs bug.)
;; * font-locking doesn't always work properly in emacs 21, due to lack
;;   of `font-lock-dont-widen', e.g. see the commentary in
;;   haskell-latex.el.
;; * c-x c-w in emacs 21 may change the mode when it shouldn't.
;; * flyspell needs modifying so as not to cause trouble with this.
;;   for the moment we hack the flyspell hook functions.
;; * the behaviour of the region can appear odd if point and mark are in
;;   regions corresponding to different modes, since they are actually in
;;   different buffers.  we really want point and marks to be shared among
;;   the indirect buffers.
;; * `view-file' doesn't work properly -- only the main buffer gets the
;;   minor mode.  probably fixable using `view-mode-hook'.
;; * doubtless facilities other than imenu, font lock and flyspell
;;   should be supported explicitly or fixed up to work with this,
;;   e.g. by narrowing to the chunk around commands.  there may be a
;;   need for more hooks or other support in base emacs to help.
;; * fontification currently doesn't work properly with modes which
;;   define their own fontification functions, at least the way nxml mode
;;   does it.  nxml seems to need hacking to get this right, maybe by
;;   converting it to use font-lock.  nxml is the only mode i know
;;   which defines its own `fontification-functions', although psgml
;;   does its own fontification differently again.  generally, any
;;   fontification which doesn't respect the narrowing in force will
;;   cause problems.  (one might think about `flet'ting `widen' to
;;   `ignore' around fontification functions, but that means they can't
;;   parse from a previous point, as things like nxml should
;;   legitimately be able to do.)

;; todo:
;; * provide a simple way to define multi-chunk functions by a series
;;   of delimiting regexps, similarly to mmm mode -- someone asked for
;;   that.
;; * provide a means for code describing `island' chunks, which
;;   doesn't know about the base or other modes, to describe a chain
;;   of chunks in that mode for mapping over chunks.

;;; code:

(require 'font-lock)
(require 'imenu)
(eval-when-compile (require 'advice))

(defvar multi-indirect-buffers-alist nil
  "alist of direct and indirect buffers v. major modes.
internal use.  buffer local.")
(make-variable-buffer-local 'multi-indirect-buffers-alist)

(defvar multi-normal-fontify-function nil
  "fontification function normally used by the buffer's major mode.
internal use.  buffer local.")
(make-variable-buffer-local 'multi-normal-fontify-function)

(defvar multi-normal-fontify-functions nil
  "fontification functions normally used by the buffer's major mode.
internal use.  buffer local.")
(make-variable-buffer-local 'multi-normal-fontify-functions)

(defvar multi-indirect-buffer-hook nil
  "hook run by `multi-install-mode' in each indirect buffer.
it is run after all the indirect buffers have been set up.")

(defvar multi-select-mode-hook nil
  "hook run after a different mode is selected.")

(defvar multi-chunk-fns nil
  "list of functions to determine the modes of chunks.
each takes a single arg, the position at which to find the mode.  it returns
a list (mode start end).
buffer local.")
(make-variable-buffer-local 'multi-chunk-fns)

(defsubst multi-base-buffer ()
  "return base buffer of current buffer, or the current buffer if it's direct."
  (or (buffer-base-buffer (current-buffer))
      (current-buffer)))

(defvar multi-late-index-function nil
  "original value of `imenu-create-index-function' for the buffer's mode.")
(make-variable-buffer-local 'multi-late-index-function)

(defvar multi-mode-alist nil
  "alist of elements (mode . function) specifying a buffer's multiple modes.
mode is a major mode and function is a function used as an element of
`multi-chunk-fns' or nil.  use nil if mode is detected by another element
of the alist.")

(if (fboundp 'define-obsolete-variable-alias)
    (define-obsolete-variable-alias 'multi-alist 'multi-mode-alist)
  (make-obsolete-variable 'multi-alist 'multi-mode-alist))

;; see the commentary below.
(defun multi-hack-local-variables ()
  "like `hack-local-variables', but ignore `mode' items."
  (let ((late-hack (symbol-function 'hack-one-local-variable)))
    (fset 'hack-one-local-variable
	  (lambda (var val)
	    (unless (eq var 'mode)
	      (funcall late-hack var val))))
    (unwind-protect
	(hack-local-variables)
      (fset 'hack-one-local-variable late-hack))))

(defun multi-install-mode (mode &optional chunk-fn base)
  "add mode to the multiple major modes supported by the current buffer.
chunk-fn, if non-nil, is a function to select the mode of a chunk,
added to the list `multi-chunk-fns'.  base non-nil means that this
is the base mode."
  (unless (memq mode multi-indirect-buffers-alist) ; be idempotent
    ;; this is part of a grim hack for lossage in auctex, which
    ;; bogusly advises `hack-one-local-variable'.  this loses, due to
    ;; the way advice works, when we run `multi-hack-local-variables'
    ;; below -- there ought to be a way round this, probably with cl's
    ;; flet.  any subsequent use of it then fails because advice has
    ;; captured the now-unbound variable `late-hack'...  thus ensure
    ;; we've loaded the mode in advance to get any autoloads sorted
    ;; out.  do it generally in case other modes have similar
    ;; problems.  [the auctex stuff is in support of an undocumented
    ;; feature which is unnecessary and, anyway, wouldn't need advice
    ;; to implement.  unfortunately the maintainer seems not to
    ;; understand the local variables mechanism and wouldn't remove
    ;; this.  to invoke minor modes, you should just use `mode:' in
    ;; `local variables'.]
    (if (eq 'autoload (car-safe (indirect-function mode)))
	(with-temp-buffer
	  (insert "local variables:\nmode: fundamental\nend:\n")
	  (funcall mode)
	  (hack-local-variables)))
    (let ((new-buffer (if base
			  (current-buffer)
			;; perhaps the name uniquification should use
			;; the mode name somehow (without getting long).
			(make-indirect-buffer (current-buffer)
					      (generate-new-buffer-name
					       (buffer-name))))))
      (with-current-buffer (multi-base-buffer)
	(push (cons mode new-buffer) multi-indirect-buffers-alist)
	(let ((alist multi-indirect-buffers-alist)
	      (hook multi-indirect-buffer-hook)
	      (fns (if chunk-fn
		       (add-to-list 'multi-chunk-fns chunk-fn)
		     multi-chunk-fns))
	      (alist2 multi-mode-alist)
	      (file (buffer-file-name))
	      (base-name (buffer-name))
	      (coding buffer-file-coding-system)
	      (multi-mode t))	       ; the modes might examine this.
	  (with-current-buffer new-buffer
	    (unless (and base (eq mode major-mode))
	      (funcall mode))
	    ;; now we can make it local:
	    (set (make-local-variable 'multi-mode) t)
	    ;; use file's local variables section to set variables in
	    ;; this buffer.  (don't just copy local variables from the
	    ;; base buffer because it may have set things locally that
	    ;; we don't want in the other modes.)  we need to prevent
	    ;; `mode' being processed and re-setting the major mode.
	    ;; it all goes badly wrong if `hack-one-local-variable' is
	    ;; advised.  the appropriate mechanism to get round this
	    ;; appears to be `ad-with-originals', but we don't want to
	    ;; pull in the advice package unnecessarily.  `flet'-like
	    ;; mechanisms lose with advice because `fset' acts on the
	    ;; advice anyway.
	    (if (featurep 'advice)
		(ad-with-originals (hack-one-local-variable)
		  (multi-hack-local-variables))
	      (multi-hack-local-variables))
	    ;; indentation should first narrow to the chunk.  modes
	    ;; should normally just bind `indent-line-function' to
	    ;; handle indentation.
	    (when indent-line-function ; not that it should ever be nil...
	      (set (make-local-variable 'indent-line-function)
		   `(lambda ()
		      (save-restriction
			(multi-narrow-to-chunk)
			(,indent-line-function)))))
	    ;; now handle the case where the mode binds tab directly.
	    ;; bind it in an overriding map to use the local definition,
	    ;; but narrowed to the chunk.
	    (let ((tab (local-key-binding "\t")))
	      (when tab
		(make-local-variable 'minor-mode-map-alist)
		(push (cons multi-mode
			    (let ((map (make-sparse-keymap)))
			      (define-key map "\t"
				`(lambda ()
				   (interactive)
				   (save-restriction
				     (multi-narrow-to-chunk)
				     (call-interactively ',tab))))
			      map))
		      minor-mode-map-alist)))
	    (setq multi-normal-fontify-function
		  font-lock-fontify-region-function)
	    (set (make-local-variable 'font-lock-fontify-region-function)
		 #'multi-fontify-region)
	    (setq multi-normal-fontify-functions fontification-functions)
	    (setq fontification-functions '(multi-fontify))
	    ;; don't let parse-partial-sexp get fooled by syntax outside
	    ;; the chunk being fontified.  (not in emacs 21.)
	    (set (make-local-variable 'font-lock-dont-widen) t)
	    (setq multi-late-index-function imenu-create-index-function)
	    (setq imenu-create-index-function #'multi-create-index
		  multi-indirect-buffer-hook hook)
	    ;; kill the base buffer along with the indirect one; careful not
	    ;; to infloop.
	    (add-hook 'kill-buffer-hook
		      '(lambda ()
			 (setq kill-buffer-hook nil)
			 (kill-buffer (buffer-base-buffer)))
		      t t)
	    ;; this should probably be at the front of the hook list, so
	    ;; that other hook functions get run in the (perhaps)
	    ;; newly-selected buffer.
	    (add-hook 'post-command-hook 'multi-select-buffer nil t)
	    ;; avoid the uniqified name for the indirect buffer in the
	    ;; mode line.
	    (setq mode-line-buffer-identification
		  (propertized-buffer-identification base-name))
	    ;; fixme: are there other things to copy?
	    (setq buffer-file-coding-system coding)
	    ;; for benefit of things like vc
	    (setq buffer-file-name file)
	    (vc-find-file-hook))
	  ;; propagate updated values of the relevant buffer-local
	  ;; variables to the indirect buffers.
	  (dolist (x alist)
	    (if (car x)
		(with-current-buffer (cdr x)
		  (setq multi-chunk-fns fns)
		  (setq multi-indirect-buffers-alist alist)
		  (setq multi-mode-alist alist2)
		  (run-hooks 'multi-indirect-buffer-hook)))))))))

(defun multi-map-over-chunks (beg end thunk)
  "for all chunks between beg and end, execute thunk.
thunk is a function of no args.  it is executed with point at the
beginning of the chunk and with the buffer narrowed to the chunk."
  (save-excursion
    (save-window-excursion
      (goto-char beg)
      (while (< (point) end)
	(multi-select-buffer)
	(save-restriction
	  (multi-narrow-to-chunk)
	  (funcall thunk)
	  (goto-char (point-max)))
	(unless (multi-next-chunk-start)
	  (goto-char (point-max)))))))

;; we need this for asynchronous fontification by jit-lock, even
;; though we're redefining `fontification-functions'.
(defun multi-fontify-region (beg end loudly)
  "multi-mode font-lock fontification function.
fontifies chunk-by chunk within the region.
assigned to `font-lock-fontify-region-function'."
  (let* ((modified (buffer-modified-p))
	 (buffer-undo-list t)
	 (inhibit-read-only t)
	 (inhibit-point-motion-hooks t)
	 (inhibit-modification-hooks t)
	 deactivate-mark)
    (font-lock-unfontify-region beg end)
    (save-restriction
      (widen)
      (multi-map-over-chunks
       beg end (lambda ()
		 (if (and font-lock-mode font-lock-keywords)
		     (funcall multi-normal-fontify-function
			      (point-min) (point-max) loudly)))))
    ;; in case font-lock isn't done for some mode:
    (put-text-property beg end 'fontified t)
    (when (and (not modified) (buffer-modified-p))
      (set-buffer-modified-p nil))))

;; i'm not sure it's worth trying to support non-font-lock
;; fontification functions like this (see this file's commentary).
(defun multi-fontify (start)
  "multi-mode fontification function.
fontifies chunk-by-chunk within the region from start for up to
`multi-fontification-chunk-size' characters."
  (save-restriction
    (multi-narrow-to-chunk)
    (run-hook-with-args 'multi-normal-fontify-functions start)))

(defun multi-create-index ()
  "create imenu index alist for the currently-selected buffer.
works piece-wise in all the chunks with the same major mode.
assigned to `imenu-create-index-function'."
  (let ((selected-mode major-mode)
	imenu-alist			; accumulator
	last mode)
    (multi-map-over-chunks
     (point-min) (point-max)
     (lambda ()
       (if (eq major-mode selected-mode)
	   ;; index this chunk and merge results with accumulator.
	   (dolist (elt (funcall multi-late-index-function))
	     (if (not (listp (cdr elt)))
		 (push elt imenu-alist)	; normal element
	       (let ((elt2 (assoc (car elt) imenu-alist))) ; submenu
		 ;; fixme: assumes only a single level of submenu.
		 (if elt2
		     (setcdr elt2 (append (cdr elt) (cdr elt2)))
		   (push elt imenu-alist))))))))
    imenu-alist))

(defun multi-next-chunk-start ()
  "move to the start of the next chunk."
  (widen)
  (goto-char (nth 2 (multi-find-mode-at)))
  (unless (eobp)
    (forward-char)
    t))

(eval-when-compile (defvar syntax-ppss-last))

(defun multi-narrow-to-chunk ()
  "narrow to the current chunk."
  (interactive)
  (if (boundp 'syntax-ppss-last)
      (setq syntax-ppss-last nil))
  (unless (= (point-min) (point-max))
    (apply #'narrow-to-region (cdr (multi-find-mode-at)))))

(defun multi-select-buffer ()
  "select the appropriate (indirect) buffer corresponding to point's context."
  ;; it may help to catch errors here.  if there are context-dependent
  ;; errors, it may well work correctly when point changes, but if it
  ;; gets an error, it will be removed from post-command-hook and there
  ;; won't be useful debugging context anyway.
  (condition-case ()
      (let ((buffer (cdr (assoc (car (multi-find-mode-at))
				multi-indirect-buffers-alist))))
	(unless (eq buffer (current-buffer))
	  (let* ((point (point))
		 (window-start (window-start))
		 (visible (pos-visible-in-window-p))
		 (oldbuf (current-buffer)))
	    (when (buffer-live-p buffer)
	      (switch-to-buffer buffer)
	      (bury-buffer oldbuf)
	      (goto-char point)
	      ;; avoid the display jumping around.
	      (when visible
		(set-window-start (get-buffer-window buffer t) window-start))
	      (unless (eq buffer oldbuf)
		(run-hooks 'multi-select-mode-hook))))))
    (error nil)))

(defvar multi-mode-list (list t t t))

(defsubst multi-make-list (mode start end)
  "constructor for lists returned by elements of `multi-chunk-fns' &c.
destructively modifies `multi-mode-list' to avoid consing in
`post-command-hook'."
  (setcar multi-mode-list mode)
  (setcar (cdr multi-mode-list) start)
  (setcar (cddr multi-mode-list) end)
  multi-mode-list)

;; it would be nice to cache the results of this on text properties,
;; but that probably won't work well if chunks can be nested.  in that
;; case, you can't just mark everything between delimiters -- you have
;; to consider other possible regions between them.  for now, we do
;; the calculation each time, scanning outwards from point.
(defun multi-find-mode-at (&optional pos)
  "apply elements of `multi-chunk-fns' to determine major mode at pos.
return a list (mode start end), the value returned by the function in the
list for which start is closest to pos (and before it); i.e. the innermost
mode is selected.  pos defaults to point."
  (let ((fns multi-chunk-fns)
	(start (point-min))
	(mode (with-current-buffer (multi-base-buffer)
		major-mode))
	(end (point-max))
	(pos (or pos (point)))
	val)
    (save-restriction
      (widen)
      (dolist (fn multi-chunk-fns)
	(setq val (funcall fn pos))
	(if (and val (or (not mode)
			 (>= (nth 1 val) start)))
	    (setq mode (nth 0 val)
		  start (nth 1 val)
		  end (nth 2 val)))))
    (unless (and (<= start end) (<= pos end) (>= pos start))
      (error "bad multi-mode selection: %s, %s"
	     (multi-make-list mode start end) pos))
    (if (= start end)
	(setq end (1+ end)))
    (multi-make-list mode start end)))

;; this was basically for testing, and isn't a reasonable thing to use
;; otherwise.

;; (define-derived-mode multi-mode fundamental-mode ""
;;   "pseudo major mode controlling multiple major modes apparently in a buffer.
;; actually maintains multiple views of the data in indirect buffers and
;; switches between them according to the context of point with a post-command
;; hook.  depends on a specification of `multi-mode-alist' in file variables."
;;   ;; we need to do the work after file variables have been processed so
;;   ;; that we can use a specification of `multi-mode-alist'.
;;   (set (make-local-variable 'hack-local-variables-hook)
;;        #'multi-mode-install-modes))

(defun multi-mode-install-modes ()
  "process `multi-mode-alist' and create the appropriate buffers."
  (if multi-mode-alist
      (let ((elt (pop multi-mode-alist)))
	(multi-install-mode (car elt) (cdr elt) t)
	(dolist (elt multi-mode-alist)
	  (multi-install-mode (car elt) (cdr elt))))
    (fundamental-mode)
    (error "`multi-mode-alist' not defined for multi-mode")))

;; in 21.3, flyspell breaks things, apparently by getting an error in
;; post-command-hook and thus clobbering it.  in development code it
;; doesn't do that, but does check indirect buffers it shouldn't.  i'm
;; not sure exactly how this happens, but checking flyspell-mode in
;; the hook functions cures this.  for the moment, we'll hack this up.
;; (let's not bring advice into it...)
(eval-after-load "flyspell"
  '(progn
     (defalias 'flyspell-post-command-hook
       `(lambda ()
	  ,(concat (documentation 'flyspell-post-command-hook)
		   "\n\n[wrapped by multi-mode.]")
	  (if flyspell-mode
	   (funcall ,(symbol-function 'flyspell-post-command-hook)))))

     (defalias 'flyspell-pre-command-hook
       `(lambda ()
	  (concat (documentation 'flyspell-pre-command-hook)
		  "\n\n[wrapped by multi-mode.]")
	  (if 'flyspell-mode
	      (funcall ,(symbol-function 'flyspell-pre-command-hook)))))))

;; this is useful in composite modes to determine whether a putative
;; major mode is safe to invoke.
(defun multi-mode-major-mode-p (value)
  "heuristic for value being a symbol naming a major mode.
checks whether the symbol's documentation string starts with
\"major mode \"."
  (and (symbolp value) (fboundp value)
       (let ((doc (documentation value)))
	 (and doc (string-match "\\`major mode " doc) t))))
(provide 'multi-mode)

;;; multi-mode.el ends here
