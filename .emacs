;; packages repository

;;
;; I only need this once in a while
;;
;; (require 'package)
;;
;; (setq package-archives '(("melpa" . "https://melpa.org/packages/")
;;                          ("org" . "https://orgmode.org/elpa/")
;;                          ("elpa" . "https://elpa.gnu.org/packages/")))
;;
;; (package-initialize)
;; (unless package-archive-contents
;;   (package-refresh-contents))
;;
;; (unless (package-installed-p 'use-package)
;;   (package-install 'use-package))
;;
;; (require 'use-package)
;; (setq use-package-always-ensure t)
;;
;; (use-package auto-package-update
;;   :custom
;;   (auto-package-update-interval 7)
;;   (auto-package-update-prompt-before-update t)
;;   (auto-package-update-hide-results t)
;;   :config
;;   (auto-package-update-maybe)
;;   (auto-package-update-at-time "09:00"))

;; packages

(use-package magit)

(use-package olivetti)

(use-package projectile)

(use-package move-text
  :init
  :bind
  (("M-p" . 'move-text-up)
   ("M-n" . 'move-text-down)))

(use-package ansi-color)

;; modes

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(setq visible-bell t)
(column-number-mode)
(global-display-line-numbers-mode 0)
(ido-mode t)
(global-subword-mode t)
(delete-selection-mode t)
(electric-pair-mode 0)
(recentf-mode t)
(global-auto-revert-mode t)
(setq-default indent-tabs-mode nil)
(setq column-number-mode t)
(setq initial-scratch-message nil)
(setq auto-window-vscroll nil)
(setq scroll-conservatively 101)
(setq scroll-step 1)
(setq scroll-margin 0)
(setq vc-handled-backends nil)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; functions

(defun colorise-compilation-buffer ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))

(defun my-delete-trailing-whitespace ()
  "Delete trailing whitespace if in a programming mode."
  (when (derived-mode-p 'prog-mode)
    (delete-trailing-whitespace)))

(defun mark-whole-word (&optional arg allow-extend)
  "Like `mark-word', but selects whole words and skips over whitespace.
If you use a negative prefix arg then select words backward.
Otherwise select them forward.

If cursor starts in the middle of word then select that whole word.

If there is whitespace between the initial cursor position and the
first word (in the selection direction), it is skipped (not selected).

If the command is repeated or the mark is active, select the next NUM
words, where NUM is the numeric prefix argument.  (Negative NUM
selects backward.)"
  (interactive "P\np")
  (let ((num  (prefix-numeric-value arg)))
    (unless (eq last-command this-command)
      (if (natnump num)
          (skip-syntax-forward "\\s-")
        (skip-syntax-backward "\\s-")))
    (unless (or (eq last-command this-command)
                (if (natnump num)
                    (looking-at "\\b")
                  (looking-back "\\b")))
      (if (natnump num)
          (left-word)
        (right-word)))
    (mark-word arg allow-extend)))

;; key bindings

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
(global-set-key (kbd "<f9>") 'projectile-compile-project)
(global-set-key (kbd "C-c g") 'projectile-grep)
(global-set-key (kbd "C-<tab>") 'projectile-find-other-file)
(global-set-key (kbd "M-<tab>") 'recentf-open-files)
(global-set-key (kbd "C-c f") 'projectile-find-file)
(global-set-key (kbd "C-z") 'kill-whole-line)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "M-q") 'mark-whole-word)

;; hooks

(add-hook 'compilation-filter-hook 'colorise-compilation-buffer)
(add-hook 'before-save-hook 'my-delete-trailing-whitespace)
