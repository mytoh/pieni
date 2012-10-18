
;; -*- coding: utf-8 -*-

(define-module pieni.midje
  (export
    fact
    facts
    )
  (use gauche.test))
(select-module pieni.midje)


(define-syntax fact-checker
  (syntax-rules ()
    ((_ (checker expect form))
     (test (quote form) expect (lambda () form) checker))))

(define-syntax fact
  (syntax-rules (=>)
    ((_ form => expect)
     (fact-checker (== expect form)))
    ((_ expect => form . rest)
     (begin
       (fact-checker (== expect form))
       (fact . rest)))))


(define-syntax facts
  (syntax-rules (=>)
    ((_ desc
        form => expect)
     (begin
       (test-section desc)
       (fact form => expect)))
    ((_ desc
        form => expect . rest)
     (begin
       (test-section desc)
       (fact form => expect)
       (fact . rest)))))

(define (== t1 t2)
  (cond
    ((boolean? t1)
     (eq? t1 t2))
    ((string? t1)
     (string=? t1 t2))
    ((number? t1)
     (= t1 t2))
    (else
      (equal? t1 t2))))

