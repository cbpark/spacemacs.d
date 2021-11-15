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
  (add-hook 'markdown-mode-hook 'turn-off-auto-fill))

(global-hl-line-mode -1)

(provide 'init-misc)
;;; init-misc.el ends here
