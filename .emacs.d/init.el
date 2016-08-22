;; -*- Mode:Emacs-Lisp ; Coding:utf-8 -*-
;; ----------------------------------------
;; @ load-path

(add-to-list 'load-path "~/.emacs.d/elisp")

(require 'init-loader)
(init-loader-load "~/.emacs.d/inits/")
