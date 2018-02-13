;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))


; Allow numeric keypad to work correctly?
(global-set-key "\eOp" "0")
(global-set-key "\eOq" "1") 
(global-set-key "\eOr" "2")
(global-set-key "\eOs" "3") 
(global-set-key "\eOt" "4")
(global-set-key "\eOu" "5") 
(global-set-key "\eOv" "6")
(global-set-key "\eOw" "7") 
(global-set-key "\eOx" "8")
(global-set-key "\eOy" "9") 
(global-set-key "\eOl" "+")
(global-set-key "\eOQ" "/") 
(global-set-key "\eOR" "*")
(global-set-key "\eOS" "-") 
(global-set-key "\eOn" ".")


; file associations
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("crontab" . conf-mode))
(add-to-list 'auto-mode-alist '("\.env" . conf-mode))
(add-to-list 'auto-mode-alist '("\.htaccess" . conf-mode))
