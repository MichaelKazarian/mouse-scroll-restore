;;; mouse-scroll-restore.el --- Restore point after mouse scrolling -*- lexical-binding: t; -*-

;; Author: Mykhailo Kazarian
;; Version: 1.0
;; Package-Requires: ((emacs "24.4"))
;; Keywords: mouse, scrolling, convenience

;;; Commentary:
;; This package saves the cursor position (point) when you start scrolling
;; with the mouse wheel or trackpad. As soon as you execute any non-mouse
;; command (like pressing arrow keys or typing), the view instantly bounces
;; back to the saved point.
;;
;; Standard keys like C-v and M-v are completely unaffected.

;;; Code:

(defgroup mouse-scroll-restore nil
  "Restore cursor position after mouse scroll sessions."
  :group 'mouse)

(defvar mouse-scroll-restore-saved-point nil
  "Stores the cursor position before the mouse scroll session begins.")

(defvar mouse-scroll-restore-active-p nil
  "Flag indicating whether a mouse scrolling session is currently active.")

(defun mouse-scroll-restore--trigger-save (&rest _args)
  "Triggered on every mouse scroll event. Saves point only at the session start."
  (unless mouse-scroll-restore-active-p
    (setq mouse-scroll-restore-saved-point (point))
    (setq mouse-scroll-restore-active-p t)))

(defun mouse-scroll-restore--restore-point ()
  "Pre-command hook to snap back to the saved point on any non-mouse command."
  (when (and mouse-scroll-restore-active-p
             (not (memq this-command '(mwheel-scroll 
                                       mwheel-scroll-up 
                                       mwheel-scroll-down 
                                       mouse-wheel-text-scale))))
    (when mouse-scroll-restore-saved-point
      (goto-char mouse-scroll-restore-saved-point)
      (setq mouse-scroll-restore-saved-point nil)
      (recenter))
    (setq mouse-scroll-restore-active-p nil)))

;;;###autoload
(define-minor-mode mouse-scroll-restore-mode
  "Toggle mouse-scroll-restore mode."
  :global t
  :group 'mouse-scroll-restore
  (if mouse-scroll-restore-mode
      (progn
        (advice-add 'mwheel-scroll-up :before #'mouse-scroll-restore--trigger-save)
        (advice-add 'mwheel-scroll-down :before #'mouse-scroll-restore--trigger-save)
        (advice-add 'mwheel-scroll :before #'mouse-scroll-restore--trigger-save)
        (add-hook 'pre-command-hook #'mouse-scroll-restore--restore-point))
    (progn
      (advice-remove 'mwheel-scroll-up #'mouse-scroll-restore--trigger-save)
      (advice-remove 'mwheel-scroll-down #'mouse-scroll-restore--trigger-save)
      (advice-remove 'mwheel-scroll #'mouse-scroll-restore--trigger-save)
      (remove-hook 'pre-command-hook #'mouse-scroll-restore--restore-point)
      (setq mouse-scroll-restore-saved-point nil)
      (setq mouse-scroll-restore-active-p nil))))

(provide 'mouse-scroll-restore)
;;; mouse-scroll-restore.el ends here
