
;; This requires the latest Slime to load. I've tried on
;; slime version 2012-06-12 (with contribs) and it works.

;; Unfortunately, it clashes with the version that Clojure want,
;; so have fun.

;; Where Eggs are installed
(add-to-list 'load-path "~/.emacs.d/custom")
(require 'scheme-c-mode)

;; Indenting module body code at column 0
(defun scheme-module-indent (state indent-point normal-indent) 0)
(put 'module 'scheme-indent-function 'scheme-module-indent)



(put 'and-let* 'scheme-indent-function 1)
(put 'parameterize 'scheme-indent-function 1)
(put 'handle-exceptions 'scheme-indent-function 1)
(put 'when 'scheme-indent-function 1)
(put 'unless 'scheme-indent-function 1)
(put 'match 'scheme-indent-function 1)
(put 'select 'scheme-indent-function 1)
(put 'dotimes 'scheme-indent-function 1)
(put '-> 'scheme-indent-function 1)

(put 'alist-let 'scheme-indent-function 1)
