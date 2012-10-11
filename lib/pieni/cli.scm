(define-module pieni.cli
  (export runner)
  (use gauche.parseopt)
  (use util.match)
  (use file.util)
  (use pieni.core)
  (use pieni.commands)
  )
(select-module pieni.cli)

(define runner
  (lambda (args)
    (let-args (cdr args)
      ((format "f|format" )
       . rest)
      (match rest
        ;; actions
        ("test"
         (run-test rest))
        ("help"
         (help))
        (_ (run-test rest))))))
