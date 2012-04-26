

(add-to-list 'load-path "~/.emacs.d/bigloo/")


(autoload 'bdb "bdb" "bdb mode" t)
(autoload 'bee-mode "bee-mode" "bee mode" t)

(setq auto-mode-alist
      (append '(;("\\.scm$" . bee-mode)
                ;("\\.sch$" . bee-mode)
                ;("\\.scme$" . bee-mode)
                ("\\.bgl$" . bee-mode)
                ("\\.bee$" . bee-mode))
              auto-mode-alist))
