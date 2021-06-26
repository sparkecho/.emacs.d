;;; init.el --- initial configuration of emacs
;;; Commentary:
;;; Code:

;; Load Path
(add-to-list 'load-path (expand-file-name "conf" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "plugins" user-emacs-directory))

;; Packages
(require 'package-conf)

;; Preferences
(require 'appearence-conf)
(require 'shortcut-keys-conf)
(require 'general-conf)
(require 'markdown-conf)
(require 'org-conf)
(require 'term-conf)

;; Programming
(require 'programming-conf)
(require 'cc-conf)

;; (require 'common-lisp-conf)
;; (require 'elisp-conf)
;; (require 'python-conf)
;; (require 'asm-conf)
;; (require 'scala-conf)
;; (require 'auctex-conf)
;; (require 'octave-conf)
;; (require 'smalltalk-conf)
;; (require 'javascript-conf)

;; Others
;; (require 'auto-complete-conf)
;; (require 'esup-conf)

;; Configuration of helm
;; Added at 2016/4/17 -- 10:36
;; 启动时间太长，故禁止其自启动
;; 一些设置直接写入了 helm-mode.el 中
;; M-x helm-mode 启动 helm-mode 即可加载
;; (require 'helm-conf)
;; (emacs-init-time)

;;; init.el ends here
