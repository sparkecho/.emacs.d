;;; init-gptel.el --- LLM integration -*- lexical-binding: t; -*-
;;; Commentary:
;; gptel configuration for AI-assisted coding.
;; Reads host and key from ~/.emacs.d/gptel-config.el (not tracked by git).

;;; Code:

(load (expand-file-name "gptel-config" user-emacs-directory))

(use-package gptel
  :bind (("C-c g" . gptel)
         ("C-c G" . gptel-send))
  :custom
  (gptel-default-mode 'org-mode)
  :config
  (setq gptel-model my/gptel-model
        gptel-backend (gptel-make-openai "LLM"
                        :host my/gptel-api-host
                        :protocol "http"
                        :stream t
                        :key my/gptel-api-key
                        :models `(,my/gptel-model))))

(provide 'init-gptel)
;;; init-gptel.el ends here
