;; display

(tool-bar-mode -1)

(menu-bar-mode -1)

(set-scroll-bar-mode nil)

(setq inhibit-startup-screen t)

(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#888"
                    :height 0.9)

(setq linum-format "%4d")

(column-number-mode t)

(show-paren-mode 1)

(global-hl-line-mode t)
