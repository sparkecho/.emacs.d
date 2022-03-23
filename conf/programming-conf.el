;;; programming-conf.el --- Configuration of programming
;;; Commentary:
;;; Code:

;; refs:
;; https://github.com/MatthewZMD/.emacs.d

;; (defvar *all-lang* '(c-mode c++-mode python-mode java-mode objc-mode js-mode js2-mode))

(use-package company
  :ensure t
  :diminish company-mode
  :defer t
  ;; :init
  ;; (add-hook 'c++-mode-hook 'company-mode)
  ;; (add-hook 'c-mode-hook 'company-mode)
  :config
  ;; (setq company-backends (delete 'company-clang company-backends))
  ;; (setq company-backends (delete 'company-semantic company-backends))
  ;; (define-key company-active-map (kbd "M-n") nil)
  ;; (define-key company-active-map (kbd "M-p") nil)
  ;; (define-key company-active-map (kbd "C-n") #'company-select-next)
  ;; (define-key company-active-map (kbd "C-p") #'company-select-previous)
  :custom
  ;; Don't use company in the following modes
  (company-global-modes '(not shell-mode eaf-mode))
  (company-idle-delay            0)
  (company-minimum-prefix-length 2)
  (company-show-numbers          t)
  (company-tooltip-align-annotations t)
  (company-tooltip-limit         20)
  :hook ((prog-mode) . company-mode))

(use-package yasnippet
  :diminish yas-minor-mode
  :init
  (use-package yasnippet-snippets :after yasnippet)
  :hook ((prog-mode LaTeX-mode org-mode) . yas-minor-mode)
  :bind
  (:map yas-minor-mode-map ("C-c C-n" . yas-expand-from-trigger-key))
  :config
  (yas-reload-all))


;; disable flycheck auto load, as it may cause lsp fail to load project
(use-package flycheck
  :defer t
  :diminish
  ;; :hook (after-init . global-flycheck-mode)
  :commands (flycheck-add-mode)
  :custom
  (flycheck-global-modes
   '(not outline-mode diff-mode shell-mode eshell-mode term-mode))
  (flycheck-emacs-lisp-load-path 'inherit)
  (flycheck-indication-mode (if (display-graphic-p) 'right-fringe 'right-margin)))

(use-package lsp-mode
  :defer t
  :commands lsp
  ;; :init
  ;; (setq lsp-keymap-prefix "C-c l")
  :config
  ;; https://github.com/emacs-lsp/lsp-mode/issues/1311
  ;; https://github.com/emacs-lsp/lsp-mode/issues/2207
  (add-hook 'c-mode-hook 'lsp-diagnostics-mode)
  (add-hook 'c++-mode-hook 'lsp-diagnostics-mode)
  :custom
  (lsp-auto-guess-root nil)
  (lsp-prefer-flymake nil) ; Use flycheck instead of flymake
  (lsp-file-watch-threshold 2000)
  (read-process-output-max (* 1024 1024))
  (lsp-eldoc-hook nil)
  :bind (:map lsp-mode-map ("C-c C-f" . lsp-format-buffer))
  :hook ((c-mode c++-mode
          objc-mode python-mode java-mode
          js-mode js2-mode) . lsp))

(use-package lsp-ui
  :after lsp-mode
  :ensure t
  :commands lsp-ui-mode
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :config
  (setq lsp-ui-peek-enable t)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-imenu-enable t)
  ;; (setq lsp-ui-flycheck-enable t)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-sideline-ignore-duplicate t))

(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol
  :bind (("C-c C-s" . lsp-ivy-workspace-symbol)))

(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package dap-mode
  :diminish
  :hook
  ((c-mode c++-mode) . (lambda ()
                         (require 'dap-cpptools)
                         (require 'dap-lldb))))

(use-package realgud
  :ensure t
  :init (use-package realgud-lldb :after realgud))
;; (load-library 'realgud)
;; (load-library 'realgud-lldb)



(use-package which-key
  :ensure t
  :diminish
  :config
  (setq which-key-idle-delay 1.0)
  (which-key-mode))

(eval-after-load "eldoc"
  '(diminish 'eldoc-mode))
(eval-after-load "abbrev"
  '(diminish 'abbrev-mode))

(provide 'programming-conf)
;;; programming-conf.el ends here
