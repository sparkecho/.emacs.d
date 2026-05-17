;;; init-core.el --- Core editing behavior -*- lexical-binding: t; -*-
;;; Commentary:
;; Built-in behavior and defaults that should be available everywhere.

;;; Code:

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

(use-package emacs
  :ensure nil
  :init
  (setq-default indent-tabs-mode nil
                tab-always-indent 'complete
                c-basic-offset 4
                tab-width 4)
  (setq completion-ignore-case t
        read-buffer-completion-ignore-case t
        read-file-name-completion-ignore-case t)
  (auto-image-file-mode 1)
  (if (boundp 'use-short-answers)
      (setq use-short-answers t)
    (fset 'yes-or-no-p 'y-or-n-p))
  (put 'downcase-region 'disabled nil)
  (put 'upcase-region 'disabled nil)
  :hook
  (prog-mode . hs-minor-mode))

(provide 'init-core)
;;; init-core.el ends here
