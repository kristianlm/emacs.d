;;; Make your 'thetas' and friends look like real Greek symbols.
;;; enable/disable with 'greek-minor-mode'. This was an experiment,
;;; it hasn't been tested at all.
;;;
;;; You can also try PrettyGreek:
;;; http://www.emacswiki.org/emacs/PrettyGreek
;;; which will give you more letters and is more versatile,
;;; but I don't know if it'll give you capital and lower-case.
;;;

;; char is value of greek letter in the
;; greek-iso8859-7 greek alphabet.
(defconst greek-symbols
   '(("delta" 100)
     ("Delta" 68)
     ("DELTA" 68)
           
     ("theta" 104)
     ("Theta" 72)
     ("THETA" 72)

     ("omega" 121)
     ("Omega" 89)
     ("OMEGA" 89)

     ("sigma" 115)
     ("Sigma" 83)
     ("SIGMA" 83)))

;; create a keyword spec alist
(defun greek-symbols-keyword-replace (symbol-string greek-char)
  `((,(concat "\\(" symbol-string "\\>\\)")
          (0 (progn
               (compose-region (match-beginning 1) (match-end 1)
                               ,(make-char 'greek-iso8859-7 greek-char))
               nil)))))

(defun font-lock-add-greek-letter (symbol-string greek-char)
  (font-lock-add-keywords nil (greek-symbols-keyword-replace symbol-string greek-char)))

(defun font-lock-remove-greek-letter (symbol-string greek-char)
  (font-lock-remove-keywords nil (greek-symbols-keyword-replace symbol-string greek-char)))

(defun greek-symbols ()
  (mapcar
   (lambda (greek-tuple)
     (apply (if greek-minor-mode
                'font-lock-add-greek-letter
              'font-lock-remove-greek-letter)
            greek-tuple))
   greek-symbols)
  ;; clear any symbol left-overs
  ;; these should be re-symbolized if enabled
  (remove-text-properties (point-min) (point-max) '(composition nil)))

(define-minor-mode greek-minor-mode
  "Replace your strings 'theta' and friends with their greek symbols."
  :lighter " greek"
  (greek-symbols))


