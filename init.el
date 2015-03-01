
;; Standard libraries needed

(require 'cl-lib)


;; Packages and configs to load

(defvar packages
  '(smex
    magit)
  "Packages whose location follows the
  packages/package-name/package-name.el format.")

(defvar custom-load-paths
  '("git-modes")
  "Custom load paths that don't follow the normal
  package-name/module-name.el format.")

(defvar configs
  '("global")
  "Configuration files that follow the config/foo.el file path
  format.")


;; Load packages

(cl-loop for location in custom-load-paths
         do (add-to-list 'load-path
                         (concat (file-name-directory (or load-file-name
                                                          (buffer-file-name)))
                                 "packages/"
                                 location)))

(cl-loop for name in packages
         do (progn (unless (fboundp name)
                     (add-to-list 'load-path
                                  (concat (file-name-directory (or load-file-name
                                                                   (buffer-file-name)))
                                          "packages/"
                                          (symbol-name name)))
                     (require name))))


;; Emacs configurations

(cl-loop for name in configs
         do (load (concat (file-name-directory load-file-name)
                          "config/"
                          name ".el")))


;; Mode initializations

(smex-initialize)
(kill-buffer "*scratch*")
(setq magit-status-buffer-switch-function 'switch-to-buffer)
(call-interactively 'magit-status)
