
(import
  (scheme base)
  (pieni midje))

(fact (+ 1 1) => 2
      "fact"  => "fact")

(facts "about arithmetic"
       (+ 1 0) => 1
       (* 1 1) => 1)

(facts "about string"
       "test" => "test"
       (string-append "f" "a" "c" "t") => "fact")
