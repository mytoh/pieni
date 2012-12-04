
(library (pieni cli)
  (export
    runner)
  (import
    (rnrs)
    (srfi :8 receive)
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

    (define (runner args)
      (let ((files (cdr args)))
        (cond
          ((null? files)
           (for-each
             (lambda (f)
               (display (string-append "test file " f))
               (newline)
               (display
                 (run-command (list 'mosh f))))
             (directory-list-rec "test")))
          (else
            (for-each
              (lambda (f)
                (display (string-append "test file " f))
                (newline)
                (display
                  (run-command (list 'mosh f))))
              files)
            ))))


    ))
