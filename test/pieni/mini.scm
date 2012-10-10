
(use pieni.mini)


(define-test test-mini
    (is (= 4 (* 2 2)))
    (is (string=? "test" (string-append "t" "e" "s" "t"))))
