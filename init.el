
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)


(load-file "~/.emacs.d/custom/colortheme-railscasts.el")
(load-file "~/.emacs.d/custom/dired-sort-criteria.el")

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

(put 'dired-find-alternate-file 'disabled nil)


(load-file "~/.emacs.d/custom/window-numbering.el")
(window-numbering-mode 1)



;load custom faces from a different file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(put 'ido-exit-minibuffer 'disabled nil)



;;let's use marmelade instead :)
;;(load-file "~/.emacs.d/custom/chicken-scheme.el/chicken-scheme.el")
;;(require 'chicken-scheme)


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

(load-file "~/.emacs.d/custom/chicken.el")

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

  (global-set-key (kbd "C-S-f") (lambda () (interactive) (scroll-left 4)))
  (global-set-key (kbd "C-S-b") (lambda () (interactive) (scroll-right 4))))

(global-set-key (kbd "C-c g") 'magit-status)

;; switch between header and source file
(add-hook 'c-mode-common-hook
  (lambda() 
    (local-set-key (kbd "C-c o") 'ff-find-other-file)))


;; doesn't seem to work, need to re-enable scheme mode
(require 'parenface)

;; disable default show-paren-mode because
;; I want to try highlight-parenthesis-mode instead
;; (show-paren-mode -1)

;; enable highlight parenthesis mode for our lisp modes
(add-hook 'scheme-mode-hook           (lambda () (highlight-parentheses-mode t)))
(add-hook 'lisp-mode-hook             (lambda () (highlight-parentheses-mode t)))
(add-hook 'emacs-lisp-mode-hook       (lambda () (highlight-parentheses-mode t)))
(add-hook 'lisp-interaction-mode-hook (lambda () (highlight-parentheses-mode t)))

;; enable paredit for my lisps
(progn
  (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
  (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
  (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
  (add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
  (add-hook 'clojure-mode-hook          (lambda () (paredit-mode +1))))

(let ((zebra 'stripes)
      (tiger 'fierce))
  (message "One kind of animal has %s and another is %s."
           zebra tiger))

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

(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)

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


(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)


;; ;; ;;(set-frame-font "Inconsolata:pixelsize=12:spacing=110")
;; ;; (set-frame-font "Bitstream Vera Sans Mono:pixelsize=10")
;; (set-frame-font "Droid Sans Mono-9")
;; (set-frame-font "Terminus-9")
;; (set-frame-font "Inconsolata-9")



