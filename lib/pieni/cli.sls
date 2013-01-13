
(library (pieni cli)
  (export
    runner)
  (import
    (silta base)
    (silta write)
    (srfi :8 receive)
    (only (srfi :13)
          string-trim-both)
    (srfi :37 args-fold)
    (srfi :39)
    (loitsu file)
    (loitsu process)
    (pieni check))

  (begin

    (define option-format
      (option '(#\f "format") #t #f
              (lambda (opt name arg report)
                (values arg))))

    (define (run-test files)
      (cond
        ((string=? "true\n" (process-output->string "git rev-parse --is-inside-work-tree"))
         (let ((libdir (string-trim-both
                         (process-output->string "git rev-parse --show-toplevel"))))
         (for-each
             (lambda (f)
               (display (string-append "test file " f))
               (newline)
               (display
                 (run-command `(mosh ,(string-append "--loadpath=" libdir) ,f))))
             files)))
        (else
          (for-each
              (lambda (f)
                (display (string-append "test file " f))
                (newline)
                (display
                  (run-command (list 'mosh f))))
              files))))

    (define (runner args)
      (let ((files (cdr args)))
        (cond
          ((null? files)
           (run-test (directory-list-rec "test")))
          (else
            (run-test files)))))


    ))
