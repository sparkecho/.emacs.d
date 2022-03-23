;;; protobuf-conf.el --- Configuration of protobuf
;;; Commentary:
;;; Code:

(use-package protobuf-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))
  (add-to-list 'auto-mode-alist '("\\.pb\\'" . protobuf-mode)))

(provide 'protobuf-conf)
;;; protobuf-conf.el ends here
