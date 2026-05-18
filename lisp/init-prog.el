;;; init-prog.el --- Shared programming support -*- lexical-binding: t; -*-
;;; Commentary:
;; Completion, snippets, diagnostics, LSP, debugging, and discovery helpers.

;;; Code:

;; Bind M-q to indent-region only in programming modes, preserving
;; fill-paragraph in text modes.
(bind-key "M-q" #'indent-region prog-mode-map)

(use-package company
  :diminish company-mode
  :custom
  (company-global-modes '(not shell-mode eaf-mode))
  (company-idle-delay 0)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations t)
  (company-tooltip-limit 20)
  :hook
  (prog-mode . company-mode))

(use-package yasnippet
  :diminish yas-minor-mode
  :hook ((prog-mode LaTeX-mode org-mode) . yas-minor-mode)
  :bind (:map yas-minor-mode-map
              ("C-c C-n" . yas-expand-from-trigger-key))
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :after yasnippet)

(use-package flycheck
  :commands flycheck-add-mode
  :diminish
  :custom
  (flycheck-global-modes '(not outline-mode diff-mode shell-mode eshell-mode term-mode))
  (flycheck-emacs-lisp-load-path 'inherit)
  (flycheck-indication-mode (if (display-graphic-p) 'right-fringe 'right-margin)))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :custom
  (lsp-auto-guess-root t)
  (lsp-file-watch-threshold 2000)
  (lsp-idle-delay 0.5)
  (lsp-log-io nil)
  (read-process-output-max (* 1024 1024))
  (lsp-eldoc-hook nil)
  (lsp-clients-clangd-args '("--background-index"
                              "--clang-tidy"
                              "--header-insertion=iwyu"
                              "--completion-style=detailed"))
  :bind (:map lsp-mode-map
              ("C-c C-f" . lsp-format-buffer))
  :hook ((c-mode c++-mode objc-mode java-mode js-mode js2-mode) . lsp)
  :config
  (add-hook 'c-mode-hook #'lsp-diagnostics-mode)
  (add-hook 'c++-mode-hook #'lsp-diagnostics-mode))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-peek-enable t)
  (lsp-ui-doc-enable nil)
  (lsp-ui-imenu-enable t)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-ignore-duplicate t))

(use-package lsp-ivy
  :after lsp-mode
  :bind (("C-c C-s" . lsp-ivy-workspace-symbol)))

(use-package lsp-treemacs
  :after lsp-mode
  :commands lsp-treemacs-errors-list)

(use-package dap-mode
  :hook ((c-mode c++-mode) . (lambda ()
                               (require 'dap-cpptools)
                               (require 'dap-lldb))))

(use-package realgud
  :commands realgud:cmd-run)

(use-package realgud-lldb
  :after realgud)

(use-package which-key
  :demand t
  :diminish
  :custom
  (which-key-idle-delay 1.0)
  :config
  (which-key-mode 1))

(with-eval-after-load 'eldoc
  (diminish 'eldoc-mode))

(with-eval-after-load 'abbrev
  (diminish 'abbrev-mode))

(provide 'init-prog)
;;; init-prog.el ends here
