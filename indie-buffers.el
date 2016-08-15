;;; indie-buffers.el --- Narrowed indirect buffers -*- coding: utf-8; lexical-binding: t -*-

;; Author: Anler Hernández Peral <inbox@anler.me>
;; Version: 0.1.0
;; Keywords: buffer, buffers, clone, indirect
;; URL: https://github.com/anler/indie-buffers
;; Package-Requires: ((emacs "24"))
;; Compatibility: GNU Emacs 24.x
;;
;; This file is NOT part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; The goal of this package is to allow you to focus in certain parts of your code
;; by exploiting various Emacs' functionality such as indirect buffers and narrowing.
;; The idea is that instead of working in a big buffer, you create *lense buffers* to
;; each relevant parts of the code.

;; There is currently just one main functionality: create an indie buffer from a region.
;; With a couple of variations: create the buffer in other window or in other frame.

;; Basic usage:

;; (require 'indie-buffers)

;; Then you have to set up your keybindings - indie-buffers doesn't presume to
;; know how you'd like them laid out. Here are some examples:

;; When you have an active region that spans multiple lines, the following will
;; create an indie buffer for that region:

;;     (global-set-key (kbd "C-c i r") 'indie-buffers-region)

;; Similarly you can create the buffer in another window or frame:

;;     (global-set-key (kbd "C-c i o") 'indie-buffers-region-other-window)
;;     (global-set-key (kbd "C-c i f") 'indie-buffers-region-other-frame)

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
