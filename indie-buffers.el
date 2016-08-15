;;; indie-buffers.el --- Narrowed indirect buffers -*- coding: utf-8; lexical-binding: t -*-

;; This is free and unencumbered released into the public domain

;; Author: Anler Hernández Peral <inbox@anler.me>
;; Version: 0.1.0
;; Keywords: buffer, buffers, clone, indirect
;; URL: https://github.com/anler/indie-buffers

;;; Commentary:

;;; Code:

;;* Customization
(defgroup indie-buffers nil
  "Narrowed indirect buffers."
  :group 'convenience
  :prefix "indie-buffers-")


(defcustom indie-buffers-name-format
  "*indie: %s*"
  "Name format the indie buffers follow."
  :group 'indie-buffers)


(defun indie-buffers-create (base-buffer name start end)
  "Create an indirect buffer from BASE-BUFFER and named NAME."
  (let* ((buffer-name (format "*indie: %s*" name))
         (buffer (make-indirect-buffer base-buffer buffer-name :clone)))
    (with-current-buffer buffer
      (narrow-to-region start end))
    buffer))

;;;###autoload
(defun indie-buffers-region (start end name)
  "Create an indirect buffer from the active region."
  (interactive "r\nMName: ")
  (switch-to-buffer
   (indie-buffers-create (current-buffer) name start end)))

(provide 'indie-buffers)
;;; indie-buffers.el ends here
