;;; init-tools.el --- Misc tools and integrations -*- lexical-binding: t; -*-
;;; Commentary:
;; VCS, environment bridging, restart helpers, and optional external commands.

;;; Code:

(use-package magit
  :if (executable-find "git")
  :bind (("C-x g" . magit-status)
         :map magit-status-mode-map
         ("M-RET" . magit-diff-visit-file-other-window)))

(use-package restart-emacs
  :commands restart-emacs)

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :demand t
  :config
  (exec-path-from-shell-initialize))

(provide 'init-tools)
;;; init-tools.el ends here
