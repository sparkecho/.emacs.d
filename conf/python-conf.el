;;; python-conf.el --- Configuration of python
;;; Commentary:

;;; Code:

;; Appearence
;; (add-hook 'python-mode-hook 'linum-mode)

(add-hook 'python-mode-hook
          (lambda ()
            ;; (setq lsp-pylsp-plugins-black-enabled t) ; 启用 black 格式化
            (setq indent-tabs-mode nil)
            (setq tab-width 4)
            (setq python-indent-offset 4)))

(use-package elpy
  :ensure t
  :defer t
  :init
  (elpy-enable)
  (add-hook 'python-mode-hook 'elpy-mode)
  (add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))
  (add-hook 'elpy-mode-hook (lambda () (flycheck-mode -1)))
  :config
  ;; (setq highlight-indentation-mode -1)
  (define-key elpy-mode-map (kbd "M-.") 'elpy-goto-definition))

(use-package highlight-indent-guides
  :ensure t
  :defer t
  :init
  (add-hook 'python-mode-hook 'highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character))

;; (setq elpy-rpc-python-command "/home/zhz/venv/py312/bin/python")
;; (setq python-shell-interpreter "/home/zhz/venv/py312/bin/ipython")
(setq elpy-rpc-python-command "python")
(setq python-shell-interpreter "ipython")
;; (setq python-shell-interpreter-args "-i --simple-prompt")
(setq python-shell-completion-native-disabled-interpreters '("python"))

(provide 'python-conf)
;;; python-conf.el ends here
