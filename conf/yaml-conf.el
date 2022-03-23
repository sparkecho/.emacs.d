;;; yaml-conf.el --- Configuration of yaml
;;; Commentary:
;;; Code:

(use-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode)))

(provide 'yaml-conf)
;;; yaml-conf.el ends here
