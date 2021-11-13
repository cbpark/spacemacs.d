;;; init-face.el -- Custom faces
;;; Commentary:
;;; Code:

(set-frame-parameter (selected-frame) 'alpha '(96 96))
(add-to-list 'default-frame-alist '(alpha 96 96))

(defun on-frame-open (&optional frame)
  "If the FRAME created in the terminal don't load background color."
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))
(add-hook 'after-make-frame-functions 'on-frame-open)

(defun set-font-hangul (frame)
  "If the FRAME created in GUI, set the font for hangul."
  (if (display-graphic-p frame)
      (progn
        (set-fontset-font t 'hangul (font-spec :name "NanumGothic"))
        (setq face-font-rescale-alist '(("NanumGothic" . 1.1))))))
(mapc 'set-font-hangul (frame-list))
(add-hook 'after-make-frame-functions 'set-font-hangul)

(provide 'init-face)
;;; init-face.el ends here
