(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)


;load custom faces from a different file
(setq custom-file "~/.emacs.d/custom.el")
(load-file custom-file)

(load-file "~/.emacs.d/colortheme-railscasts.el")

; iedit replace feature
(load-file "~/.emacs.d/iedit.el")
(define-key global-map (kbd "C-;") 'iedit-mode)


; document editing for racket (don't think i'm gonna be using this, though)
(load-file "~/.racket/planet/300/5.2/cache/neil/scribble-emacs.plt/1/2/scribble.el")


(load-file "~/.emacs.d/geiser/elisp/geiser.el")
(require 'geiser)
(setq geiser-mode-smart-tab-p t)

; quack should be loaded after geiser
(load-file "~/.emacs.d/quack.el")

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


(set-face-attribute 'default nil :height 90)



