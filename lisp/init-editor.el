;;; init-editor.el --- Utils for editing
;;; Commentary:
;;; Code:

;; Turn on flyspell
(add-hook 'text-mode-hook 'turn-on-flyspell)

;; Remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Recompile elisp when saving
(defun my-byte-compile-current-buffer ()
  "Byte-compile current buffer if it's `emacs-lisp-mode' and compiled file exists."
  (interactive)
  (when (and (eq major-mode 'emacs-lisp-mode)
             (file-exists-p (byte-compile-dest-file buffer-file-name)))
    (byte-compile-file buffer-file-name)))
(add-hook 'after-save-hook 'my-byte-compile-current-buffer)

;; Input method
(setq default-input-method "korean-hangul")

(provide 'init-editor)
;;; init-editor.el ends here
