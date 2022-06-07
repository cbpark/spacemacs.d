;;; init-org.el --- Customizing org mode
;;; Commentary:
;;; Code:

(with-eval-after-load 'org
  ;; show inline images
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

  ;; (dolist (hook '(visual-line-mode
  ;;                 turn-off-auto-fill))
  ;;   (add-hook 'org-mode-hook hook))
  )

(provide 'init-org)
;;; init-org.el ends here
