;;; init-package.el --- Package bootstrap -*- lexical-binding: t; -*-
;;; Commentary:
;; Bootstrap `package.el' and `use-package'.

;;; Code:

(require 'package)

;; Prevent Custom from appending `package-selected-packages' to init.el.
;; We manage packages declaratively via use-package.
(setq package-selected-packages nil)

(setq package-archives '(("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))
      package-archive-priorities '(("gnu" . 10)
                                   ("melpa" . 5)))

(package-initialize)

(unless (package-installed-p 'use-package)
  (unless (bound-and-true-p package-archive-contents)
    (package-refresh-contents))
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t
      use-package-always-defer t
      use-package-expand-minimally t
      use-package-enable-imenu-support t)

(use-package diminish :demand t)
(use-package bind-key :demand t)

(provide 'init-package)
;;; init-package.el ends here
