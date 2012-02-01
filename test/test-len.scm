;;;
;;; Test izc
;;;

(use gauche.test)
(use gauche.interactive)
(use izc)

(test-record-file "test.record")

(test-start "len")
(test-module 'izc)

;; The following is a dummy test code.
;; Replace it for your tests.

(test-record-file "test.record")

(cs-init)

;;;
;;;
;;;
(define *int-min* (- -2147483647 1))
(define *int-max* 2147483647)

(test* "check INT_MIN" *int-min* CS_INT_MIN)
(test* "check INT_MAX" *int-max* CS_INT_MAX)

;;;
;;; cs-eq
;;;
(test-section "cs-eq")

(test* "{0} <= 0" #t (cs-eq (csint 0) 0))
(test* "{CS_INT_MIN} = CS_INT_MIN" #t (cs-eq (csint CS_INT_MIN) CS_INT_MIN))
(test* "{CS_INT_MAX} = CS_INT_MAX" #t (cs-eq (csint CS_INT_MAX) CS_INT_MAX))

;;;
;;; cs-eq-csint
;;;
(test-section "cs-eq-csint")

(test* "{0} <= 0" #t (cs-eq-csint (csint 0) (csint 0)))
(test* "{CS_INT_MIN} = {CS_INT_MIN}" #t (cs-eq-csint (csint CS_INT_MIN) (csint CS_INT_MIN)))
(test* "{CS_INT_MAX} = {CS_INT_MAX}" #t (cs-eq-csint (csint CS_INT_MAX) (csint CS_INT_MAX)))


;;;
;;; cs-neq
;;;
(test-section "cs-neq")

(test* "{0} != CS_INT_MIN" #t (cs-neq (csint 0) CS_INT_MIN))
(test* "{0} != CS_INT_MAX" #t (cs-neq (csint 0) CS_INT_MAX))
(test* "{CS_INT_MIN} != CS_INT_MAX" #t (cs-neq (csint CS_INT_MIN) CS_INT_MAX))
(test* "{CS_INT_MAX} != CS_INT_MIN" #t (cs-neq (csint CS_INT_MAX) CS_INT_MIN))

;;;
;;; cs-neq-csint
;;;
(test-section "cs-neq-csint")

(test* "{0} != {0}" #f (cs-neq-csint (csint 0) (csint 0)))
(test* "{0} != {1}" #t (cs-neq-csint (csint 0) (csint 1)))
(test* "{1..10} != {11..20}" #t (cs-neq-csint (cs-create-csint 1 10) (cs-create-csint 11 20)))
(test* "{1..10} != {10..20}" #t (cs-neq-csint (cs-create-csint 1 10) (cs-create-csint 10 20)))
(test* "{1..10} != {1..10}" #t (cs-neq-csint (cs-create-csint 1 10) (cs-create-csint 1 10)))


(test* "{1..10} != {11..20}" #t (cs-neq-csint (cs-create-csint 1 10) (cs-create-csint 11 20)))

;;;
;;; cs-le
;;;
(test-section "cs-le")

(test* "{0} <= 0" #t (cs-le (csint 0) 0))
(test* "{CS_INT_MIN} <= CS_INT_MIN" #t (cs-le (csint CS_INT_MIN) CS_INT_MIN))
(test* "{CS_INT_MAX} <= CS_INT_MAX" #t (cs-le (csint CS_INT_MAX) CS_INT_MAX))
(test* "{CS_INT_MIN} <= CS_INT_MAX" #t (cs-le (csint CS_INT_MIN) CS_INT_MAX))

(define mkcsint (lambda () (cs-create-csint 1 10)))

(test* "{1..10} <= 0" #f (cs-le (mkcsint) 0))
(test* "{1..10} <= 1" #t (cs-le (mkcsint) 1))
(test* "{1..10} <= 10" #t (cs-le (mkcsint) 10))
(test* "{1..10} <= 11" #t (cs-le (mkcsint) 11))

(define mkcsint (lambda () (cs-create-csint 1 10)))

;;;
;;; cs-le-csint
;;;
(test-section "cs-le-csint")

(test* "{1..10} <= {11..20}" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 11 20)))
(test* "{1..10} <= {1..10}" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 1 10)))
(test* "same range" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 1 20)))
(test* "same range" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 2 11)))
(test* "same range" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 10 20)))

(test* "-1 <= -1" #t (cs-le-csint (csint -1) (csint -1)))
(test* "0 <= 0" #t (cs-le-csint (csint 0) (csint 0)))
(test* "1 <= 1" #t (cs-le-csint (csint 1) (csint 1)))

(test* "-2 <= -1" #t (cs-le-csint (csint -2) (csint -1)))
(test* "-1 <= 0" #t (cs-le-csint (csint -1) (csint 0)))
(test* " 0 <= 1" #t (cs-le-csint (csint 0) (csint 1)))
(test* " 1 <= 2" #t (cs-le-csint (csint 1) (csint 2)))
(test* "-2 <= 1" #t (cs-le-csint (csint -2) (csint 1)))
(test* "-1 <= 2" #t (cs-le-csint (csint -1) (csint 2)))

(test* "1 <= 0" #f (cs-le-csint (csint 1) (csint 0)))
(test* "1 <= 0" #f (cs-le-csint (cs-create-csint 1 1) (cs-create-csint 0 0)))
(test* "same range" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 10 10)))

(test* "same range" #t (cs-le-csint (cs-create-csint 1 10) (cs-create-csint 10 20)))

;;;
;;; cs-ge
;;;
(test-section "cs-ge")

;;;
;;; cs-ge-csint
;;;
(test-section "cs-ge-csint")

;;;
;;; cs-lt
;;;
(test-section "cs-lt")

;;;
;;; cs-lt-csint
;;;
(test-section "cs-lt-csint")

;;;
;;; cs-ge
;;;
(test-section "cs-gt")

;;;
;;; cs-gt-csint
;;;
(test-section "cs-gt-csint")

(cs-end)

;; epilogue
(test-end)





