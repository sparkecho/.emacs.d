;;; init-lang-python.el --- Python support -*- lexical-binding: t; -*-
;;; Commentary:
;; Python editing, language server, and REPL defaults.

;;; Code:

(defun my/python-mode-setup ()
  "Shared setup for `python-mode'."
  (setq indent-tabs-mode nil
        tab-width 4
        python-indent-offset 4))

(use-package python
  :ensure nil
  :hook (python-mode . my/python-mode-setup)
  :custom
  (python-shell-interpreter "python3")
  (python-shell-completion-native-disabled-interpreters '("python")))

(use-package lsp-pyright
  :after lsp-mode
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp)))
  :custom
  (lsp-pyright-langserver-command "pyright"))

(use-package highlight-indent-guides
  :hook (python-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character))

(provide 'init-lang-python)
;;; init-lang-python.el ends here
