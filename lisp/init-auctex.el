;;; init-auctex.el --- Customizing AUCTeX mode
;;; Commentary:
;;; Code:

;; PDF viewer
(when (executable-find "okular")
  (with-eval-after-load "tex"
    (setcar (cdr (assoc 'output-pdf TeX-view-program-selection))
            "Okular")))

(dolist (hook '(display-line-numbers-mode
                visual-line-mode))
  (add-hook 'TeX-mode-hook hook))

(provide 'init-auctex)
;;; init-auctex.el ends here
