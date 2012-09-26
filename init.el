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





;; Added by peder
(set-face-attribute 'default nil :family "Inconsolata" :height 80)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


;; slime for chicken
(add-to-list 'load-path "/home/klm/opt/slime-2012-06-12/")
(add-to-list 'load-path "/home/klm/opt/slime-2012-06-12/contrib/")

(require 'slime-autoloads)
(require 'slime)

(slime-setup '(slime-fancy
               slime-fuzzy))

(load-file "~/.emacs.d/custom/chicken.el")

;; automatically associate scheme mode with slime-mode
(add-hook 'scheme-mode-hook
          (lambda ()
            (slime-mode t)))

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
