(setq initial-scratch-message ";; Ihre einzige Hoffnung beginnt hier.\n")

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)

(setq use-package-always-ensure t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init)

(use-package ido
  :init)

(use-package ivy
  :init)

(use-package move-text
  :init
  :bind
  (("M-p" . 'move-text-up)
   ("M-n" . 'move-text-down)))

(use-package which-key
  :init)

(use-package powerline
  :init)

(use-package company
  :init)

(use-package glsl-mode
  :init
  :mode (("\\.vert\\'" . glsl-mode)
         ("\\.frag\\'" . glsl-mode)
         ("\\.geom\\'" . glsl-mode)
         ("\\.tesc\\'" . glsl-mode)
         ("\\.tese\\'" . glsl-mode)
         ("\\.comp\\'" . glsl-mode)))

(use-package hl-todo
  :init)

(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)
(global-set-key (kbd "C-<tab>") 'projectile-find-other-file)
(global-set-key (kbd "C-'") 'dabbrev-expand)
(global-set-key (kbd "C-c f") 'projectile-find-file)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "C-c 2") 'duplicate-line)
(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-c C") 'uncomment-region)
(global-set-key (kbd "C-c q") 'quick-calc)
(global-set-key (kbd "C-c l") 'count-words)
(global-set-key (kbd "C-c g") 'projectile-grep)
(global-set-key (kbd "<f8>") 'projectile-compile-project)
(global-set-key (kbd "<f9>") 'projectile-run-project)

(electric-pair-mode t)
(delete-selection-mode t)
(tool-bar-mode -1)
(global-hl-line-mode 0)
(global-subword-mode t)
(ido-mode t)
(setq-default cursor-type 'box)
(menu-bar-mode 0)
(which-key-mode 1)
(setq inhibit-startup-message t)
(powerline-default-theme)
(global-hl-todo-mode)
(setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
        ("FIXME"  . "#FF0000")
        ("XXX"    . "#FFA500")
        ("KLUDGE" . "#FFFF00")
	      ("NOTE"   . "#1cc23f")))
(setq make-backup-files nil)

(with-eval-after-load 'hl-todo
  (define-key hl-todo-mode-map (kbd "C-x t p") 'hl-todo-previous)
  (define-key hl-todo-mode-map (kbd "C-x t n") 'hl-todo-next))

(defun my-delete-trailing-whitespace ()
  "Delete trailing whitespace if in a programming mode."
  (when (derived-mode-p 'prog-mode)  ; Checks if the current mode is derived from prog-mode
    (delete-trailing-whitespace)))

(add-hook 'before-save-hook 'my-delete-trailing-whitespace)

(require 'ansi-color)

(defun colorise-compilation-buffer ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

(add-hook 'compilation-filter-hook 'colorise-compilation-buffer)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(deeper-blue))
 '(global-display-line-numbers-mode t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(vterm which-key projectile powerline move-text ivy hl-todo glsl-mode company auto-package-update))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight regular :height 113 :width normal)))))
