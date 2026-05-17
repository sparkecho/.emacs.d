;;; init-lang-glsl.el --- GLSL support -*- lexical-binding: t; -*-
;;; Commentary:
;; OpenGL Shading Language editing support.

;;; Code:

(use-package glsl-mode
  :mode (("\\.glsl\\'" . glsl-mode)
         ("\\.vert\\'" . glsl-mode)
         ("\\.frag\\'" . glsl-mode)))

(provide 'init-lang-glsl)
;;; init-lang-glsl.el ends here
