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
  (let* ((buffer-name (format "*indie: %s*" name))
         (buffer (make-indirect-buffer base-buffer buffer-name :clone)))
    (with-current-buffer buffer
      (narrow-to-region start end))
    buffer))


(defun indie-buffers-region-with (buffer-handler start end name)
  (funcall
   buffer-handler
   (indie-buffers-create (current-buffer) name start end)))

;;;###autoload
(defun indie-buffers-region (start end name)
  "Create an indie buffer with region START END and named NAME."
  (interactive "r\nMName: ")
  (indie-buffers-region-with 'switch-to-buffer start end name))

;;;###autoload
(defun indie-buffers-region-other-window (start end name)
  "Create an indie buffer with region START END and named NAME in
other window."
  (interactive "r\nMName: ")
  (indie-buffers-region-with 'switch-to-buffer-other-window start end name))

;;;###autoload
(defun indie-buffers-region-other-frame (start end name)
  "Create an indie buffer with region START END and named NAME in
other frame."
  (interactive "r\nMName: ")
  (indie-buffers-region-with 'switch-to-buffer-other-frame start end name))

(provide 'indie-buffers)
;;; indie-buffers.el ends here
