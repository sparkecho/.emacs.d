;;; init-gptel.el --- LLM integration -*- lexical-binding: t; -*-
;;; Commentary:
;; gptel configuration for AI-assisted coding.
;; Reads host and key from ~/.emacs.d/gptel-config.el (not tracked by git).

;;; Code:

(load (expand-file-name "gptel-config" user-emacs-directory))

(defvar-keymap my/gptel-prefix-map
  :doc "Prefix keymap for gptel commands."
  "c" #'gptel
  "d" #'gptel-menu
  "s" #'gptel-system-prompt)

(use-package gptel
  :bind (("C-c G" . gptel-send))
  :bind-keymap ("C-c g" . my/gptel-prefix-map)
  :custom
  (gptel-default-mode 'org-mode)
  :config
  (setq gptel-model my/gptel-model
        gptel-directives
        '((default . "You are a precise coding assistant. Answer in Chinese.")
          (code-review . "Review code for bugs, regressions, and missing tests.")
          (translator . "Translate accurately and preserve technical meaning."))
        gptel-backend (gptel-make-openai "LLM"
                        :host my/gptel-api-host
                        :protocol (if (string-match-p "^[0-9]" my/gptel-api-host)
                                      "http" "https")
                        :stream t
                        :key my/gptel-api-key
                        :models `(,my/gptel-model))))

(provide 'init-gptel)
;;; init-gptel.el ends here
