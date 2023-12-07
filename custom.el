'(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(safe-local-variable-values
   '((cider-default-cljs-repl . "shadow") (cider-jack-in-default quote clojure-cli)
     (cider-lein-parameters . "with-profile dev")
     (cider-default-cljs-repl . shadow)
     (cider-shadow-cljs-parameters . "-A:dev server")
     (cider-shadow-default-options . ":app")
     (cider-shadow-watched-builds ":app")
     (cider-clojure-cli-aliases . ":dev:test")
     (cider-lein-parameters . "with-profile dev repl")
     (cider-clojure-cli-aliases . ":dev") (cider-jack-in-default quote lein))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(org-babel-load-languages '((emacs-lisp . t)))
 '(org-clock-total-time-cell-format "%s")
 '(safe-local-variable-values
   '((eval add-hook 'before-save-hook
      (lambda nil (save-excursion (org-update-all-dblocks))) nil 'local)
     (eval add-hook 'before-save-hook 'org-update-all-dblocks nil 'local)
     (eval add-hook 'before-save-hook #'org-update-all-dblocks nil 'local)
     (eval add-hook 'before-save-hook org-update-all-dblocks nil 'local)
     (eval add-hook 'before-save-hook
      (lambda nil (org-update-all-dblocks)
        '(save-excursion (evil-goto-first-line) (org-dblock-update)))
      nil 'local)
     (eval add-hook 'before-save-hook
      (lambda nil (save-excursion (evil-goto-first-line) (org-dblock-update)))
      nil 'local)
     (eval add-hook 'after-save-hook (lambda nil (message "Hello?")) nil 'local)
     (org-use-tag-inheritance) (cider-jack-in-default quote clojure-cli)
     (cider-clojure-cli-aliases . ":dev:test")))
 '(vterm-shell "/usr/bin/fish"))
