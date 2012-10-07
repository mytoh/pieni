
(define-module pieni.commands.test
  (export
    run-test)
  (use file.util)
  (use util.list)
  (use util.match)
  (use text.tree)
  (use gauche.parameter)
  (use gauche.process)
  )
(select-module pieni.commands.test)


(define (run-test args)
  (test-project args)
  )

(define test-directory
  (make-parameter
    '("test" "spec" )))

(define test-file-extensions
  (make-parameter
    '("test.scm" "spec.scm" )))

(define (exists-test-directories)
  (fold (lambda (d r)
          (if (file-is-directory? d)
            (cons d r) r))
        '() (test-directory)))

(define (file-is-test? path)
  (cond
    ((equal? "scm" (values-ref (decompose-path path) 2))
     (if-let1 ext (path-extension (values-ref (decompose-path path) 1))
       (if (member (path-swap-extension ext "scm") (test-file-extensions))
         #t #f)
       #f))
    (else #f)))

(define (find-test-file path)
  (directory-fold path
                  (lambda (entry result)
                    (let ((ext (path-extension entry)))
                      (if (file-is-test? entry)
                        (cons entry result)
                        result)))
                  '()))

(define (test-project . files)
  (cond
    ((null? (car files))
     (for-each
       (lambda (t)
         (run-process `(gosh -Isrc ,t) :wait #t))
       (apply append
              (map
                (lambda (d)
                  (find-test-file d))
                (exists-test-directories)))))
    (else
      (for-each
        (lambda (t)
          (run-process `(gosh -Isrc ,(build-path (current-directory) t)) :wait #t))
        (car files)))))
