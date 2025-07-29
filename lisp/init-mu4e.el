;;; init-mu4e.el --- Customizing mu4e mail client
;;; Commentary:
;;; Code:

(require 'mu4e)

(setq mu4e-attachment-dir  "~/Downloads"
      mu4e-sent-folder "/gmail/[Google Mail]/Sent Mail"
      mu4e-drafts-folder "/gmail/[Google Mail]/Drafts"
      mu4e-trash-folder "/gmail/[Google Mail]/Trash"
      user-mail-address "cbpark@gmail.com")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this.
(setq mu4e-sent-messages-behavior
      (lambda ()
        (if (string= (message-sendmail-envelope-from) "cbpark@gmail.com")
            'delete
          'sent)))

(setq mu4e-maildir-shortcuts
      '(("/gmail/INBOX"                   . ?g)
        ("/gmail/[Google Mail]/Sent Mail" . ?s)
        ("/gmail/[Google Mail]/Trash"     . ?t)
        ("/gmail/arXiv-hep"               . ?a)))

(defvar my-mu4e-account-alist
  '(("gmail"
     (mu4e-sent-folder "/gmail/[Google Mail]/Sent Mail")
     (mu4e-drafts-folder "/gmail/[Google Mail]/Drafts")
     (mu4e-trash-folder "/gmail/[Google Mail]/Trash")
     (user-mail-address "cbpark@gmail.com"))))

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message
                                                 :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat (lambda (var) (car var))
                                                my-mu4e-account-alist "/"))
                             (mapcar (lambda (var) (car var))
                                     my-mu4e-account-alist)
                             nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc (lambda (var)
                (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "mbsync -a")

;; update every 20 minuites
;; (setq mu4e-update-interval 1200)

;; off threading
(setq mu4e-headers-show-threads nil)

;; Html2text
(require 'mu4e-contrib)
(setq mu4e-html2text-command 'mu4e-shr2text)
(add-hook 'mu4e-view-mode-hook
          (lambda()
            (local-set-key (kbd "<tab>") 'shr-next-link)
            (local-set-key (kbd "<backtab>") 'shr-previous-link)))
(setq shr-color-visible-luminance-min 80)

;; enable inline images
(setq mu4e-view-show-images t
      mu4e-view-image-max-width 800)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types) (imagemagick-register-types))

;; use fancy non-ascii characters in various places in mu4e
(setq mu4e-use-fancy-chars t)

;; personal info
(setq mu4e-compose-signature-auto-include nil
      user-full-name "Chan Beom Park"
      user-mail-address "cbpark@gmail.com")

;; use the address in the message when replying.
;; (defun my-set-from-address ()
;;   "Set the From address based on the To address of the original."
;;   (let ((msg mu4e-compose-parent-message))
;;     (if msg
;;         (setq user-mail-address
;;               (cond ((mu4e-message-contact-field-matches
;;                       msg :to "cbpark@jnu.ac.kr") "cbpark@jnu.ac.kr")
;;                     (t "cbpark@gmail.com"))))))
;; (add-hook 'mu4e-compose-pre-hook 'my-set-from-address)

;; MSMTP setting for multi-smtp sending
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "msmtp")

;; (defun choose-msmtp-account ()
;;   "Choose account label to feed msmtp -a option based on From header."
;;   (if (message-mail-p)
;;       (save-excursion
;;         (let* ((from (save-restriction
;;                        (message-narrow-to-headers)
;;                        (message-fetch-field "from")))
;;                (account (cond ((string-match "cbpark@gmail.com" from)
;;                                "cbpark@gmail.com")
;;                               ((string-match "cbpark@jnu.ac.kr" from)
;;                                "cbpark@jnu.ac.kr"))))
;;           (setq message-sendmail-extra-arguments (list '"-a" account))))))
;; (setq message-sendmail-envelope-from 'header)
;; (add-hook 'message-send-mail-hook 'choose-msmtp-account)

;; don't keep message buffers around.
(setq message-kill-buffer-on-exit t)

;; message buffers left lying around are cleaned up if exited.
(setq mu4e-hide-index-messages t)

;; customize the reply-quote-string
(setq message-citation-line-format   "On %a, %d %b %Y at %R %Z, %f wrote:\n"
      message-citation-line-function 'message-insert-formatted-citation-line)

;; apply format=flowed
;; (setq mu4e-compose-format-flowed t)
;; (add-hook 'mu4e-compose-mode-hook (lambda () (use-hard-newlines -1)))

;; speeding up indexing
;; (setq mu4e-index-cleanup    nil ;; don't do a full cleanup check
;;       mu4e-index-lazy-check t)  ;; don't consider up-to-date dirs

(setq mu4e-view-show-addresses t)

(add-hook 'mail-mode-hook (lambda () (setq fill-column 72)))

(provide 'init-mu4e)
;;; init-mu4e.el ends here
