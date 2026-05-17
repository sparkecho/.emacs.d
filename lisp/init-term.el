;;; init-term.el --- Shell and terminal integration -*- lexical-binding: t; -*-
;;; Commentary:
;; Terminal-specific behavior.

;;; Code:

(setq explicit-shell-file-name "zsh"
      tramp-terminal-type "tramp")

(defun my/term-toggle-mode ()
  "Toggle between `term-line-mode' and `term-char-mode'."
  (interactive)
  (if (term-in-line-mode)
      (term-char-mode)
    (term-line-mode)))

(use-package emacs
  :ensure nil
  :hook
  (shell-mode . (lambda ()
                  (when (fboundp 'shx-mode)
                    (shx-mode 1)))))

(use-package term
  :ensure nil
  :hook
  (term-mode . (lambda ()
                 (term-set-escape-char ?\C-x)
                 (setq-local global-hl-line-mode nil)))
  :config
  (define-key term-raw-map (kbd "M-x") #'counsel-M-x)
  (define-key term-raw-map (kbd "M-:") #'eval-expression)
  (define-key term-raw-map (kbd "C-x C-y") #'term-paste)
  (define-key term-raw-map (kbd "C-x C-h") #'help-command)
  (define-key term-raw-map (kbd "C-x C-t") #'my/term-toggle-mode)
  (define-key term-mode-map (kbd "C-x C-t") #'my/term-toggle-mode)
  (advice-add 'term-handle-exit :after (lambda (&rest _) (kill-buffer))))

(provide 'init-term)
;;; init-term.el ends here
