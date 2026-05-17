;;; early-init.el --- Early startup settings -*- lexical-binding: t; -*-
;;; Commentary:
;; Startup settings that must run before package activation.

;;; Code:

(setq package-enable-at-startup nil)
(setq frame-inhibit-implied-resize t)

;; Reduce GC pressure during startup; restore it after init finishes.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 128 1024 1024)
                  gc-cons-percentage 0.1)))

(provide 'early-init)
;;; early-init.el ends here
