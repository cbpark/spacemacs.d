;;; init-misc.el --- Misc
;;; Commentary:
;;; Code:

(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; gnuplot mode
(require 'gnuplot)
(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
(autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

(setq auto-mode-alist
      (append '(("\\.plt$" . gnuplot-mode)
                ("\\.gp$"  . gnuplot-mode)) auto-mode-alist))

;; markdown mode
(with-eval-after-load 'markdown-mode
  (add-hook 'markdown-mode-hook 'turn-off-auto-fill)
  (add-hook 'markdown-mode-hook 'visual-line-mode))

;; syntax highlighting for sysmtemd files
(add-to-list 'auto-mode-alist '("\\.service\\'"   . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.timer\\'"     . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.target\\'"    . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.mount\\'"     . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.automount\\'" . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.slice\\'"     . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.socket\\'"    . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.path\\'"      . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.netdev\\'"    . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.network\\'"   . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.link\\'"      . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\\.automount\\'" . conf-unix-mode))

;; PKGBUILD files
(add-to-list 'auto-mode-alist '("/PKGBUILD" . shell-script-mode))

;; line-numbers
(setq-default display-line-numbers-type 'visual
              display-line-numbers-width 4
              display-line-numbers-widen t)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(dolist (hook '(text-mode-hook lisp-interaction-mode-hook))
  (add-hook hook (lambda () (display-line-numbers-mode -1))))

(global-hl-line-mode -1)

;; undo-tree
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

(provide 'init-misc)
;;; init-misc.el ends here
