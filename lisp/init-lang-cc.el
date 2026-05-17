;;; init-lang-cc.el --- C/C++ toolchain -*- lexical-binding: t; -*-
;;; Commentary:
;; C, C++, CMake, Bazel, formatting, and style helpers.

;;; Code:

(defun my/c-cpp-mode-setup ()
  "Shared setup for C-like languages."
  (setq fill-column 100))

(defun my/c++-mode-setup ()
  "Extra setup for `c++-mode'."
  (setq flycheck-clang-language-standard "c++17"))

(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'")
  :init
  (setq cmake-tab-width 4))

(use-package bazel)

(use-package modern-cpp-font-lock
  :diminish modern-c++-font-lock-mode
  :hook (c++-mode . modern-c++-font-lock-mode))

(use-package google-c-style
  :hook (c-mode-common . google-set-c-style))

(use-package clang-format
  :commands (clang-format-buffer clang-format-region)
  :bind (:map c-mode-base-map
              ("M-q" . clang-format-region))
  :hook ((c-mode-common . my/c-cpp-mode-setup)
         (c++-mode . my/c++-mode-setup)))

(provide 'init-lang-cc)
;;; init-lang-cc.el ends here
