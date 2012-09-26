(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)


(load-file "~/.emacs.d/custom/colortheme-railscasts.el")

; iedit replace feature
(load-file "~/.emacs.d/custom/iedit.el")
(define-key global-map (kbd "C-;") 'iedit-mode)


; document editing for racket (don't think i'm gonna be using this, though)
;(load-file "~/.racket/planet/300/5.2/cache/neil/scribble-emacs.plt/1/2/scribble.el")


;(load-file "~/.emacs.d/geiser/elisp/geiser.el")
;(require 'geiser)
;(setq geiser-mode-smart-tab-p t)

; quack should be loaded after geiser
(load-file "~/.emacs.d/custom/quack.el")

; I want to enable 'esk-paren-face' for list-modes, so that parens
; don't stand out so much.
(font-lock-add-keywords
 'scheme-mode
 '(("(\\|)" . 'esk-paren-face)))

(font-lock-add-keywords
 'lisp-mode
 '(("(\\|)" . 'esk-paren-face)))

(font-lock-add-keywords
 'emacs-lisp-mode
 '(("(\\|)" . 'esk-paren-face)))
(put 'dired-find-alternate-file 'disabled nil)


(load-file "~/.emacs.d/custom/window-numbering.el")
(window-numbering-mode 1)



;load custom faces from a different file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(put 'ido-exit-minibuffer 'disabled nil)

;; http://synthcode.com/wiki/scheme-complete
(require 'scheme-complete)
(autoload 'scheme-smart-complete "scheme-complete" nil t)
(eval-after-load 'scheme
  '(define-key scheme-mode-map "\t" 'scheme-complete-or-indent))

;(setq lisp-indent-function 'scheme-smart-indent-function)






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


