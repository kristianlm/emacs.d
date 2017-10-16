
;; hide tutorial
(setq inhibit-startup-message t)


(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(load-file "~/.emacs.d/custom/colortheme-railscasts.el")
(load-file "~/.emacs.d/custom/dired-sort-criteria.el")

(require 'ido)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(ido-mode t)

;;
(setq mouse-yank-at-point t)



;;(require 'ido-better-flex)
;;(ido-better-flex/enable)


;; never require "yes", "y" should be enough
;; http://www.emacswiki.org/emacs/YesOrNoP
(defalias 'yes-or-no-p 'y-or-n-p)

;; for ido-mode on M-X
;; (global-set-key (kbd "M-x") 'smex)


; iedit replace feature
(load-file "~/.emacs.d/custom/iedit.el")
(define-key global-map (kbd "C-;") 'iedit-mode)


; document editing for racket (don't think i'm gonna be using this, though)
;(load-file "~/.racket/planet/300/5.2/cache/neil/scribble-emacs.plt/1/2/scribble.el")


;(load-file "~/.emacs.d/geiser/elisp/geiser.el")
;(require 'geiser)
;(setq geiser-mode-smart-tab-p t)

; quack should be loaded after geiser
;;(load-file "~/.emacs.d/custom/quack.el")

(require 'quack)

(put 'dired-find-alternate-file 'disabled nil)


(load-file "~/.emacs.d/custom/window-numbering.el")
(window-numbering-mode 1)


(put 'dired-find-alternate-file 'disabled nil)


;load custom faces from a different file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(put 'ido-exit-minibuffer 'disabled nil)

;; http://stackoverflow.com/questions/17986194/emacs-disable-automatic-file-search-in-ido-mode
;; don't automatically search in other directories. because that's stupid.
(setq ido-auto-merge-work-directories-length -1)

;; icicles for minibuffer completion

;; (require 'icicles)
;; (setq icicle-buffer-include-recent-files-nflag 1)
;; (icy-mode 1)

;; http://synthcode.com/wiki/scheme-complete
;;(require 'scheme-complete)
;;(autoload 'scheme-smart-complete "scheme-complete" nil t)

(eval-after-load 'scheme
  '(define-key scheme-mode-map "\t" 'scheme-complete-or-indent))



(defun fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_FULLSCREEN" 0)))

;; doesnt work:
(add-hook 'server-visit-hook
          '(lambda ()
             (message "run hook") (set-cursor-color "#FF55FF")))
(add-hook 'server-done-hook
          '(lambda ()
             (message "server is done")))
(add-hook 'server-switch-hook
          '(lambda ()
             (message "server switch hook")))

(set-face-attribute 'cursor nil :background "#FF55FF")





;; Added by peder
;;(set-face-attribute 'default nil :family "Inconsolata" :height 80)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


;; slime for chicken
;;(add-to-list 'load-path "/home/klm/opt/slime-2012-06-12/")
;;(add-to-list 'load-path "/home/klm/opt/slime-2012-06-12/contrib/")
;;(add-to-list 'load-path "/home/klm/opt/slime-2012-11-03/")
;;(add-to-list 'load-path "/home/klm/opt/slime-2012-11-03/contrib/")

;;(require 'slime-autoloads)
;;(require 'slime)

;;(slime-setup '(slime-fancy
;;               slime-fuzzy))



;; automatically associate scheme mode with slime-mode
;; (add-hook 'scheme-mode-hook (lambda () (slime-mode nil)))

; allows undoing of window setup
(winner-mode 1)
;;; **** dedicated window toggle
(defun toggle-current-window-dedication ()
  (interactive)
  (let* ((window    (selected-window))
         (dedicated (window-dedicated-p window)))
    (set-window-dedicated-p window (not dedicated))
    (message "Window %sdedicated to %s"
             (if dedicated "no longer " "")
             (buffer-name))))

(global-set-key [pause] 'toggle-current-window-dedication)

;; my very own elisp!
(progn
  (global-set-key (kbd "C-S-n") (lambda () (interactive) (scroll-up 4)))
  (global-set-key (kbd "C-S-p") (lambda () (interactive) (scroll-up -4)))

  ;; these don't work
  (global-set-key (kbd "C-S-f") (lambda () (interactive) (scroll-left 4)))
  (global-set-key (kbd "C-S-b") (lambda () (interactive) (scroll-right 4))))

(global-set-key (kbd "C-c g") 'magit-status)

;; switch between header and source file
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key (kbd "C-c o") 'ff-find-other-file)))

;;(require 'chicken-scheme)
(load-file "~/.emacs.d/custom/chicken.el")
;;(add-hook 'scheme-mode-hook 'chicken-scheme-hook)

;; (remove-hook 'inferior-scheme-mode-hook 'chicken-scheme-hook)

(require 'parenface)
(global-paren-face-mode t)

;; enable paredit for my lisps
(progn
  (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
  (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
  (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
  (add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
  (add-hook 'clojure-mode-hook          (lambda () (paredit-mode +1))))


(progn
  ;; change window size (from emacswiki)
  (global-set-key (kbd "S-C-<left>") (lambda () (interactive) (shrink-window-horizontally 3)))
  (global-set-key (kbd "S-C-<right>") (lambda () (interactive) (enlarge-window-horizontally 3)))
  (global-set-key (kbd "S-C-<down>") (lambda () (interactive) (shrink-window 3)))
  (global-set-key (kbd "S-C-<up>") (lambda () (interactive) (enlarge-window 3))))


(setq jabber-account-list
    '(("kristian@adellica.com"
       (:network-server . "talk.google.com")
       (:connection-type . ssl))))

;; using hippie instead of dabbrev-expand, lets see how it goes
(global-set-key "\M-/" 'hippie-expand)

;; load rudel autoloads (custom)
;; (load-file "~/.emacs.d/custom/rudel-0.2-4/rudel-loaddefs.el")

;; (require 'ac-nrepl)
;; (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
;; (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)

;; (eval-after-load "auto-complete"
;;   '(add-to-list 'ac-modes 'nrepl-mode))


;;(load-file "/home/klm/.emacs.d/custom/auto-complete-init.el")
;;(load-file "/home/klm/.emacs.d/elpa/auto-complete-1.4/auto-complete-config.el")

;; highlight symbol-at-point and search for them
(require 'highlight-symbol)

(global-set-key (kbd "C-c M-N") 'highlight-symbol-at-point)
(global-set-key (kbd "M-N") 'highlight-symbol-next)
(global-set-key (kbd "M-P") 'highlight-symbol-prev)

;; all of a sudden, I need to do this:
(require 'scheme-complete)
;; nobody knows why

(add-to-list 'load-path "~/opt/ledger/lisp/")
(require 'ledger)
(add-to-list 'auto-mode-alist '("\\.ledger\\'" . ledger-mode))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(custom-set-variables  
 '(js2-basic-offset 2)  
 '(js2-bounce-indent-p t))

(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)


;; ;; ;;(set-frame-font "Inconsolata:pixelsize=12:spacing=110")
;; ;; (set-frame-font "Bitstream Vera Sans Mono:pixelsize=10")
;; (set-frame-font "Droid Sans Mono-9")
;; (set-frame-font "Terminus-10")
;; (set-frame-font "Inconsolata-9")



(setq pop-up-windows nil)

(global-set-key (kbd "s-b") 'recompile)


;;; ****** multiple cursors
(require 'multiple-cursors)
;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-symbol-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-symbol-like-this)
(global-set-key (kbd "C-M->") 'mc/unmark-next-like-this)
(global-set-key (kbd "C-M-<") 'mc/unmark-previous-like-this)

;; this did not work
;;(add-to-list 'tramp-default-proxies-alist '(".*" "\`root\'" "/ssh:%h:"))



(require 'js-comint)
(setq inferior-js-program-command "mongo")
(add-hook 'js2-mode-hook '(lambda ()
			    (local-set-key "\C-x\C-e" 'js-send-last-sexp)
			    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
			    (local-set-key "\C-cb" 'js-send-buffer)
			    (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
			    (local-set-key "\C-cl" 'js-load-file-and-go)
			    ))

;; quick access to imeny
(global-set-key (kbd "C-S-i") 'imenu-anywhere)

(global-set-key (kbd "s-a") 'kmacro-start-macro-or-insert-counter)
(global-set-key (kbd "s-s") 'kmacro-end-or-call-macro)

(global-set-key (kbd "C-x C-b") 'ibuffer)
;;(setenv "PATH" (concat "/home/klm/opt/android-chicken/build/host/bin/" ":" (getenv "PATH")))


;; expand region
(global-set-key (kbd "C-=") 'er/expand-region)

;; for cleanup-buffer (magnars)
(load-file "/home/klm/.emacs.d/defuns/buffer-defuns.el")

(global-set-key (kbd "C-c C-r") 'rename-sgml-tag)


(add-hook 'html-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-M-S-B") 'sgml-skip-tag-backward)
             (local-set-key (kbd "C-M-S-F") 'sgml-skip-tag-forward)

             (local-set-key (kbd "C-M-b") 'paredit-forward)
             (local-set-key (kbd "C-M-f") 'paredit-backward)

             (define-key html-mode-map (kbd "C-M-f") 'paredit-forward)
             (define-key html-mode-map (kbd "C-M-b") 'paredit-backward)

             (define-key sgml-mode-map (kbd "C-M-f") 'paredit-forward)
             (define-key sgml-mode-map (kbd "C-M-b") 'paredit-backward)))

;; I need my C-x C-j!
(require 'dired)

;; meta-( will open and wrap paren
(require 'paredit)
(global-set-key (kbd "C-x C-j") 'dired-jump)
(eval-after-load "paredit"
  '(define-key paredit-mode-map (kbd "M-(") '(lambda () (interactive) (paredit-open-parenthesis 1))))

(global-set-key (kbd "C-c C-t") 'toggle-truncate-lines)

(global-set-key (kbd "C-S-k") 'kill-whole-line)

(global-set-key (kbd "C-x C-d") 'ido-dired)


(require 'repository-root)
(require 'grep-o-matic)



;;(add-hook 'js-mode-hook (lambda () (paredit-mode +1)))
(setq js-indent-level 2)

(defun js-space-for-delimiter-p (endp delimiter)
  (not (eq major-mode 'js-mode)))

(defvar paredit-space-for-delimiter-predicates nil)
(add-to-list 'paredit-space-for-delimiter-predicates
             'js-space-for-delimiter-p)


;; ==================== stolen from stackooverflow
;; http://stackoverflow.com/questions/10627289/emacs-internal-process-killing-any-command
(define-key process-menu-mode-map (kbd "C-k") 'joaot/delete-process-at-point)
(defun joaot/delete-process-at-point ()
  (interactive)
  (let ((process (get-text-property (point) 'tabulated-list-id)))
    (cond ((and process (processp process))
           (kill-process process)
           (sleep-for 0.1)
           (revert-buffer))
          (t (error "no process at point!")))))
;; ====================


(put 'erase-buffer 'disabled nil)

;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
;; (remove-hook 'before-save-hook 'delete-trailing-whitespace)

;; turn idle-highlight on for any code
(add-hook 'prog-mode-hook 'idle-highlight-mode)

(setq-default indent-tabs-mode nil)

(setq
 backup-by-copying t ;; don't clobber symlinks
 backup-directory-alist '(("." . "~/.saves")) ;; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t) ;; use versioned backups


;; http://www.reddit.com/r/emacs/comments/21a4p9/use_recentf_and_ido_together/
(setq ido-use-virtual-buffers t)

;; color compilation buffer too
;; http://stackoverflow.com/questions/3072648/cucumbers-ansi-colors-messing-up-emacs-compilation-buffer
(require 'ansi-color)
(defun my-colorize-compilation-buffer ()
  (when (eq major-mode 'compilation-mode)
    (ansi-color-apply-on-region compilation-filter-start (point-max))))
(add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer)


;; pretty lambda

(require 'pretty-lambdada)
(pretty-lambda-for-modes)



;; bb mode
(add-to-list 'auto-mode-alist '("\\.bb\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.bbappend\\'" . conf-mode))

;;(require 'ws-trim)
;;(setq ws-trim-level 1)
;;(global-ws-trim-mode t)

;; Nevermind redspace. It's too intrusive, it colors my inferior
;; buffers, my command-lines and stuff. It's much better to be able to
;; ws-trim inside the magit buffer like below!
;;
;;(load-file "~/.emacs.d/redspace.el")
;;(redspace-mode t)

;; I actually understand this. This is probably the most amazing
;; snippet of code I've come across this month.
;;
;; https://stackoverflow.com/questions/20127377/how-can-i-remove-trailing-whitespace-from-a-hunk-in-magit
(defun my-magit-delete-trailing-whitespace ()
  "Remove whitespace from the current file."
  (interactive)
  (save-excursion
    (magit-diff-visit-file-worktree (magit-file-at-point))
    (magit-section-value (magit-current-section))
    ;;(ws-trim-line nil)
    ;;() (delete-trailing-whitespace)
    ;;(count-words-region)
    (save-buffer)
    (kill-buffer))
  (magit-refresh))

;; easyily allow trimming lines inside magit diffs! yey!
(add-hook 'magit-status-mode-hook
 (lambda ()
   (local-set-key [deletechar] 'my-magit-delete-trailing-whitespace)))

