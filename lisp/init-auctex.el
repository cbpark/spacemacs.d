;;; init-auctex.el --- Customizing AUCTeX mode
;;; Commentary:
;;; Code:

;; PDF viewer
(when (executable-find "okular")
  (with-eval-after-load "tex"
    (setcar (cdr (assoc 'output-pdf TeX-view-program-selection)) "Okular")))

(provide 'init-auctex)
;;; init-auctex.el ends here
