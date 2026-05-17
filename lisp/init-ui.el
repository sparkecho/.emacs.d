;;; init-ui.el --- UI and appearance -*- lexical-binding: t; -*-
;;; Commentary:
;; Theme, frame, modeline, and visual defaults.

;;; Code:

(defun my/load-theme ()
  "Load the main theme without prompting."
  (load-theme 'material t))

(use-package emacs
  :ensure nil
  :init
  (setq custom-safe-themes t
        inhibit-startup-message t
        echo-keystrokes 0.1)
  (add-to-list 'default-frame-alist '(fullscreen . maximized))
  :config
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
  (when (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
  (blink-cursor-mode -1)
  (column-number-mode 1)
  (show-paren-mode 1)
  (global-hl-line-mode 1)
  (display-time-mode 1)
  (mouse-avoidance-mode 'animate))

(use-package cnfonts
  :demand t
  :config
  (cnfonts-mode 1))

(use-package material-theme
  :demand t
  :config
  (when (display-graphic-p)
    (my/load-theme)))

(when (daemonp)
  (add-hook 'after-make-frame-functions
            (lambda (frame)
              (with-selected-frame frame
                (when (display-graphic-p frame)
                  (my/load-theme))))))

(use-package smart-mode-line
  :demand t
  :init
  (setq sml/no-confirm-load-theme t
        sml/theme 'respectful)
  :config
  (sml/setup))

(provide 'init-ui)
;;; init-ui.el ends here
