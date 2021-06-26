;;; package --- shortcut keys setting
;;; Commentary:
;;; Configuration of Emacs's Short Cut keys

;;; Code:

;; Configured at  2016/2/3 --15:33
(setq tab-always-indent 'complete)

;; 切换 ECB 模式激活状态
(global-set-key [f4] #'ecb-minor-mode)

;; Configured at 2015/9/10  --22:52
(global-set-key [f5] #'compile)

;; 激活非当前窗口 (窗口间跳转)
(global-set-key [f6] #'other-window)

;; 按 [f7] 键切换不透明和透明两种模式
;; loop-alpha 函数在文件 `appearence-conf.el' 中定义
(global-set-key [f7] #'loop-alpha)

;; 最大化 emacs 窗口
(global-set-key [f8] #'toggle-frame-maximized)

;; 关闭窗口 (关闭当前窗口)
(global-set-key [f9] #'delete-window)

;; 去掉菜单栏, 将F10绑定为显示菜单栏, 需要菜单栏了可以摁F10调出, 再摁F10就去掉菜单
(global-set-key [f10] #'menu-bar-mode)

;; 全屏 2015/9/3  --14:18
;; 为了方便操作,继续在"~/.emacs"中加入如下配置,全局绑定 "F11" 键为Emacs的全屏显示功能。
;; fullscreen 函数在文件 `appearence-conf.el' 中定义
(global-set-key [f11] #'fullscreen)

;; 用其他快捷键代替 C-h 作为帮助前缀
(global-set-key [f12]      #'help-command)
(global-set-key "\C-c\C-h" #'help-command)

;; 更改 C-h 为删除光标前一个字符
(global-set-key "\C-h" 'delete-backward-char)

;; 替换 [ ] 和 ( )
;; added at 2016/5/6 -- 12:56
;; from: http://stackoverflow.com/questions/14213173/swap-parentheses-and-square-brackets-in-emacs-paredit
;; (defvar swap-paren-pairs '("()" "[]"))
;; (defun swap-parens-at-points (b e)
;;   (let ((open-char (buffer-substring b (+ b 1)))
;;         (paren-pair-list (append swap-paren-pairs swap-paren-pairs)))
;;     (while paren-pair-list
;;       (if (eq (aref open-char 0) (aref (car paren-pair-list) 0))
;;           (save-excursion
;;             (setq to-replace (cadr paren-pair-list))
;;             (goto-char b)
;;             (delete-char 1)
;;             (insert (aref to-replace 0))
;;             (goto-char (- e 1))
;;             (delete-char 1)
;;             (insert (aref to-replace 1))
;;             (setq paren-pair-list nil))
;;         (setq paren-pair-list (cdr paren-pair-list))))))

;; (defun swap-parens ()
;;   (interactive)
;;   (cond ((looking-at "\\s(")
;;          (swap-parens-at-points (point) (save-excursion (forward-sexp) (point))))
;;         ((and (> (point) 1) (save-excursion (forward-char -1) (looking-at "\\s)")))
;;          (swap-parens-at-points (save-excursion (forward-sexp -1) (point)) (point)))
;;         ((message "Not at a paren"))))

;; (swap-parens)

;; (define-key slime-mode-map (kbd ")") ...)
;; 括号自动补齐
;; (global-set-key (kbd "[") 'insert-parentheses)
;; (global-set-key (kbd "]") 'move-past-close-and-reindent)
;; (global-set-key (kbd "[") (lambda () (interactive) (insert "(")))
;; (global-set-key (kbd "]") (lambda () (interactive) (insert ")")))
;; (global-set-key (kbd "(") (lambda () (interactive) (insert "[")))
;; (global-set-key (kbd ")") (lambda () (interactive) (insert "]")))


;; Configuration of refill-mode
;; 自动折行
(global-set-key (kbd "C-c q") 'refill-mode)

;; Configuration of indention
;; 将 M-q 设置为 indent-region
(global-set-key (kbd "M-q") 'indent-region)

;; Configuration of Navigating over balanced expressions
;; https://www.emacswiki.org/emacs/NavigatingParentheses
(global-set-key (kbd "M-p") 'backward-sexp)
(global-set-key (kbd "M-n") 'forward-sexp)

;; Configuration of Magit
;; 将 C-x g 设置为触发 magit-status 的快捷键
(global-set-key (kbd "C-x g") 'magit-status)

;; Configuration of Smex
;; 将 M-x 设置为默认使用 smex 模式
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Configuration of Rename the file in current buffer
;; Reference: https://stackoverflow.com/questions/17829619/rename-current-buffer-and-related-file-in-emacs
(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t (rename-file filename new-name t)
            (set-visited-file-name new-name t t)))))))

(global-set-key (kbd "C-c r")  'rename-file-and-buffer)

;; Configuration of Delete the file in current buffer
(setq delete-by-moving-to-trash t)
(setq trash-directory "~/trash")
;; Refresh timestamp, or `time-stamp-string' won't load
(time-stamp)
(defun delete-file-and-buffer ()
  "Delete the current buffer and file it is visiting.
Instead of delete completely, move the file to `trash-directory'."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      ;; Give the file to delete a unique name with time stamp.
      (let ((unique-name (format "%s-%s"
                                 filename
                                 (time-stamp-string "%02y%02m%02d-%02H%02M%02S"))))
        (y-or-n-p "Are you sure to delete this file? ")
        ;; Make sure `trash-directory' exists.
        (or (file-directory-p trash-directory)
            (make-directory trash-directory))
        (rename-file filename unique-name)
        (delete-file unique-name t)
        (kill-buffer)
        (message "File `%s' moved to `%s' successfully." unique-name trash-directory)))))

(global-set-key (kbd "C-c d")  'delete-file-and-buffer)

;; Use package `bing-dict' for translation
(global-set-key (kbd "C-c t") 'bing-dict-brief)

(provide 'shortcut-keys-conf)
;;; shortcut-keys-conf.el ends here
