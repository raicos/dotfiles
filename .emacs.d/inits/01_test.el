(set-language-environment 'Japanese)

(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(require 'package)

;; 行番号表示
(global-linum-mode t)
(setq linum-format "%4d|")

(column-number-mode t)

;; バックアップファイルを作らない
(setq make-backup-files nil)
(setq auto-save-list-file-prefix nil)

(setq-default tab-width 4 indent-tabs-mode nil)

(blink-cursor-mode t)

(menu-bar-mode 0)

(line-number-mode t)

(global-hl-line-mode t)
(package-initialize)
