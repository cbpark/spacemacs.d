;;; init-org.el --- Customizing org mode
;;; Commentary:
;;; Code:

(dolist (hook '(visual-line-mode
                turn-off-auto-fill))
  (add-hook 'org-mode-hook hook))

;; show inline images
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;; markdown
(with-eval-after-load 'org
  (require 'ox-md nil t))

(provide 'init-org)
;;; init-org.el ends here
