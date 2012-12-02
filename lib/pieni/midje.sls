
(library (pieni midje)
  (export
    fact
    facts)
  (import
    (scheme base)
    (scheme write)
    (pieni check))

  (begin


    (define-syntax fact
      (syntax-rules (=>)
        ((_ form => expect)
         (check form => expect))
        ((_ form => expect . rest)
         (begin
           (check form => expect)
           (fact . rest)))))


    (define-syntax facts
      (syntax-rules (=>)
        ((_ desc
            form => expect)
         (begin
           (display desc)
           (newline)
           (fact form => expect)))
        ((_ desc
            form => expect . rest)
         (begin
           (display desc)
           (newline)
           (fact form => expect)
           (fact . rest)))))
;
;     (define (== t1 t2)
;       (cond
;         ((boolean? t1)
;          (eq? t1 t2))
;         ((string? t1)
;          (string=? t1 t2))
;         ((number? t1)
;          (= t1 t2))
;         (else
;           (equal? t1 t2))))

    ))

