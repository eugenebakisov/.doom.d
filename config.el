;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Eugene Bakisov"
      user-mail-address "eugene.bakisov@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-dark-high-contrast
      doom-font (font-spec :family "JetBrains Mono" :size 22 :weight 'medium))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/.ydisk/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(after! cider (setq clojure-toplevel-inside-comment-form t))
(setq evil-snipe-override-evil-repeat-keys nil)
(setq doom-localleader-key ",")

                                        ;(require 'org-jira)
                                        ;(setq jiralib-url "https://dividendfinance.atlassian.net")
(after! evil-escape (setq-default evil-escape-key-sequence "fd"
                                  evil-escape-delay 0.30))

(after! company (setq company-tooltip-idle-delay 0.1
                      company-idle-delay 0.1))

(map! :leader
      (:prefix ("b" . "buffer")
       :desc "List bookmarks" "L" #'list-bookmarks
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

(map! :leader
      (:prefix ("o" . "open")
       :desc "shell" :n "t" '+vterm/toggle))

(map! :localleader
      ;; TODO: map these to lispy modes instead of only clojure:
      ;; this is screwed, I need a separated lisp-modification mod isntead.

      :mode (list clojure-mode emacs-lisp-mode lisp-mode scheme-mode)
      ;;:map '(clojure-mode-map elisp-def-mode-map)
      (:prefix ("e" . "eval")
       :desc "cider-eval-list-at-point" :n "l" 'cider-eval-list-at-point)
      :n "C-D" (cmd! (insert
                      (concat ";; "
                              (file-relative-name buffer-file-name
                                                  (projectile-project-root)))))
      :n "," 'sp-forward-slurp-sexp
      :n "<" 'paredit-backward-slurp-sexp
      :n "." 'sp-forward-barf-sexp
      :n ">" 'paredit-backward-barf-sexp
      :n "x" 'sp-kill-sexp
      (:prefix ("w" . "wrap")
       ;; TODO fix the same issue with word breaking
       :desc "quotes" :n "q" (cmd! (paredit-doublequote)
                                   (paredit-forward-slurp-sexp))
       :desc "round" :n "w" 'sp-wrap-round
       ;;       (cmd!
       ;;                             (let ((p (point)))
       ;;                                  (evil-backward-WORD-begin)
       ;;                                  (sp-wrap-round)
       ;;                                  (goto-char (1+ p))))

       :desc "curly" :n "r" 'paredit-wrap-curly
       :desc "curly" :n "c" 'paredit-wrap-curly
       :desc "square" :n "s" 'paredit-wrap-square)
      :n "W" 'sp-unwrap-sexp)

                                        ;(after! crdt (setq crdt-tuntox-executable "tuntox"
                                        ;                   crdt-use-tuntox t))

                                        ;(after! telega (setq telega-server-libs-prefix "/usr/local") )

                                        ;(put #'tramp-dissect-file-name 'tramp-suppress-trace t)

(defun tramp-ensure-dissected-file-name (vec-or-filename)
  "Return a `tramp-file-name' structure for VEC-OR-FILENAME.
VEC-OR-FILENAME may be either a string or a `tramp-file-name'.
If it's not a Tramp filename, return nil."
  (cond
   ((tramp-file-name-p vec-or-filename) vec-or-filename)
   ((tramp-tramp-file-p vec-or-filename)
    (tramp-dissect-file-name vec-or-filename))))

(add-to-list 'default-frame-alist '(undecorated . t))
(setq projectile-project-search-path '(("~/projects" . 1)
                                       ("~/dividend" . 1)
                                       ("~/repos" . 1)))
(setq doom-line-numbers-style 'relative)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((restclient . t)))

(after! company-box
  (add-hook 'company-mode-hook 'company-box-mode))

(setq confirm-kill-emacs nil)

;; (map! :n "C-SPC" 'harpoon-quick-menu-hydra
;;       :n "C-s" 'harpoon-add-file
;;       :leader "j c" 'harpoon-clear
;;       :leader "j f" 'harpoon-toggle-file
;;       :leader "1" 'harpoon-go-to-1
;;       :leader "2" 'harpoon-go-to-2
;;       :leader "3" 'harpoon-go-to-3
;;       :leader "4" 'harpoon-go-to-4
;;       :leader "5" 'harpoon-go-to-5
;;       :leader "6" 'harpoon-go-to-6
;;       :leader "7" 'harpoon-go-to-7
;;       :leader "8" 'harpoon-go-to-8
;;       :leader "9" 'harpoon-go-to-9)
;; (setq harpoon-without-project-function '+workspace-current-name)

(defun cljfmt ()
  (when (or (eq major-mode 'clojure-mode)
            (eq major-mode 'clojurescript-mode))
    (shell-command-to-string (format "cljfmt %s fix" buffer-file-name))
    (revert-buffer :ignore-auto :noconfirm)))

                                        ;(add-hook 'after-save-hook #'cljfmt)
(add-hook 'before-save-hook 'cider-format-buffer t t)

;; The maximum displayed length of the branch name of version control.
(setq doom-modeline-vcs-max-length 15)

(after! zprint-mode
  (map! :v ", f f" 'zprint))

                                        ; heeeeelll noooo~
'(after! zprint-mode
   (add-hook 'clojure-mode-hook 'zprint-mode)
   (add-hook 'clojurescript-mode-hook 'zprint-mode))

(after! magit
  (map!
   :leader :n "g s" nil ; by default "SPC g s" mapped stage-hulk
   :leader :n "g s f" 'magit-stage-buffer-file
   :leader :n "g s h" '+vc-gutter/stage-hunk))

(after! gptel
  (setq-default gptel-model  "mistral:latest"
                gptel-backend (gptel-make-ollama
                               "Ollama"
                               :host "localhost:11434"
                               :models '("codellama:13b-instruct" "mistral:latest")
                               :stream t))
  (map!
   :leader :v "c q" 'gptel-send
   :leader :n "c b" 'gptel))
(use-package! gptel)

'(defun run-command (cmd)
   (interactive)
   (let ((region (buffer-selected-region))
         (buffer (current-buffer)))
     ;; Apply command to selected region if one exists
     (if (not (zerop (length buffer)))
         (let* ((args (split-into-arguments cmd))
                (result (apply-buffer-command args buffer)))
           (message "Command applied: " cmd)
           (when result)
           (print result))))
   ;; Apply command to whole buffer if no region selected
   (apply-buffer-command args buffer))

'(defun run-command-on-selection ()
   "Apply specified cli command to the selected region of current buffer or whole buffer if nothing selected and return the result of this command."
   (interactive)
   (let* ((region (if mark-active (buffer-substring-no-properties (region-beginning) (region-end)) "")))
     (message "Command: %s\nRegion: %s"
              (shell-command-to-string
               (format "echo '%s' | %s" region "cut -d ' ' -f 2"))
              region)))

'(defun shell-command-on-region (start end cmd &optional switches)
   "Apply specified cli command to the selected region of current buffer or the whole buffer if nothing selected and return the result of this command.
The command CMD should contain a placeholder %s for the region text, which will be substituted by the contents of START..END in the buffer."
   (interactive "r\n")
   ;; If we don't have a selection, run on whole buffer
   (unless (region-active-p)
     (setq start (point-min) end (point-max)))
   ;; Create temp file and save contents of START..END to it. Then execute the command.
   (let* ((filename "/tmp/emacs-shell-command")
          (file-contents (buffer-substring start end))
          (cmd (concat "echo '" file-contents "' | sed 's/.*,//' | sort -u >> ~/.config/zsh/history.txt")))
     (with-temp-file filename (insert file-contents))
     ;; Run command on temp file and delete it afterwards
     (if switches
         (shell-command cmd filename)
       (shell-command "cat " filename)
       )
     (delete-file filename)))

'(defun command-on-region (&optional arg)
   "Run the selected region through a `shell-command' or if nothing is selected use the whole current buffer."
   (interactive)
   ;; Ask user for command to be run on selection or on whole buffer
   (let* ((default-input (concat "grep " (buffer-substring-no-properties (point-min) (point-max))))
          (shell-command (read-from-minibuffer "Shell command: " default-input)))
     ;; Run command on the selected lines and return result as string.
     (if mark-active
         (let ((result (shell-command-to-string (concat shell-command " '" (buffer-substring (region-beginning) (region-end)) "'"))))
           (with-current-buffer (get-buffer-create "*Shell command result*")
             (insert result)))
       ;; No selection. Run command with the whole buffer contents and display output in new buffer
       (let ((result (shell-command-to-string shell-command)))
         (with-current-buffer (get-buffer-create "*Shell command result*")
           (insert result))))
     (message "Shell command result is displayed in *Shell command result* buffer."))
   ;; If switches are provided, run with them else run without them
                                        ;(if arg (shell-command-on-region-with-switches) (shell-command-on-region-without-switches))
   )


(setq org-babel-load-languages '((emacs-lisp . t) (js . t)))

(after! org-clock
  (setq org-clocktable-defaults-bkp org-clocktable-defaults)
  (setq org-clocktable-defaults '(:maxlevel 2 :lang "en" :scope file :block nil :wstart 1 :mstart 1 :tstart nil :tend nil :step nil :stepskip0 nil :fileskip0 t :tags nil :match nil :emphasize nil :link nil :narrow 40! :indent t :formula nil :timestamp nil :level nil :tcolumns nil :formatter nil))
  '(setq org-clock-total-time-cell-format-bkp org-clock-total-time-cell-format)

  (defun my-clocktable-write (&rest args)
    "Custom clocktable writer. Uses the default writer but shifts the first column right."
    (apply #'org-clocktable-write-default args)
    (save-excursion
      (forward-char) ;; move into the first table field
      (org-table-move-column-right)
      (org-table-move-column-right)
      (while (re-search-forward " \(SCRUM-[0-9]+\)" nil t)
        (let ((id (string (read (match-string 1)))))
          (replace-match (format "https://dividendfinance.atlassian.net/browse/%s - %s -"
                                 id
                                 id
                                        ;(org-jira-find-value (jiralib--rest-call-it (format "/rest/api/2/issue/%s" id)))
                                 ))))))

  ;; (with-temp-buffer
  ;; (insert "65 83 68 70")
  ;; (goto-char (point-min))
  ;; (while (re-search-forward "[0-9]+" nil t)
  ;;   (replace-match
  ;;    ;; "65" => ?A => "A"
  ;;    (string (read (match-string 0)))
  ;;    'fixedcase
  ;;    'literal))
  ;; (buffer-string))

  (setq org-clock-clocktable-formatter 'my-clocktable-write)
  (setq org-clock-total-time-cell-format "%s"))

'(use-package! emacs-async :ensure t)

(after! org-jira
  (setq jiralib-url "https://dividendfinance.atlassian.net"))


(defun my-clocktable-write (&rest args)
  "Custom clocktable writer. Uses the default writer but shifts the first column right."
  (apply #'org-clocktable-write-default args)
  (save-excursion
    (forward-char) ;; move into the first table field
    (org-table-move-column-right)
    (org-table-move-column-right)
    (org-table-move-column-right)
    '(let ((summaries (make-hash-table)))
       (while (re-search-forward "| \\(SCRUM-[0-9]+\\)" nil t)
         (let ((id (match-string 1)))
           (replace-match
            (format "https://dividendfinance.atlassian.net/browse/%s - %s -"
                    id
                    (if-let ((summary (gethash id summaries)))
                        summary
                                        ;(puthash id (org-jira-get-issue-summary (jiralib--rest-call-it (format "/rest/api/2/issue/%s" id))) summaries)
                      (puthash id "test" summaries)
                      ))
            'fixedcase
            'literal))))))

(defconst org-jira-progress-issue-flow
  '(("To Do" . "In Progress")
    ("In Progress" . "Dev Complete")))

(after! haskell-mode
  (map!
   :mode 'haskell-error-mode
   :n "q" 'quit-window))

(after! docker-compose-mode
  (use-package! docker-compose)
  (setq docker-compose-command "docker compose")
  (map!
   :localleader
   :mode 'docker-compose-mode
   :n "," 'docker-compose

   :desc "docker compose up -d"
   :n "U" (cmd! (docker-compose-run-action-for-all-services "up" "-d")))
  (map!
   :mode 'shell-mode
   :n "q" '+workspace/close-window-or-workspace))

(after! tramp
  (setq vterm-tramp-shells '(("docker" "/bin/sh") ("ssh" "/usr/bin/fish"))))
