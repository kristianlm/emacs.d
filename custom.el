
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-chromium))
 '(ede-project-directories (quote ("/home/klm/opt/rudel")))
 '(hl-paren-background-colors (quote ("#452222")))
 '(magit-status-buffer-switch-function (quote switch-to-buffer))
 '(menu-bar-mode nil)
 '(paren-mode (quote paren) nil (paren))
 '(quack-default-program "csi")
 '(quack-programs (quote ("xxd -p" "adb shell /cache/chicken/csi.sh" "adb shell LD_LIBRARY_PATH=. /cache/chicken/csi" "bigloo" "cat" "cat" "csi" "csi -:c" "csi -hygienic" "gosh" "gracket" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "lush2" "mit-scheme" "my-csi -:b" "nc localhost 1234" "racket" "racket -il typed/racket" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi" "valgrind csi" "valgrindcsi" "xxd" "~/prog/android/native-activity/headers/box2d-2.2.1/box2d-test.scm" "~/testing")))
 '(scroll-bar-mode nil)
 '(show-paren-delay 0)
 '(show-paren-mode t nil (paren))
 '(tool-bar-mode nil)
 '(tool-bar-position (quote right)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#232323" :foreground "#e6e1de" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 83 :width normal :foundry "unknown" :family "inconsolata"))))
 '(diff-added ((t (:inherit diff-changed :foreground "green4"))))
 '(diff-header ((t (:foreground "#77e"))))
 '(diff-removed ((t (:inherit diff-changed :foreground "red3"))))
 '(font-lock-comment-face ((t (:foreground "#bc9458" :slant italic))))
 '(highlight ((t nil)))
 '(idle-highlight ((t (:background "#181818"))))
 '(info-node ((t (:bold t :underline t :foreground "goldenrod"))))
 '(info-xref ((t (:bold t :underline t :foreground "#0000ee"))))
 '(link ((t (:foreground "#5555ff" :underline t))))
 '(magit-diff-del ((t (:foreground "#ff3333"))))
 '(magit-diff-file-header ((t (:inherit magit-header :foreground "yellow"))))
 '(magit-diff-hunk-header ((t (:foreground "#7777ff" :slant italic))))
 '(magit-diff-none ((t (:foreground "grey40"))))
 '(magit-item-highlight ((t (:background "#303030"))))
 '(magit-log-graph ((t (:foreground "grey60"))))
 '(paren-face-match ((((class color)) (:background "green"))))
 '(paren-face-mismatch ((((class color)) (:foreground "white" :background "red"))))
 '(paren-match ((t (:background "green"))))
 '(paren-mismatch ((t (:background "red"))))
 '(quack-pltish-comment-face ((t (:foreground "#bc9458"))))
 '(quack-pltish-selfeval-face ((t (:background "#202835" :foreground "#3ae"))))
 '(region ((t (:background "#303040"))))
 '(shadow ((t (:foreground "grey50"))))
 '(show-paren-match ((t (:background "#214112" :foreground "#22FF22" :weight bold))))
 '(show-paren-mismatch ((((class color)) (:background "red")))))

