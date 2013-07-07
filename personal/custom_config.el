;;; custom_config.el --- personal cofiguration file
;;; Commentary:
;;; Code:
(setenv "NODE_NO_READLINE" "1")
(add-to-list 'load-path (concat prelude-vendor-dir "/js2-mode"))
(add-to-list 'load-path (concat prelude-vendor-dir "/js-comint"))
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(require 'js-comint)
(setq inferior-js-program-command "node")
(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list
         'comint-preoutput-filter-functions
         (lambda (output)
           (replace-regexp-in-string "\033\\[[0-9]+[GK]" "" output)))))

(add-hook 'js2-mode-hook '(lambda ()
                           (local-set-key "\C-x\C-e" 'js-send-last-sexp)
                           (local-set-key "\C-cb" 'js-send-buffer)
                           (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
                           (local-set-key "\C-cl" 'js-load-file-and-go)
                           (local-set-key "\C-x!" 'run-js)
                           (local-set-key "\C-c\C-r" 'js-send-region)
                           (local-set-key "\C-c\C-j" 'js-send-line)
                           (set (make-local-variable 'compile-command)
                                (let ((file buffer-file-name)) (concat jshint-cli file)))
                           (set (make-local-variable 'compilation-read-command) nil)
                           (local-set-key "\C-c\C-u" 'whitespace-clean-and-compile)
                           ))
(defun whitespace-clean-and-compile ()
  (interactive)
  (whitespace-cleanup-all)
  (compile compile-command))

;;; custom_config.el ends here
