;;; appearence-conf.el --- Configuration of Emacs's appearence
;;; Commentary:

;;; Code:

(use-package cmake-mode
  :ensure t
  :config
  (setq cmake-tab-width 4))

(use-package bazel
  :ensure t)

(use-package modern-cpp-font-lock
  :diminish (modern-c++-font-lock-mode)
  :init (modern-c++-font-lock-global-mode t))

(add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++11")))

(use-package google-c-style
  :init
  ;; (add-hook 'c-mode-common-hook 'google-set-c-style)
  ;; (add-hook 'c-mode-common-hook 'google-make-newline-indent))
  (defun my-google-set-c-style ()
    "Set the current buffer's c-style to my modified Google C/C++ Programming
  Style. Meant to be added to `c-mode-common-hook'."
    (interactive)
    (c-add-style "MyGoogleStyle" '("Google"
                                   (c-basic-offset . 4)
                                   (access-label . -))))
  (add-hook 'c-mode-common-hook 'google-set-c-style))


;; (use-package clang-format
;;   :diminish (clang-format-mode)
;;   :bind (("M-q"     . clang-format-region))
;;   :init
;;   (defun clang-format-on-save-buffer ()
;;     (add-hook 'before-save-hook 'clang-format-buffer nil t)
;;     (add-hook 'before-save-hook 'whitespace-cleanup nil t))
;;   (add-hook 'c-mode-hook 'clang-format-on-save-buffer)
;;   (add-hook 'c++-mode-hook 'clang-format-on-save-buffer)
;;   (add-hook 'c-mode-common-hook
;;             '(lambda () (local-set-key (kbd "TAB") 'clang-format-region))))

;; (use-package flycheck-google-cpplint
;;   ;; Add Google C++ Style checker.
;;   ;; In default, syntax checked by Clang and Cppcheck
;;   :config
;;   (progn
;;     (flycheck-add-next-checker 'c/c++-cppcheck
;;                                '(warning . c/c++-googlelint))
;;     (custom-set-variables
;;      '(flycheck-c/c++-googlelint-executable
;;        (concat user-emacs-directory "tools/edfu-code-style/cpplint.py")))))

(provide 'cc-conf)
;;; cc-conf.el ends here
