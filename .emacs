;; Disable automatic initialization of packages at startup
(setq package-enable-at-startup nil)

;; Initialize package system
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Increase garbage collection threshold to postpone it
(setq gc-cons-threshold (* 50 1000 1000)) ;; Set to 50MB (default is 800KB)
(setq gc-cons-percentage 0.6)

;; Defer garbage collection further in the startup process
(defvar startup/gc-cons-threshold gc-cons-threshold
  "Original value of `gc-cons-threshold' at startup time.")

(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold startup/gc-cons-threshold)
            (makunbound 'startup/gc-cons-threshold)))

;; Disable file name handlers during startup for faster loading
(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist startup/file-name-handler-alist)
            (makunbound 'startup/file-name-handler-alist)))

;; Disable unnecessary UI elements to reduce rendering overhead
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 0)
;; (setq-default left-fringe-width 0)
;; (setq-default right-fringe-width 0)

;; Disable startup messages
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; Faster scrolling
(setq auto-window-vscroll nil)
(setq scroll-conservatively 101)
(setq scroll-step 1)
(setq scroll-margin 0)

;; Disable line numbers for performance (optional)
(global-display-line-numbers-mode -1)

;; Optimize redisplay
(setq redisplay-dont-pause t)
(setq font-lock-maximum-decoration t)
(setq jit-lock-defer-time 0)
(setq fast-but-imprecise-scrolling t)
(setq idle-update-delay 1.0)

;; Prevent frame resizing during font/fontset changes
(setq frame-inhibit-implied-resize t)

;; Optimize handling of very long lines
(setq-default bidi-display-reordering 'left-to-right)
(setq-default bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; Reduce the frequency of garbage collection by increasing the threshold
(defun defer-garbage-collection ()
  "Increase `gc-cons-threshold' to postpone garbage collection."
  (setq gc-cons-threshold most-positive-fixnum))

(defun restore-garbage-collection ()
  "Restore `gc-cons-threshold' to a reasonable value."
  ;; You can adjust this value according to your preferences
  (setq gc-cons-threshold (* 20 1000 1000))) ;; Set to 20MB

(add-hook 'minibuffer-setup-hook #'defer-garbage-collection)
(add-hook 'minibuffer-exit-hook #'restore-garbage-collection)

;; Simplify prompts
(fset 'yes-or-no-p 'y-or-n-p)

;; Reduce file I/O by disabling backup and lock files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; Improve performance for operations on files with version control
(setq vc-handled-backends nil)

;; Don't compact font caches during GC
(setq inhibit-compacting-font-caches t)

;; Reduce input lag
(setq echo-keystrokes 0.02)

;; Disable blinking cursor
(blink-cursor-mode -1)

;; Adjust how Emacs handles large files
(setq large-file-warning-threshold (* 100 1000 1000)) ;; Set to 100MB
(defun my-find-file-check-large-file ()
  "Warn when opening files larger than a specified size."
  (when (> (buffer-size) (* 5 1000 1000)) ;; Files larger than 5MB
    (setq buffer-read-only t)
    (fundamental-mode)
    (message "File is too large, opened in read-only fundamental mode.")))

(add-hook 'find-file-hook 'my-find-file-check-large-file)

;; Avoid re-computing expensive fonts
(setq-default line-spacing 0)

;; Don't resize mini-windows (like the echo area) during display
(setq resize-mini-windows 'grow-only)

;; Improve performance of regex operations
(setq-default case-fold-search t)
(setq auto-hscroll-mode 'current-line)

;; Provide the optimized init
(provide '.emacs)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-enabled-themes '(adwaita))
 '(custom-safe-themes
   '("72127b6a560b992c28f4eed4c82b6309d3df70860dd53821db622befbb95df7b" "a66a48b8741a2fd972fe7d45fdeaeb2167bd1e6059b471fd0c7127c1582fb825" "a6d0b03121ed6757a6b881281152be7c69b2a101468eab595362fbdfee1e1d8d" "79dad553be43c1b28e7b1f3aba9598a22801475fe4e770091474fa47bbd89a97" "467cea3b200a2eaeeaa688b4e5a3ca859bf5028fecebb8fe9dde86c7076c66dd" "8ac5cada9bfde84a892f3cbcde92109537d1ab4adf75b0e1160aa8cdeee6a0d5" "dac4b51def746bb47e1752c95608a4227e428af36a5aca7d562063a157646d0c" "40ad32a3202ff3e5e26e071538ae4dbc83e396c7336d7a5590a3b325ffc1af70" "ad7c3ae103193c0cc2fc93983faa61f6d06cfb5a31a034d1d0267369a5e69c55" "eb02d53f61c04197bd20dc14855310af210d6ed85f26a536541014a78e310c71" "fb61f13be711f5f4f8a578faae884955878dbcb98d21425001f2f21f2b74bc04" "6c8fe22d5b31d4b80d7ef31b51a6549b89e5e4a378c1285cf6922f7c18ad3e9e" default))
 '(menu-bar-mode nil)
 '(package-selected-packages '(lsp-mode tree-sitter projectile move-text nasm-mode))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight regular :height 128 :width normal)))))

(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)
(global-set-key (kbd "C-'") 'dabbrev-expand)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "C-c 2") 'duplicate-line)
(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-c C") 'uncomment-region)
(global-set-key (kbd "C-c q") 'quick-calc)
(global-set-key (kbd "<f8>") 'compile)
(global-set-key (kbd "C-c g") 'projectile-grep)
(global-set-key (kbd "C-<tab>") 'projectile-find-other-file)
(global-set-key (kbd "M-<tab>") 'recentf-open-files)
(global-set-key (kbd "C-c f") 'projectile-find-file)
(global-set-key (kbd "C-z") 'kill-whole-line)

(use-package ido
  :init)

(use-package move-text
  :init
  :bind
  (("M-p" . 'move-text-up)
   ("M-n" . 'move-text-down)))

(use-package glsl-mode
  :init
  :mode (("\\.vert\\'" . glsl-mode)
         ("\\.frag\\'" . glsl-mode)
         ("\\.geom\\'" . glsl-mode)
         ("\\.tesc\\'" . glsl-mode)
         ("\\.tese\\'" . glsl-mode)
         ("\\.comp\\'" . glsl-mode)))

(use-package cmake-mode
  :init)

(ido-mode t)
(global-subword-mode t)
(delete-selection-mode t)
(electric-pair-mode 0)
(recentf-mode t)
(global-auto-revert-mode t)
(setq-default indent-tabs-mode nil)
(setq column-number-mode t)

(defun my-delete-trailing-whitespace ()
  "Delete trailing whitespace if in a programming mode."
  (when (derived-mode-p 'prog-mode)  ; Checks if the current mode is derived from prog-mode
    (delete-trailing-whitespace)))

(add-hook 'before-save-hook 'my-delete-trailing-whitespace)

(setq major-mode-remap-alist
      '((c-mode . c-ts-mode)
        (c++-mode . c++-ts-mode)))

;; if you want to change prefix for lsp-mode keybindings.
(setq lsp-keymap-prefix "s-l")

(require 'lsp-mode)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-ts-mode))
(put 'upcase-region 'disabled nil)

(setq lsp-clients-clangd-args '("--clang-tidy"))
