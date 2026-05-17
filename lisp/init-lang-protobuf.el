;;; init-lang-protobuf.el --- Protobuf support -*- lexical-binding: t; -*-
;;; Commentary:
;; Protocol Buffers editing support.

;;; Code:

(use-package protobuf-mode
  :mode (("\\.proto\\'" . protobuf-mode)
         ("\\.pb\\'" . protobuf-mode)))

(provide 'init-lang-protobuf)
;;; init-lang-protobuf.el ends here
