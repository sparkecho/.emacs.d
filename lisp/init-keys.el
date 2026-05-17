;;; init-keys.el --- Keybindings and small editing helpers -*- lexical-binding: t; -*-
;;; Commentary:
;; Global keybindings plus a few small helper commands.

;;; Code:

(defun my/call-command-if-available (command missing-message)
  "Call COMMAND interactively when available, otherwise show MISSING-MESSAGE."
  (if (fboundp command)
      (call-interactively command)
    (user-error "%s" missing-message)))

(defun my/toggle-ecb ()
  "Toggle ECB when installed."
  (interactive)
  (my/call-command-if-available 'ecb-minor-mode "ECB is not installed"))

(defun my/bing-dict-brief ()
  "Run `bing-dict-brief' when installed."
  (interactive)
  (my/call-command-if-available 'bing-dict-brief "bing-dict is not installed"))

(defun my/apply-frame-transparency ()
  "Toggle between opaque and semi-transparent frames."
  (interactive)
  (let* ((states '((100 100) (85 55)))
         (current (or (frame-parameter nil 'alpha) '(100 100)))
         (next (if (equal current '(100 100))
                   (cadr states)
                 (car states))))
    (set-frame-parameter nil 'alpha next)
    (add-to-list 'default-frame-alist `(alpha . ,next))))

(defun my/rename-file-and-buffer ()
  "Rename the current buffer and the file it visits."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (if (vc-backend filename)
            (vc-rename-file filename new-name)
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t))))))

(setq delete-by-moving-to-trash t
      trash-directory "~/trash")

(defun my/file-deletion-timestamp ()
  "Return a compact timestamp string for trashed file names."
  (format-time-string "%y%m%d-%H%M%S" (current-time)))

(defun my/delete-file-and-buffer ()
  "Move the visited file to trash, then kill its buffer."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (when (y-or-n-p "Are you sure to delete this file? ")
        (let ((unique-name (format "%s-%s"
                                   filename
                                   (my/file-deletion-timestamp))))
          (unless (file-directory-p trash-directory)
            (make-directory trash-directory))
          (rename-file filename unique-name)
          (delete-file unique-name t)
          (kill-buffer)
          (message "File `%s' moved to `%s' successfully." unique-name trash-directory))))))

(defun my/upcase-first-char ()
  "Upcase the first character of the symbol at point."
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'symbol)))
    (if bounds
        (save-excursion
          (goto-char (car bounds))
          (upcase-char 1))
      (user-error "No symbol at point"))))

(defun my/downcase-char (arg)
  "Downcase ARG characters starting at point without moving point."
  (save-excursion
    (downcase-region (point) (progn (forward-char arg) (point)))))

(defun my/downcase-first-char ()
  "Downcase the first character of the symbol at point."
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'symbol)))
    (if bounds
        (save-excursion
          (goto-char (car bounds))
          (my/downcase-char 1))
      (user-error "No symbol at point"))))

(use-package emacs
  :ensure nil
  :bind (([f4] . my/toggle-ecb)
         ([f5] . compile)
         ([f6] . other-window)
         ([f7] . my/apply-frame-transparency)
         ([f8] . toggle-frame-maximized)
         ([f9] . delete-window)
         ([f10] . menu-bar-mode)
         ([f11] . toggle-frame-fullscreen)
         ([f12] . help-command)
         ("C-c C-h" . help-command)
         ("C-h" . delete-backward-char)
         ("C-c q" . refill-mode)
         ("M-i" . hs-toggle-hiding)
         ("M-p" . backward-sexp)
         ("M-n" . forward-sexp)
         ("C-c r" . my/rename-file-and-buffer)
         ("C-c d" . my/delete-file-and-buffer)
         ("C-c t" . my/bing-dict-brief)
         ("C-c M-c" . my/upcase-first-char)
         ("C-c M-l" . my/downcase-first-char)
         ("M-<left>" . windmove-left)
         ("M-<right>" . windmove-right)
         ("M-<up>" . windmove-up)
         ("M-<down>" . windmove-down)
         ("s-u" . revert-buffer)))

(provide 'init-keys)
;;; init-keys.el ends here
