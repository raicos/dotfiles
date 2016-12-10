(set-language-environment 'Japanese)

(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(require 'package)


;; バックアップファイルを作らない
(setq make-backup-files nil)
(setq auto-save-list-file-prefix nil)

(setq-default tab-width 4 indent-tabs-mode nil)

(blink-cursor-mode t)


(package-initialize)

(electric-pair-mode 1)

