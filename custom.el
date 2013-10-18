(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-safe-themes (quote ("427234e4b45350b4159575f1ac72860c32dce79bb57a29a196b9cfb9dd3554d9" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

 ;; Set init font size to 15
;;(set-default-font "Inconsolata 15")
(set-default-font "-Misc-Fixed-Medium-R-Normal--15-*-75-75-C-*-ISO8859-1" t)
;; Make font-size in Emacs --daemon works
(setq default-frame-alist '((font . "Inconsolata-dz-15")))

 ;; Shortcut to execute last single shell command
(defun yf/last-history-element-and-exit ()
  "Select the last history element."
  (interactive)
  (goto-history-element 1)
  (exit-minibuffer))
(define-key minibuffer-local-shell-command-map (kbd "!") 'yf/last-history-element-and-exit)

 ;; Switch Meta key and Super key
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)


 ;; Custome theme define
(load-theme 'deeper-blue t)

 ;; Org-mode schedule definition
(setq org-agenda-files (list "~/org"))

 ;; Load mac profile into Emacs
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/inbox.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/ApplicationData/MobileOrg")
;; Set default TODO keywords
(setq org-todo-keywords
       '((sequence "TODO" "|" "DONE")))
;; Sync MobilrOrg when Emacs start and exit
;; (add-hook 'after-init-hook 'org-mobile-pull) ;; Seems to cause daemon hanged
(add-hook 'kill-emacs-hook 'org-mobile-push)

;; moble sync
(defvar org-mobile-sync-timer nil)
(defvar org-mobile-sync-idle-secs (* 60 10))
(defun org-mobile-sync ()
  (interactive)
  (org-mobile-pull)
  (org-mobile-push))
(defun org-mobile-sync-enable ()
  "enable mobile org idle sync"
  (interactive)
  (setq org-mobile-sync-timer
        (run-with-idle-timer org-mobile-sync-idle-secs t
                             'org-mobile-sync)));
(defun org-mobile-sync-disable ()
  "disable mobile org idle sync"
  (interactive)
  (cancel-timer org-mobile-sync-timer))
(org-mobile-sync-enable)

(provide 'custom)
;;; custom.el ends here
