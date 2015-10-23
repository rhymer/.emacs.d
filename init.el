(server-start)



(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'package)

;; We include the org repository for completeness, but don't normally
;; use it.
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

;;; Also use Melpa for most packages
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))


;;; On-demand installation of packages

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(setq package-enable-at-startup nil)
(package-initialize)

(require-package 'use-package)
(require 'use-package)


(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

    (use-package whitespace
      :bind (("C-c T w" . whitespace-mode))
      :init
      (dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
        (add-hook hook #'whitespace-mode))
      :config (setq whitespace-line-column nil)
      :diminish whitespace-mode)
