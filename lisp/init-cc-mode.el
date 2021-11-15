;;; init-cc-mode.el --- CC mode
;;; Commentary:
;;; Code:

(require 'cc-mode)

(setq-default c-basic-offset 4)
(setq c-default-style "k&r")

;; use line comments by default
(add-hook 'c-mode-hook (lambda () (c-toggle-comment-style -1)))

(add-hook 'c-mode-common-hook (lambda ()
                                (c-toggle-hungry-state 1)
                                (subword-mode 1)))

(defun flycheck-cpp-setup ()
  "Set clang language standard."
  (setq flycheck-clang-language-standard "c++17")
  (setq flycheck-clang-include-path
        (mapcar (lambda (dir)
                  (concat "/usr/local/include/" dir))
                (cddr (directory-files "/usr/local/include"))))
  (when (executable-find "root-config")
    (setq flycheck-clang-include-path
          (append (list
                   (substring
                    (shell-command-to-string "root-config --incdir") 0 -1))
                  flycheck-clang-include-path))))

(add-hook 'c++-mode-hook (lambda ()
                           (c-set-offset 'innamespace 0)
                           (flycheck-cpp-setup)))

(provide 'init-cc-mode)
;;; init-cc-mode.el ends here
