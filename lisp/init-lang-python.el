;;; init-lang-python.el --- Python support -*- lexical-binding: t; -*-
;;; Commentary:
;; Python editing with basedpyright (type checking/completion) and ruff (lint/format).
;; Virtual environments managed by uv; basedpyright auto-detects .venv/ in project root.

;;; Code:

(defun my/python-mode-setup ()
  "Shared setup for `python-mode'."
  (setq indent-tabs-mode nil
        tab-width 4
        python-indent-offset 4
        fill-column 88)
  ;; Use .venv python for run-python if available.
  (when-let* ((root (locate-dominating-file default-directory ".venv"))
              (python (expand-file-name ".venv/bin/python" root)))
    (when (file-executable-p python)
      (setq-local python-shell-interpreter python))))

(use-package python
  :ensure nil
  :hook (python-mode . my/python-mode-setup)
  :custom
  (python-shell-interpreter "python3")
  (python-shell-completion-native-disabled-interpreters '("python")))

;; basedpyright: enhanced pyright fork for type checking and completion.
(use-package lsp-pyright
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred)))
  :custom
  (lsp-pyright-langserver-command "basedpyright")
  (lsp-pyright-type-checking-mode "basic")
  (lsp-pyright-auto-import-completions t)
  (lsp-pyright-disable-organize-imports t))

;; ruff: fast lint + format via lsp-mode built-in client.
(with-eval-after-load 'lsp-mode
  (setq lsp-ruff-server-command '("ruff" "server")
        lsp-ruff-advertize-fix-all t
        lsp-ruff-advertize-organize-imports t))

(use-package highlight-indent-guides
  :hook (python-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character))

(provide 'init-lang-python)
;;; init-lang-python.el ends here
