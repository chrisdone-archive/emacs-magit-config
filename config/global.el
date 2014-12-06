(require 'uniquify)


;; Fundamental functions

(defun set-auto-saves ()
  "Put autosave files (ie #foo#) in one place, *not*
 scattered all over the file system!"
  (defvar autosave-dir
    (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))

  (make-directory autosave-dir t)

  (defun auto-save-file-name-p (filename)
    (string-match "^#.*#$" (file-name-nondirectory filename)))

  (defun make-auto-save-file-name ()
    (concat autosave-dir
            (if buffer-file-name
                (concat "#" (file-name-nondirectory buffer-file-name) "#")
              (expand-file-name
               (concat "#%" (buffer-name) "#")))))

  (defvar backup-dir (concat "/tmp/emacs_backups/" (user-login-name) "/"))
  (setq backup-directory-alist (list (cons "." backup-dir))))

(defun comment-dwim-line (&optional arg)
  "Do-what-I-mean commenting the current line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))


;; Global keybindings

(global-set-key (kbd "M-;") 'comment-dwim-line)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-z") 'ido-switch-buffer)

(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)

(global-set-key (kbd "C-w") 'clipboard-kill-region)
(global-set-key (kbd "M-w") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-y") 'clipboard-yank)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'execute-extended-command)


;; Disable default settings

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

(set-default 'tags-case-fold-search nil)

(put 'erase-buffer 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


;; Enable cool modes
(ido-mode 1)
(global-font-lock-mode 1)

(require 'dired-x)
(setq-default dired-omit-files-p t)
(setq dired-omit-files "\\.dyn_hi$\\|\\.dyn_o$\\|\\.hi$\\|\\.o$")


;; Enable cool defaults

(show-paren-mode 1)
(line-number-mode 1)
(column-number-mode 1)
(size-indication-mode 1)
(transient-mark-mode 1)
(delete-selection-mode 1)
(set-auto-saves)


;; Default mode settings

(setq default-major-mode 'text-mode)
(setq-default indent-tabs-mode nil)
(setq-default cursor-type 'bar)

(setq gnus-button-url 'browse-url-generic)

(setq ido-ignore-files '("\\.dyn_hi$""\\.dyn_o$""\\.hi$" "\\.o$" "\\.tags$" "^\\.ghci$"))
(setq ido-max-directory-size 200000)

(setq browse-url-browser-function gnus-button-url)


;; Global settings

(setq tab-width 2)
(setq scroll-step 1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq require-final-newline t)


;; Hooks

(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; Auto-loads

(add-to-list 'auto-mode-alist (cons "\\.hs\\'" 'haskell-mode))
(add-to-list 'auto-mode-alist (cons "\\.cabal\\'" 'haskell-cabal-mode))
(add-to-list 'auto-mode-alist '("\\.hcr\\'" . haskell-core-mode))


;; Environment settings

(set-language-environment "UTF-8")


;; Faces

(defface esk-paren-face
  '((((class color) (background dark))
     (:foreground "grey50"))
    (((class color) (background light))
     (:foreground "#bbbbbb")))
  "Face used to dim parentheses."
  :group 'starter-kit-faces)

(defface dark-paren-face
  '((((class color) (background dark))
     (:foreground "#ffffff"))
    (((class color) (background light))
     (:foreground "#000000")))
  "Face used to darken parentheses."
  :group 'starter-kit-faces)

(mapc (lambda (major-mode)
        (font-lock-add-keywords
         major-mode
         '(("(\\|)\\|\\[\\|\\]" . 'esk-paren-face))))
      '(emacs-lisp-mode haskell-mode))


;; Uniquify

(setq uniquify-buffer-name-style (quote post-forward-angle-brackets))


;; Safe local variables

(custom-set-variables
 '(safe-local-variable-values
   (quote ((haskell-indent-spaces . 4)
           (haskell-indent-spaces . 2)
           (hindent-style . "chris-done")
           (hindent-style . "gibiansky")
           (hindent-style . "johan-tibell")
           (haskell-process-type . cabal-repl)
           (shm-lambda-indent-style . leftmost-parent)))))

(provide 'global)
