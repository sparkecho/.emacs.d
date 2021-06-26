;;; appearence-conf.el --- Configuration of Emacs's appearence
;;; Commentary:

;;; Code:

(use-package cmake-mode
  :ensure t)

(use-package modern-cpp-font-lock
  :diminish (modern-c++-font-lock-mode)
  :init (modern-c++-font-lock-global-mode t))

(use-package google-c-style)


(provide 'cc-conf)
;;; cc-conf.el ends here
