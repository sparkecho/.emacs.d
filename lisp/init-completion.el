;;; init-completion.el --- Ivy/Counsel/Swiper stack -*- lexical-binding: t; -*-
;;; Commentary:
;; Minibuffer completion and search.

;;; Code:

(defun my/swiper-symbol-at-point ()
  "Run `swiper' with the symbol at point as the initial input."
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'symbol)))
    (if bounds
        (swiper (buffer-substring-no-properties (car bounds) (cdr bounds)))
      (user-error "No symbol at point"))))

(use-package smex
  :defer t)

(use-package ivy
  :demand t
  :diminish ivy-mode
  :bind (("C-x b" . ivy-switch-buffer)
         ("C-c C-r" . ivy-resume))
  :init
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d "
        ivy-display-style 'fancy)
  :config
  (ivy-mode 1))

(use-package counsel
  :demand t
  :after ivy
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         :map read-expression-map
         ("C-r" . counsel-expression-history)))

(use-package swiper
  :demand t
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)
         ("M-s ." . my/swiper-symbol-at-point)))

(provide 'init-completion)
;;; init-completion.el ends here
