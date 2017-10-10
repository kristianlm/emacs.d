
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method (quote pushy))
 '(ac-sources
   (quote
    (ac-source-abbrev ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-filename)) t)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(browse-url-browser-function (quote browse-url-chromium))
 '(calendar-week-start-day 1)
 '(clojure-indent-style :always-indent)
 '(custom-safe-themes
   (quote
    ("5e1d1564b6a2435a2054aa345e81c89539a72c4cad8536cfe02583e0b7d5e2fa" default)))
 '(dired-listing-switches "-alh")
 '(display-buffer-reuse-frames t)
 '(ede-project-directories (quote ("/home/klm/opt/rudel")))
 '(fringe-mode (quote (1 . 1)) nil (fringe))
 '(highlight-symbol-idle-delay 0.1)
 '(hippie-expand-try-functions-list
   (quote
    (try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-complete-lisp-symbol-partially try-complete-lisp-symbol)))
 '(hl-paren-background-colors (quote ("#452222")))
 '(ibuffer-saved-filter-groups nil)
 '(ibuffer-saved-filters
   (quote
    (("magits"
      ((mode . magit-status-mode)))
     ("gnus"
      ((or
        (mode . message-mode)
        (mode . mail-mode)
        (mode . gnus-group-mode)
        (mode . gnus-summary-mode)
        (mode . gnus-article-mode))))
     ("programming"
      ((or
        (mode . emacs-lisp-mode)
        (mode . cperl-mode)
        (mode . c-mode)
        (mode . java-mode)
        (mode . idl-mode)
        (mode . lisp-mode)))))))
 '(indicate-buffer-boundaries (quote left))
 '(indicate-empty-lines t)
 '(inf-clojure-lein-cmd "lein figwheel")
 '(inf-clojure-program "lein figwheel")
 '(jabber-roster-line-format "%c %-25n %-30j %u %-8s  %S")
 '(js-indent-level 4)
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
 '(js2-strict-missing-semi-warning nil)
 '(ledger-reports
   (quote
    (("test.report" "ledger -f main.ledger balance")
     ("bal" "ledger -f %(ledger-file) bal")
     ("reg" "ledger -f %(ledger-file) reg")
     ("payee" "ledger -f %(ledger-file) reg -- %(payee)")
     ("account" "ledger -f %(ledger-file) reg %(account)"))))
 '(magit-diff-arguments nil)
 '(magit-status-buffer-switch-function (quote switch-to-buffer))
 '(menu-bar-mode nil)
 '(org-agenda-files (quote ("~/projects/chickmunk/todo.org" "/tmp/loo")))
 '(overflow-newline-into-fringe t)
 '(package-selected-packages
   (quote
    (gradle-mode less-css-mode glsl-mode markdown-preview-mode inf-clojure elm-mode fish-mode csharp-mode zen-and-art-theme yasnippet yaml-mode ws-trim web-mode thrift tagedit swiper smex smartparens slime-repl sibilant-mode scheme-complete restclient repository-root quack protobuf-mode pretty-lambdada php-extras parenface paren-face paredit org-present nodejs-repl nhexl-mode nginx-mode multiple-cursors mongo markdown-mode mark-multiple magit lua-mode lispyscript-mode jsshell js2-mode js-comint inf-ruby inf-php imenu-anywhere ido-ubiquitous ido-better-flex idle-highlight-mode idle-highlight icicles hl-sexp hippie-expand-slime highlight-symbol haskell-mode groovy-mode grep-o-matic fuzzy-match fringe-helper flx-ido find-file-in-project expand-region evil-nerd-commenter emacs-droid elisp-slime-nav dockerfile-mode color-theme-heroku cmake-mode clojurescript-mode chicken-scheme bookmark+ auto-complete ascope apache-mode android-mode ag)))
 '(paren-mode (quote paren) nil (paren))
 '(quack-default-program "csi")
 '(quack-programs
   (quote
    ("chibi-scheme -m gochan" "(cd ~/projects/anteo/usheet/ && csi usheet.scm ./db 9080 ./usheet)" "./geotest" "./geotest 1" "./lambda-image" "./opencvt" "/home/klm/chicken-5/bin/csi -n" "/home/klm/cube/aosp.new/out/host/linux-x86/bin/adb" "/home/klm/cube/aosp.new/out/host/linux-x86/bin/adb shell" "/opt/chicken5/bin/csi" "/opt/chicken5/bin/csi -n" "10066" "\\" "adb shell" "adb shell /cache/chicken/csi.sh" "adb shell LD_LIBRARY_PATH=. /cache/chicken/csi" "adb shell cat" "adb shell csi" "adb shell csi -:b" "adb shell csi -:c" "bash" "bigloo" "biwas" "cat" "cat" "cat" "cd ~/projects/anteo/usheet/ && csi usheet.scm ./db 9080 ./usheet" "chibi-scheme" "chibi-scheme -R" "cis" "cocos2dx-csi" "csi" "csi -:c" "csi -R ../fxpoint.so" "csi -R mongo" "csi -e '(load \"mongo.so\")'" "csi -e '(load \"opencvt.so\") (repl)'" "csi -e [load \"opencvt.so\"] -e [repl]" "csi -hygienic" "csi -n" "csi -q" "csi -s \"biwascheme-server.scm\"" "csi -s \"opencvt.so\"" "csi -s mmsi.scm" "csi -s ~/projects/anteo/usheet/usheet.scm" "csi /tmp/glls/examples/interactive.scm" "csi /tmp/glls/interactive.scm" "csi tileproxy.scm" "gosh" "gracket" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "lush2" "mit-scheme" "my-csi -:b" "nc 10.0.0.16 5056" "nc 10.0.0.19 1234" "nc 10.0.0.2 1234" "nc 10.0.0.39 1234" "nc 10.0.0.4 1234" "nc 10.16.8.20 1234" "nc 127.0.0.1 1234" "nc 139.96.30.151 5056" "nc 192.16.8.0.186 5056" "nc 192.168.0.10 1234" "nc 192.168.0.124 5056" "nc 192.168.0.128 5056" "nc 192.168.0.138 5056" "nc 192.168.0.14 1234" "nc 192.168.0.173 5056" "nc 192.168.0.18 1234" "nc 192.168.0.182 5056" "nc 192.168.0.183 1234" "nc 192.168.0.184 1234" "nc 192.168.0.1841234" "nc 192.168.0.186 1234" "nc 192.168.0.186 5051" "nc 192.168.0.186 5056" "nc 192.168.0.19 1234" "nc 192.168.0.20 1234" "nc 192.168.0.222 1234" "nc 192.168.0.222 5056" "nc 192.168.0.235 5056" "nc 192.168.0.236 5056" "nc 192.168.0.244 5056" "nc 192.168.0.2445056" "nc 192.168.0.245 5056" "nc 192.168.1.136 1234" "nc 192.168.1.7 1234" "nc 192.168.1.71234" "nc 192.168.10.103 1234" "nc 192.168.38.103 1234" "nc 192.168.38.127 1234" "nc fp2 1234" "nc gpum 1234" "nc kth.local 8081" "nc kth.local 8091" "nc linux-2.local 1234" "nc linux-2.local 5056" "nc linux-2.local5056" "nc linux-2.local:5055" "nc linux.local 5056" "nc localhost 10066" "nc localhost 10119" "nc localhost 1234" "nc localhost 2023" "nc localhost 2345" "nc localhost 5022" "nc localhost 5056" "nc localhost 8081" "nc localhost 8091" "nc localhost 8181" "nc localhost 9081" "nc localhost 9900" "nc ota1.ixionaudio.com 8081" "nc raspberry 1234" "nc raspberrypi 1234" "nc raspberrypi.local 1234" "nc rpi3k.local 1234" "nc rpi3k.local1234" "netcat -v 192.168.10.103 1234" "racket" "racket -il typed/racket" "rlwrap netcat -v 192.168.10.103 1234" "rs" "run-sc" "run{csi | ./lambda-image | ./opencvt | \\ | adb shell | adb shell /cache/chicken/csi.sh | adb shell LD_LIBRARY_PATH=. /cache/chicken/csi | adb shell cat | adb shell csi | adb shell csi -:b | ...}" "scheme" "scheme48" "scsh" "sh -c \"(cd ~/projects/anteo/usheet/ && csi usheet.scm ./db 9080 ./usheet)\"" "sh -c \"stty -echo ; telnet --debug 192.168.0.183 1234\"" "sh -c \"stty -echo ; telnet --debug192.168.0.183 1234\"" "sh -c \"stty -echo ; telnet 192.168.0.183 1234\"" "sibilant" "sibilant --repl" "sisc" "ssh beta.anteo.no csi" "ssh beta.anteo.no nc localhost 5678" "ssh pi csi" "ssh pi csi -:c" "ssh pi sudo csi -:c" "ssh sky csi" "ssh tradio.adellica.com" "stklos" "stty -echo ; telnet 192.168.0.183 1234" "sudo csi" "sxi" "telnet 192.168.0.183 1234" "tinyscheme" "valgrind csi" "valgrindcsi" "xxd" "xxd -p" "~/opt/bootstrap-scheme/scheme" "~/opt/tinyscheme-1.4.0/scheme" "~/opt/tinyscheme-1.40/scheme" "~/prog/android/native-activity/headers/box2d-2.2.1/box2d-test.scm" "~/projects/lambda-image/lambda-image" "~/testing")))
 '(scroll-bar-mode nil)
 '(show-paren-delay 0)
 '(show-paren-mode t nil (paren))
 '(split-height-threshold 300)
 '(tool-bar-mode nil)
 '(tool-bar-position (quote right))
 '(web-mode-markup-indent-offset 2))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2b2b2b" :foreground "#bbbbbb" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "adobe" :family "SourceCodePro"))))
 '(diff-added ((t (:inherit diff-changed :foreground "green4"))))
 '(diff-header ((t (:foreground "#77e"))))
 '(diff-refine-added ((t (:inherit diff-refine-change :background "#223322"))))
 '(diff-refine-removed ((t (:inherit diff-refine-change :background "#332222"))))
 '(diff-removed ((t (:inherit diff-changed :foreground "red3"))))
 '(diredp-dir-priv ((t (:background "#2C2C2C2C2C2C" :foreground "#aaf"))))
 '(diredp-file-name ((t (:foreground "#ffa"))))
 '(font-lock-string-face ((t (:background "#203528" :foreground "#a5c261"))))
 '(highlight ((t nil)))
 '(hl-line ((t (:inherit highlight))))
 '(idle-highlight ((t (:background "#305050"))))
 '(info-node ((t (:bold t :underline t :foreground "goldenrod"))))
 '(info-xref ((t (:foreground "#4444ee" :underline t :weight bold))))
 '(link ((t (:foreground "#5555ff" :underline t))))
 '(magit-diff-added ((t (:foreground "#66aa66"))))
 '(magit-diff-added-highlight ((t (:background "grey20" :foreground "#66aa66"))))
 '(magit-diff-context ((t (:foreground "grey50"))))
 '(magit-diff-context-highlight ((t (:background "grey20" :foreground "grey50"))))
 '(magit-diff-del ((t (:foreground "#ff3333"))))
 '(magit-diff-file-header ((t (:inherit magit-header :foreground "yellow"))))
 '(magit-diff-hunk-header ((t (:foreground "#7777ff" :slant italic))))
 '(magit-diff-none ((t (:foreground "grey40"))))
 '(magit-diff-removed ((t (:foreground "#aa6666"))))
 '(magit-diff-removed-highlight ((t (:background "grey20" :foreground "#aa6666"))))
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
