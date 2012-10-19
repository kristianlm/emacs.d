
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-chromium))
 '(ede-project-directories (quote ("/home/klm/opt/rudel")))
 '(paren-mode (quote paren) nil (paren))
 '(quack-default-program "csi")
 '(quack-programs (quote ("xxd -p" "adb shell /cache/chicken/csi.sh" "adb shell LD_LIBRARY_PATH=. /cache/chicken/csi" "bigloo" "cat" "cat" "csi" "csi -:c" "csi -hygienic" "gosh" "gracket" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "lush2" "mit-scheme" "my-csi -:b" "nc localhost 1234" "racket" "racket -il typed/racket" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi" "valgrind csi" "valgrindcsi" "xxd" "~/prog/android/native-activity/headers/box2d-2.2.1/box2d-test.scm" "~/testing")))
 '(show-paren-delay 0)
 '(show-paren-mode (quote paren) nil (paren)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#232323" :foreground "#e6e1de"))))
 '(highlight ((t (:background "grey20"))))
 '(idle-highlight ((t (:background "#304530"))))
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
 '(show-paren-mismatch ((((class color)) (:background "red")))))

