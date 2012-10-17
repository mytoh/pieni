
;; -*- coding: utf-8 -*-

(define-module pieni.mini
  (export
    define-test
    is
    are
    ==)
  (use gauche.test))
(select-module pieni.mini)


(define-syntax define-test
  (syntax-rules ()
    ((_ name expr ...)
     (do-test
       (test-section (symbol->string 'name))
       expr
       ...))))


(define-syntax is
  (syntax-rules ()
    ((_ (checker expect form))
     (test (quote form) expect (lambda () form) checker))))

(define-syntax are
  (syntax-rules ()
    ((_ expect form)
     (is (== expect form)))
    ((_ expect form . rest)
     (begin
       (is (== expect form))
       (are . rest)  
       ))
    ))

(define (== t1 t2)
  (cond
    ((boolean? t1)
     (eq? t1 t2))
    ((string? t1)
     (string=? t1 t2))
    ((number? t1)
     (= t1 t2))
    (else
      (equal? t1 t2))
    ))


(define-syntax do-test
  (syntax-rules ()
    ((_ body ...)
     (begin
       body
       ...))))
