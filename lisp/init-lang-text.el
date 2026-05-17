;;; init-lang-text.el --- Markup and data languages -*- lexical-binding: t; -*-
;;; Commentary:
;; Markdown, Org, PDF, and YAML support.

;;; Code:

(use-package org
  :ensure nil)

(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode)))

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode))

(use-package yaml-mode
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)))

(provide 'init-lang-text)
;;; init-lang-text.el ends here
