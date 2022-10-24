;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Disable the startup screen
(setq inhibit-startup-message t)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Package manager
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
;; Try will allow packages to be used without actually installing them
(use-package try
  :ensure t)

;; Enable help pop-up window for incomplete key-sequences
(use-package which-key
  :ensure t
  :config (which-key-mode))
;; Themes
(use-package zenburn-theme
  :ensure t)

(load-theme 'zenburn t)
;; Enable Evil
(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2dc03dfb67fbcb7d9c487522c29b7582da20766c9998aaad5e5b63b5c27eec3f" default))
 '(package-selected-packages '(which-key zenburn-theme use-package evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
