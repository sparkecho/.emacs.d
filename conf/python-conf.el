;;; python-conf.el --- Configuration of python
;;; Commentary:

;;; Code:

;; Appearence
(add-hook 'python-mode-hook 'linum-mode)
(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 4)
            (setq python-indent-offset 4)))
(use-package elpy
  :ensure t
  :defer t
  :init
  ;; (elpy-enable)
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

;; (setq python-shell-interpreter "/opt/anaconda/bin/python3.6")
;; (setq python-shell-interpreter "ipython")

(provide 'python-conf)
;;; python-conf.el ends here
