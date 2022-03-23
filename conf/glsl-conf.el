;;; glsl-conf.el --- Configuration of glsl
;;; Commentary:
;;; Code:

(use-package glsl-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.frag\\'" . gfm-mode)))


(provide 'glsl-conf)
;;; glsl-conf.el ends here
