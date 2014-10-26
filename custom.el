
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method (quote pushy))
 '(ac-sources (quote (ac-source-abbrev ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-filename)) t)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(browse-url-browser-function (quote browse-url-chromium))
 '(calendar-week-start-day 1)
 '(custom-safe-themes (quote ("5e1d1564b6a2435a2054aa345e81c89539a72c4cad8536cfe02583e0b7d5e2fa" default)))
 '(display-buffer-reuse-frames t)
 '(ede-project-directories (quote ("/home/klm/opt/rudel")))
 '(highlight-symbol-idle-delay 0.1)
 '(hl-paren-background-colors (quote ("#452222")))
 '(ibuffer-saved-filter-groups nil)
 '(ibuffer-saved-filters (quote (("magits" ((mode . magit-status-mode))) ("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
 '(jabber-roster-line-format "%c %-25n %-30j %u %-8s  %S")
 '(ledger-reports (quote (("test.report" "ledger -f main.ledger balance") ("bal" "ledger -f %(ledger-file) bal") ("reg" "ledger -f %(ledger-file) reg") ("payee" "ledger -f %(ledger-file) reg -- %(payee)") ("account" "ledger -f %(ledger-file) reg %(account)"))))
 '(magit-status-buffer-switch-function (quote switch-to-buffer))
 '(menu-bar-mode nil)
 '(org-agenda-files (quote ("~/projects/chickmunk/todo.org" "/tmp/loo")))
 '(paren-mode (quote paren) nil (paren))
 '(quack-default-program "csi")
 '(quack-programs (quote ("nc localhost 9900" "./lambda-image" "./opencvt" "\\" "adb shell" "adb shell /cache/chicken/csi.sh" "adb shell LD_LIBRARY_PATH=. /cache/chicken/csi" "adb shell cat" "adb shell csi" "adb shell csi -:b" "adb shell csi -:c" "bash" "bigloo" "biwas" "cat" "cat" "chibi-scheme" "cocos2dx-csi" "csi" "csi -:c" "csi -R ../fxpoint.so" "csi -R mongo" "csi -e '(load \"mongo.so\")'" "csi -e '(load \"opencvt.so\") (repl)'" "csi -e [load \"opencvt.so\"] -e [repl]" "csi -hygienic" "csi -n" "csi -q" "csi -s \"biwascheme-server.scm\"" "csi -s \"opencvt.so\"" "gosh" "gracket" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "lush2" "mit-scheme" "my-csi -:b" "nc 10.0.0.16 5056" "nc 10.0.0.19 1234" "nc 10.0.0.2 1234" "nc 10.0.0.39 1234" "nc 10.0.0.4 1234" "nc 139.96.30.151 5056" "nc 192.168.0.186 5051" "nc 192.168.0.186 5056" "nc 192.168.1.7 1234" "nc 192.168.1.71234" "nc gpum 1234" "nc linux.local 5056" "nc localhost 1234" "nc localhost 5022" "nc localhost 5056" "nc localhost 8081" "nc ota1.ixionaudio.com 8081" "racket" "racket -il typed/racket" "rs" "run{csi | ./lambda-image | ./opencvt | \\ | adb shell | adb shell /cache/chicken/csi.sh | adb shell LD_LIBRARY_PATH=. /cache/chicken/csi | adb shell cat | adb shell csi | adb shell csi -:b | ...}" "scheme" "scheme48" "scsh" "sisc" "ssh pi csi" "ssh pi csi -:c" "ssh pi sudo csi -:c" "ssh sky csi" "ssh tradio.adellica.com" "stklos" "sudo csi" "sxi" "valgrind csi" "valgrindcsi" "xxd" "xxd -p" "~/opt/bootstrap-scheme/scheme" "~/opt/tinyscheme-1.4.0/scheme" "~/opt/tinyscheme-1.40/scheme" "~/prog/android/native-activity/headers/box2d-2.2.1/box2d-test.scm" "~/projects/lambda-image/lambda-image" "~/testing")))
 '(scroll-bar-mode nil)
 '(show-paren-delay 0)
 '(show-paren-mode t nil (paren))
 '(split-height-threshold 300)
 '(tool-bar-mode nil)
 '(tool-bar-position (quote right)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2b2b2b" :foreground "#bbbbbb" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 83 :width normal :foundry "unknown" :family "Terminus"))))
 '(diff-added ((t (:inherit diff-changed :foreground "green4"))))
 '(diff-header ((t (:foreground "#77e"))))
 '(diff-refine-added ((t (:inherit diff-refine-change :background "#223322"))))
 '(diff-refine-removed ((t (:inherit diff-refine-change :background "#332222"))))
 '(diff-removed ((t (:inherit diff-changed :foreground "red3"))))
 '(font-lock-string-face ((t (:background "#203528" :foreground "#a5c261"))))
 '(highlight ((t nil)))
 '(hl-line ((t (:inherit highlight))))
 '(idle-highlight ((t (:background "#305050"))))
 '(info-node ((t (:bold t :underline t :foreground "goldenrod"))))
 '(info-xref ((t (:foreground "#4444ee" :underline t :weight bold))))
 '(link ((t (:foreground "#5555ff" :underline t))))
 '(magit-diff-del ((t (:foreground "#ff3333"))))
 '(magit-diff-file-header ((t (:inherit magit-header :foreground "yellow"))))
 '(magit-diff-hunk-header ((t (:foreground "#7777ff" :slant italic))))
 '(magit-diff-none ((t (:foreground "grey40"))))
 '(magit-item-highlight ((t (:background "#303030"))))
 '(magit-log-graph ((t (:foreground "grey60"))))
 '(paren-face-match ((((class color)) (:background "green"))) t)
 '(paren-face-mismatch ((((class color)) (:foreground "white" :background "red"))) t)
 '(paren-match ((t (:background "green"))) t)
 '(paren-mismatch ((t (:background "red"))) t)
 '(quack-pltish-comment-face ((t (:foreground "#bc9458"))))
 '(quack-pltish-selfeval-face ((t (:background "#202835" :foreground "#3ae"))))
 '(region ((t (:background "#404080"))))
 '(ruler-mode-default ((t (:inherit default :background "grey30" :foreground "grey67" :box (:line-width 1 :color "grey40" :style released-button)))))
 '(shadow ((t (:foreground "grey50"))))
 '(show-paren-match ((t (:background "#214112" :foreground "#22FF22" :weight bold))))
 '(show-paren-mismatch ((((class color)) (:background "red")))))
