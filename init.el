;;; init.el --- Main entry point for Emacs -*- lexical-binding: t; -*-
;;; Commentary:
;; Keep this file thin. Load order and feature-specific configuration live in
;; dedicated modules under `lisp/'.
;; In terminal mode (-nw), only core editing and keybindings are loaded for
;; fast startup.

;;; Code:

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-package)
(require 'init-core)
(require 'init-completion)
(require 'init-keys)

;; GUI-only modules: theme, tools, LSP, language support, etc.
;; Also load when running as daemon (frames are created later).
(when (or (display-graphic-p) (daemonp))
  (require 'init-ui)
  (require 'init-tools)
  (require 'init-term)
  (require 'init-prog)
  (require 'init-gptel)
  (require 'init-lang-cc)
  (require 'init-lang-python)
  (require 'init-lang-protobuf)
  (require 'init-lang-glsl)
  (require 'init-lang-text))

(provide 'init)
;;; init.el ends here
