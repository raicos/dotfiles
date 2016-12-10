;; display

;; ツールバー非表示
(tool-bar-mode -1)

;; メニューバー非表示
(menu-bar-mode -1)

;; スクロールバー非表示
(set-scroll-bar-mode nil)

;; スタートアップ非表示
(setq inhibit-startup-screen t)

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 行番号表示
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#888"
                    :height 0.9)

;; 行番号フォーマット
(setq linum-format "%4d")

;; カラム番号表示
(column-number-mode t)

;; 対応する括弧を光らせる
(show-paren-mode 1)

;; 現在の行をハイライト
(defface my-hl-line-face
  '((((class color) (background dark))
     (:background "NavyBlue" t))
    (((class color) (background light))
     (:background "NavyBlue" t))
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)
