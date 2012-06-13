
(persp-mode)

;;;; Perspective

(eval-after-load 'perspective
  '(progn



;;;; Perspective Definitions

     (defun dkh-persp/main ()
       (interactive)
       (custom-persp "main"))
     ))

(defun dkh-persp/gnus ()
  (interactive)
  (custom-persp "gnus"
                (switch-or-start 'gnus "*Group*")))

(defun dkh-persp/identica ()
  (interactive)
  (custom-persp "identica"

(identica-friends-timeline)
                ))

(defun dkh-persp/irc ()
  "Connect to IM networks using bitlbee and freenode."
  (interactive)
  (custom-persp "irc"
                (erc :server "localhost" :port 6667 :nick "my_nick")
                (erc :server "asimov.freenode.net"  :nick "my_nick" :password "my_pass" :port 6667)
                ))

(defun dkh-persp/org ()
  (interactive)
  (setq default-directory "~/git/dkh-org")
  (custom-persp "org"

                (find-file (first org-agenda-files))))

(defun dkh-persp/w3m ()
  (interactive)
  (custom-persp "w3m"
                (w3m)
                ))

     (defun dkh-persp/devel ()
       (interactive)
       (custom-persp "devel")
(setq default-directory "/home/www/")
)

     (defun dkh-persp/devel-comp ()
       (interactive)
       (custom-persp "devel_comp")
(setq default-directory "/home/www/competitions_devel/comp_adm_trunk")
)



     (defun dkh-persp/test ()
       (interactive)
       (custom-persp "test")
      (setq default-directory "/home/www/htdocs")
)


     (defun dkh-persp/stage ()
       (interactive)
       (custom-persp "stage"))


     (defun dkh-persp/prod ()
       (interactive)
       (custom-persp "prod"))


(global-set-key (kbd "C-8 m") 'dkh-persp/main)
(global-set-key (kbd "C-8 g") 'dkh-persp/gnus)
(global-set-key (kbd "C-8 j") 'dkh-persp/jabber)
(global-set-key (kbd "C-8 i") 'dkh-persp/irc)
(global-set-key (kbd "C-8 o") 'dkh-persp/org)
(global-set-key (kbd "C-8 w") 'dkh-persp/w3m)
(global-set-key (kbd "C-8 d") 'dkh-persp/devel)
(global-set-key (kbd "C-8 t") 'dkh-persp/test)
(global-set-key (kbd "C-8 s") 'dkh-persp/stage)
(global-set-key (kbd "C-8 p") 'dkh-persp/prod)


(global-set-key (kbd "C-8 0") 'dkh-persp/main)
(global-set-key (kbd "C-8 1") 'dkh-persp/gnus)
(global-set-key (kbd "C-8 2") 'dkh-persp/identica)
(global-set-key (kbd "C-8 3") 'dkh-persp/irc)
(global-set-key (kbd "C-8 4") 'dkh-persp/org)
(global-set-key (kbd "C-8 5") 'dkh-persp/w3m)
(global-set-key (kbd "C-8 6") 'dkh-persp/devel)
(global-set-key (kbd "C-8 7") 'dkh-persp/test)
(global-set-key (kbd "C-8 8") 'dkh-persp/stage)
(global-set-key (kbd "C-8 9") 'dkh-persp/prod)

(global-set-key (kbd "C-8 s") 'persp-switch)
    (global-set-key (kbd "C-8 b") 'custom-persp-last)
    (global-set-key (kbd "C-8 d") 'persp-kill)
    (global-set-key (kbd "C-8 k") 'persp-remove-buffer)

(global-set-key (kbd "H-M-[") 'select-next-window)
(global-set-key (kbd "H-M-/")  'select-previous-window)

(defmacro e-max-persp (name &rest body)
  `(let ((initialize (not (gethash ,name perspectives-hash))))
     (persp-switch ,name)
     (when initialize ,@body)))

(defun e-max-persp-last ()
  (interactive)
  (persp-switch (persp-name persp-last)))

(defun persp-format-name (name)
  "Format the perspective name given by NAME for display in `persp-modestring'."
  (let ((string-name (format "%s" name)))
    (if (equal name (persp-name persp-curr))
        (propertize string-name 'face 'persp-selected-face))))

(defun e-max-persp-main ()
  (interactive)
  (e-max-persp "main"))


(defun e-max-perspective-bindings ()
  (when (e-max-bundle-active-p 'ergonomic)
    (global-set-key (kbd "C-p s") 'persp-switch)
    (global-set-key (kbd "C-p p") 'e-max-persp-last)
    (global-set-key (kbd "C-p d") 'persp-kill)
    (global-set-key (kbd "C-p x") 'persp-kill)
    (global-set-key (kbd "C-p m") 'e-max-persp-main)))

;;;; Perspective
(eval-after-load 'perspective
  '(progn

;;(set-face-background 'flymake-errline "DarkRed")

;;(set-face-foreground 'persp-selected-face "#729fcf")

;;(persp-selected-face ((t (:foreground "#729fcf"))))

 (defface dkh-persp-selected-face
   '((t (:weight bold :foreground "Green")))
   "The face used to highlight the current perspective on the modeline.")


(defmacro custom-persp (name &rest body)
  `(let ((initialize (not (gethash ,name perspectives-hash)))
         (current-perspective persp-curr))
     (persp-switch ,name)
     (when initialize ,@body)
     (setq persp-last current-perspective)))


      (defun persp-format-name (name)
        "Format the perspective name given by NAME for display in `persp-modestring'."
        (let ((string-name (format "%s" name)))
          (if (equal name (persp-name persp-curr))
              (propertize string-name 'face 'dkh-persp-selected-face))))

(defun persp-update-modestring ()
  "Update `persp-modestring' to reflect the current perspectives.
Has no effect when `persp-show-modestring' is nil."
  (when persp-show-modestring
    (setq persp-modestring
          (append '("[")
                  (persp-intersperse (mapcar 'persp-format-name (persp-names)) "")
                  '("]")))))

;; Jump to last perspective
(defun custom-persp-last ()
  (interactive)
  (persp-switch (persp-name persp-last)))



))

(message "0 dkh-perspective... Done")
