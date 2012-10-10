
;; -*- coding: utf-8 -*-

(define-module pieni.mini
  (export
    define-test
    is)
  (use gauche.test))
(select-module pieni.mini)


(define-syntax define-test
  (syntax-rules ()
    ((_ name expr ...)
     (begin
       (test-section (symbol->string 'name))
       expr
       ...
       (test-end))))
  )


(define-syntax is
  (syntax-rules ()
    ((_ (checker expect form))
     (test (quote expr) expect (lambda () form) checker))))


