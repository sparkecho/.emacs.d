;;; general-conf.el --- Configuration of general
;;; Commentary:
;;; Code:

;; Code folding
;; Reference: [https://stackoverflow.com/questions/12763566/how-to-permanently-enable-the-hs-minor-mode-in-emacs]
(add-hook 'prog-mode-hook  #'hs-minor-mode)
(global-set-key (kbd "M-i") 'hs-toggle-hiding)

;; only use space in indent
(setq-default indent-tabs-mode  nil)

;; 打开图片显示功能
(auto-image-file-mode t)

;; 用 y/n 代替 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Enable disabled commands
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; 补全时忽略大小写
(setq completion-ignore-case  t)
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; Extend shell-mode
(add-hook 'shell 'shx-mode)


;; ref: isearch-forward-symbol-at-point [M-s .]
(defun swiper-forward-symbol-at-point ()
  "Do incremental search forward for a symbol found near point.
Like ordinary incremental search except that the symbol found at point
is added to the search string initially as a regexp surrounded
by symbol boundary constructs \\_< and \\_>.
See the command `isearch-forward-symbol' for more information."
  (interactive)
  (let ((bounds (find-tag-default-bounds)))
    (cond
      (bounds (when (< (car bounds) (point))
	            (goto-char (car bounds)))
              (swiper (buffer-substring-no-properties (car bounds) (cdr bounds))))
      (t (error "[No symbol at point]")))))

(use-package counsel
  :ensure t)

;; Use ivy and swiper to extend minibuffer
;; Reference: https://github.com/zamansky/using-emacs/blob/master/myinit.org
(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-display-style 'fancy))

(use-package swiper
  :ensure t
  :init
  ;; Set M-x to use smex mode
  ;; smex provide convenient interface to your recently and most frequently used commands
  ;; If you have smex installed, counsel-M-x will automatically use it.
  ;; (global-set-key (kbd "M-x") 'smex)
  ;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; ;; This is your old M-x.
  ;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
  (use-package smex)
  :bind (("C-s"     . swiper)
         ("C-r"     . swiper)
         ("C-c C-r" . ivy-resume)
         ("M-x"     . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("M-s ."   . swiper-forward-symbol-at-point))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

(use-package magit
  :if (executable-find "git")
  :bind
  (("C-x g" . magit-status)
   (:map magit-status-mode-map
         ("M-RET" . magit-diff-visit-file-other-window))))


(use-package restart-emacs)

;; fix Mac OS X PATH different in term and in emacs
(use-package exec-path-from-shell :if (featurep 'cocoa) :defer t)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(provide 'general-conf)
;;; general-conf.el ends here
