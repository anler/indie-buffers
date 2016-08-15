(ert-deftest indie-buffers-create-test ()
  "Test that an indirect buffer is created and narrowed
to the given region."
  (with-temp-buffer
    (insert "Hello World")
    (let* ((buffer-name "indie buffer example")
           (indie-buffer (indie-buffers-create
                          (current-buffer)
                          buffer-name
                          1 6)))
      (with-current-buffer indie-buffer
        (should (equal
                 "Hello"
                 (buffer-string)))

        (should (equal
                 (format indie-buffers-name-format buffer-name)
                 (buffer-name)))))))

(ert-deftest indie-buffers-region ()
  "Test that an indie buffer is created from the active region
 and we switch to it."
  (with-temp-buffer
    (insert "Hello World")
    (let* ((buffer (current-buffer))
           (buffer-name "indie buffer example")
           (start 1)
           (end 6))
      (with-mock
       (mock (indie-buffers-create buffer buffer-name start end))
       (mock (switch-to-buffer nil))
       (indie-buffers-region start end buffer-name)))))
