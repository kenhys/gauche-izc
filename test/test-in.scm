;;;
;;; Test izc
;;;

(use gauche.test)
(use gauche.interactive)
(use gauche.sequence)
(use gauche.collection)
(use izc)
(test-start "izc")
(test-module 'izc)

;; The following is a dummy test code.
;; Replace it for your tests.

(cs-init)


(test-section "cs-in-array")
;; cs-in-array does not require csint must contain all listed value.
(test* "1..3 contain 0?" #f (cs-in-array (cs-create-csint 1 3) (list 0)))
(test* "1..3 contain 1?" #t (cs-in-array (cs-create-csint 1 3) (list 1)))
(test* "1..3 contain 1..2?" #t (cs-in-array (cs-create-csint 1 3) (list 1 2)))
(test* "1..3 contain 3..5?" #t (cs-in-array (cs-create-csint 1 3) (list 3 4 5)))
;;
(test* "partially contain?" #t (cs-in-array (cs-create-csint 1 3) (list 0 1)))
(test* "partially contain?" #t (cs-in-array (cs-create-csint 1 1) (list 0 1 2)))


(test-section "cs-not-in-array")
(test* "cs-in-array" #f (cs-in-array (cs-create-csint 1 3) (list 0)))
(test* "cs-not-in-array" #t (cs-not-in-array (cs-create-csint 1 3) (list 0)))
(test* "cs-not-in-array" #t (cs-not-in-array (cs-create-csint 1 3) (list 3 0)))

(test-section "cs-in-interval")
(test* "cs-not-in-array" #t (cs-in-interval (cs-create-csint 1 10) 2 9))
(test* "cs-not-in-array" 2 (let* ((csint (cs-create-csint 1 10))
                                  (ret (cs-in-interval csint 2 9))
                                  )
                             (cs-get-min csint)))
(test* "cs-not-in-array" 9 (let* ((csint (cs-create-csint 1 10))
                                  (ret (cs-in-interval csint 2 9))
                                  )
                             (cs-get-max csint)))
(test* "out of range restriction fails" #f (cs-in-interval (cs-create-csint 1 10) 0 0))
(test* "out of range restriction fails" #f (cs-in-interval (cs-create-csint 1 10) 11 11))

(test-section "cs-not-in-interval")
;; cs-create-csint-array

(test-section "cs-le-csint")
(test* "none overwraped csint" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 11 20)))
(test* "{1..10} <= {11..20}" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 1 10)))
(test* "same range" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 1 20)))
(test* "same range" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 2 11)))
(test* "same range" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 10 20)))

(test* "-1 <= -1" #t (cs-le-csint (cs-create-csint -1 -1) (cs-create-csint -1 -1)))
(test* "0 <= 0" #t (cs-le-csint (cs-create-csint 0 0) (cs-create-csint 0 0)))
(test* "1 <= 1" #t (cs-le-csint (cs-create-csint 1 1) (cs-create-csint 1 1)))

(test* "-2 <= -1" #t (cs-le-csint (cs-create-csint -2 -2) (cs-create-csint -1 -1)))
(test* "-1 <= 0" #t (cs-le-csint (cs-create-csint -1 -1) (cs-create-csint 0 0)))
(test* " 0 <= 1" #t (cs-le-csint (cs-create-csint 0 0) (cs-create-csint 1 1)))
(test* " 1 <= 2" #t (cs-le-csint (cs-create-csint 1 1) (cs-create-csint 2 2)))
(test* "-2 <= 1" #t (cs-le-csint (cs-create-csint -2 -2) (cs-create-csint 1 1)))
(test* "-1 <= 2" #t (cs-le-csint (cs-create-csint -1 -1) (cs-create-csint 2 2)))

(test* "1 <= 0" #f (cs-le-csint (csint 1) (csint 0)))
(test* "1 <= 0" #f (cs-le-csint (cs-create-csint 1 1) (cs-create-csint 0 0)))
(test* "same range" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 10 10)))

(test* "same range" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 10 20)))
(test-section "cs-ge-csint")
(test-section "cs-lt-csint")
(test-section "cs-gt-csint")
(test-section "cs-eq-csint")


;;;
;;;
;;;
(test-section "cs-neq-csint")

(test* "{0} != {0}" #f (cs-neq-csint (csint 0) (csint 0)))
(test* "{0} != {1}" #t (cs-neq-csint (csint 0) (csint 1)))
(test* "{1..10} != {11..20}" #t (cs-neq-csint (cs-create-csint 1 10) (cs-create-csint 11 20)))
(test* "{1..10} != {10..20}" #t (cs-neq-csint (cs-create-csint 1 10) (cs-create-csint 10 20)))
(test* "{1..10} != {1..10}" #t (cs-neq-csint (cs-create-csint 1 10) (cs-create-csint 1 10)))


(test* "{1..10} != {11..20}" #t (cs-neq-csint (cs-create-csint 1 10) (cs-create-csint 11 20)))
(test* "{1..10} <= 1" #t (cs-le (cs-create-csint 1 10) 1))
(test* "{1..10} <= 10" #t (cs-le (cs-create-csint 1 10) 10))
(test* "{1..10} <= 11" #t (cs-le (cs-create-csint 1 10) 11))



(test-section "cs-le")

(test* "{1..10} <= 0" #f (cs-le (cs-create-csint 1 10) 0))
(test* "{1..10} <= 1" #t (cs-le (cs-create-csint 1 10) 1))
(test* "{1..10} <= 10" #t (cs-le (cs-create-csint 1 10) 10))
(test* "{1..10} <= 11" #t (cs-le (cs-create-csint 1 10) 11))

(test* "return true" #t (return-true))
(test* "return false" #f (return-false))
(test* "return 1 true" #t (return-1))
(test* "return 0 false" #f (return-0))

(test-section "cs-ge")
(test-section "cs-lt")
(test-section "cs-gt")
(test-section "cs-eq")

(test-section "cs-neq")

(define var1 (cs-create-csint 1 10))
(test* "{1..10} <> 0" #t (cs-neq  var1 0))
(test* "min" 1 (cs-get-min var1))
(test* "max" 10 (cs-get-max  var1))

(define var1 (cs-create-csint 1 10))
(test* "{1..10} <> 1" #t (cs-neq var1 1))
(test* "min" 2 (cs-get-min var1))
(test* "max" 10 (cs-get-max  var1))

(define var1 (cs-create-csint 1 10))
(test* "{1..10} <> 10" #t (cs-neq var1 10))
(test* "min" 1 (cs-get-min var1))
(test* "max" 9 (cs-get-max  var1))

(define var1 (cs-create-csint 1 10))
(test* "{1..10} <> 11" #t (cs-neq var1 11))
(test* "min" 1 (cs-get-min var1))
(test* "max" 10 (cs-get-max  var1))

(define var1 (cs-create-csint 1 1))
(test* "{1} -> not 1 constrains failed." #f (cs-neq var1 1))
(test* "error?" 0 (cs-get-err))
(test* "min" 1 (cs-get-min var1))
(test* "max" 1 (cs-get-max  var1))

(define vec (make-vector 10))

(define (init-proc index vint)
  (display index)
  (vector-set! vec index (cs-create-csint 1 10)))
(map-with-index init-proc vec)

(d vec)
(d (cs-get-min (vector-ref vec 0)))
(d (cs-get-max (vector-ref vec 0)))
(d (cs-get-min (vector-ref vec 1)))
(d (cs-get-max (vector-ref vec 1)))
(d (cs-get-min (vector-ref vec 9)))
(d (cs-get-max (vector-ref vec 9)))

(define (proc index vint)
  (display (format "~a\n" index))
  (cs-neq vint index))
(map-with-index proc vec)

(d (cs-get-min (vector-ref vec 0)))
(d (cs-get-max (vector-ref vec 0)))
(d (cs-get-min (vector-ref vec 1)))
(d (cs-get-max (vector-ref vec 1)))
(d (cs-get-min (vector-ref vec 9)))
(d (cs-get-max (vector-ref vec 9)))
(d (vector-ref vec 9))
(cs-end)

;;(test* "test-izc" 0 (cs-get-min (cs-csint 0)))

;; epilogue
(test-end)




