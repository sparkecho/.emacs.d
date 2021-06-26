;;; term-conf.el --- term-mode setting
;;; Commentary:
;;; Configuration of Emacs's term-mode

;;; Code:

;; Add the following lines to ~/.zshrc
;; # enable emacs to track current directory while ansi-term is zsh
;; # https://stackoverflow.com/a/10050104
;; if [ -n "$INSIDE_EMACS" ]; then
;;   chpwd() { print -P "\033AnSiTc %d" }
;;   print -P "\033AnSiTu %n"
;;   print -P "\033AnSiTc %d"
;; fi

(setq explicit-shell-file-name "/bin/bash")

(defun term-toggle-mode ()
  "Make term toggle between char-mode and line-mode."
  (interactive)
  (if (term-in-line-mode)
      (term-char-mode)
      (term-line-mode)))

(add-hook 'term-mode-hook
          (lambda ()
            ;; C-x is the prefix command, rather than C-c
            (term-set-escape-char ?\C-x)
            ;; disable linum-mode in terms
            (add-hook 'after-change-major-mode-hook
                      (lambda () (linum-mode 0))
                      :local)
            (setq-local global-hl-line-mode nil)
            (define-key term-raw-map  (kbd "M-x") 'counsel-M-x)
            (define-key term-raw-map  (kbd "M-:") 'eval-expression)
            (define-key term-raw-map  (kbd "C-x C-y") 'term-paste)
            (define-key term-raw-map  (kbd "C-x C-h") 'help-command)
            (define-key term-raw-map  (kbd "C-x C-t") 'term-toggle-mode)
            (define-key term-mode-map (kbd "C-x C-t") 'term-toggle-mode)))

(defadvice term-handle-exit (after term-kill-buffer-on-exit activate)
  "Kill the buffer after a term is exited."
  (kill-buffer))

(provide 'term-conf)
;;; term-conf.el ends here
