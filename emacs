
;; added by Marisa to add Melpa support
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(c-default-style
   '((c-mode . "user")
	 (c++-mode . "user")
	 (java-mode . "java")
	 (awk-mode . "awk")
	 (other . "gnu")))
 '(column-number-mode t)
 '(confirm-kill-emacs nil)
 '(custom-enabled-themes '(deeper-blue))
 '(custom-safe-themes
   '("3a78cae35163bb71df460ebcfdebf811fd7bc74eaa15428c7e0bccfd4f858d30" "96c56bd2aab87fd92f2795df76c3582d762a88da5c0e54d30c71562b7bf9c605" default))
 '(display-fill-column-indicator-column 80)
 '(fringe-mode 6 nil (fringe))
 '(global-visual-line-mode t)
 '(indent-tabs-mode t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice "~/Documents/emacs/emacs_keys.org")
 '(linum-format 'dynamic)
 '(package-selected-packages
   '(use-package lsp-ui yasnippet lsp-ivy lsp-treemacs company flycheck lsp-mode ## cherry-blossom-theme which-key undo-tree tabbar session pod-mode muttrc-mode mutt-alias markdown-mode initsplit htmlize graphviz-dot-mode goto-chg folding eproject diminish csv-mode browse-kill-ring boxquote bm bar-cursor apache-mode))
 '(tab-bar-close-button-show t)
 '(tab-bar-new-tab-choice "*scratch*")
 '(tab-width 4)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "CYRE" :slant normal :weight normal :height 163 :width normal)))))

;; Added by Marisa for org mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; experimentally setting up which-key
(which-key-mode)

;; added by Marisa for tabbar
(require 'tabbar)
(tabbar-mode 1)

;; Added by Marisa
;; use count-words instead of count-words-region as it works on buffer
;; if no region is selected
(global-set-key (kbd "M-=") 'count-words)

;; Added by Marisa for lsp programming usage
(require 'lsp-mode)
;; add hooks to c and c++
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'yas-minor-mode)
(add-hook 'c-mode-hook #'yas-minor-mode)
(add-hook 'c++-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'c-mode-hook #'display-fill-column-indicator-mode)
(setq lsp-keymap-prefix "s-z")
;; to disable the hover mode, uncomment the next line
;; (setq lsp-ui-doc-enable nil)
;; following line disables cursor hover but keeps mouse hover
;; (setq lsp-ui-doc-show-with-cursor nil)
;; following line disables mouse hover but keeps cursor hover
(setq lsp-ui-doc-show-with-mouse nil)
;; to use a childframe, uncomment the next line
;; (setq lsp-ui-doc-use-childframe t)
;; either 'at-point 'top or 'bottom
;; (setq lsp-ui-doc-position 'at-point)
;; variables are set in character width
(setq lsp-ui-doc-max-width 40)
(setq lsp-ui-doc-max-height 10)
(define-key lsp-mode-map (kbd "s-z") lsp-command-map)
(with-eval-after-load 'lsp-mode
	(add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

;; added by Marisa to compile and link from keyboard
(require 'cc-mode)
(define-key c++-mode-map (kbd "C-c C-l") 'compile)

;; org-tree-to-indirect-buffer easier launch
(define-key global-map (kbd "C-x C-o") 'org-tree-to-indirect-buffer)

;; keys assigned or reassigned by Marisa
(global-set-key (kbd "C-}") 'enlarge-window-horizontally)
(global-set-key (kbd "C-{") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-}") 'enlarge-window)
(global-set-key (kbd "C-M-{") 'shrink-window)

;; experimental kill-word added by Marisa
;; found at https://stackoverflow.com/questions/637351/emacs-how-to-delete-text-without-kill-ring
(defun delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))
(global-set-key (kbd "C-<backspace>") 'delete-word)
(put 'downcase-region 'disabled nil)

;; experimental move lines up and down added by Marisa
;; found at https://emacsredux.com/blog/2013/04/02/move-current-line-up-or-down/
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

;; and bind the above lines to the mega key added by Marisa
(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
