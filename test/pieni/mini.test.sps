
(import
  (scheme base)
  (pieni mini))


(define-test is
    (is (= 4 (* 2 2)))
    (is (string=? "test" (string-append "t" "e" "s" "t"))))

(define-test are
     (are     #t     #t
               4      4
          "test" "test"
          '(a  b) '(a b)
          #(2 2)  #(2 2)))
