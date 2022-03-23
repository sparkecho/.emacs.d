;;; pdf-conf.el --- Configuration of pdf
;;; Commentary:
;;; Code:

;; References:
;; https://jblevins.org/projects/markdown-mode/
(use-package pdf-tools
  :config
  (add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode)))

(provide 'pdf-conf)
;;; pdf-conf.el ends here
