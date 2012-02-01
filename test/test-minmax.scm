;;;
;;; Test izc
;;;

(use gauche.test)
(use gauche.interactive)
(use izc)

(test-record-file "test.record")

(test-start "minmax")
(test-module 'izc)

;; The following is a dummy test code.
;; Replace it for your tests.

(cs-init)


;;;
;;; cs-get-min
;;;
(test-section "cs-get-min")

(define (mktest proc expect min max)
                (test* (format #f "check min {~D..~D}" min max)
                       expect (proc (cs-create-csint min max))))

(mktest cs-get-min 0 0 0)
(mktest cs-get-min -1 -1 -1)
(mktest cs-get-min CS_INT_MIN CS_INT_MIN CS_INT_MIN)
(mktest cs-get-min CS_INT_MAX CS_INT_MAX CS_INT_MAX)
(mktest cs-get-min CS_INT_MIN CS_INT_MIN CS_INT_MAX)

(mktest cs-get-min CS_INT_MIN (- CS_INT_MIN 1) CS_INT_MAX)

;;;
;;; cs-get-max
;;;
(test-section "cs-get-max")

(define (mktest proc expect min max)
                (test* (format #f "check max {~D..~D}" min max)
                       expect (proc (cs-create-csint min max))))

(mktest cs-get-max 0 0 0)
(mktest cs-get-max -1 -1 -1)
(mktest cs-get-max CS_INT_MIN CS_INT_MIN CS_INT_MIN)
(mktest cs-get-max CS_INT_MAX CS_INT_MAX CS_INT_MAX)
(mktest cs-get-max CS_INT_MAX CS_INT_MIN CS_INT_MAX)

(mktest cs-get-max CS_INT_MAX CS_INT_MIN (+ CS_INT_MAX 1))

;;;
;;; cs-get-next-value
;;;
(test-section "cs-get-next-value")

(define (mktest proc expect min max base)
  (test* (format #f "check {~D..~D} next value of ~D " min max base)
         expect (proc (cs-create-csint min max) base)))

(mktest cs-get-next-value -9 -10 10 -10)
(mktest cs-get-next-value -8 -10 10 -9)
(mktest cs-get-next-value 0 -10 10 -1)
(mktest cs-get-next-value 1 -10 10 0)
(mktest cs-get-next-value 10 -10 10 9)
(mktest cs-get-next-value CS_INT_MAX -10 10 10)

;;;
;;; cs-get-previous-value
;;;
(test-section "cs-get-previous-value")

(define (mktest proc expect min max base)
  (test* (format #f "check {~D..~D} previous value of ~D " min max base)
         expect (proc (cs-create-csint min max) base)))

(mktest cs-get-previous-value CS_INT_MIN -10 10 -10)
(mktest cs-get-previous-value -10 -10 10 -9)
(mktest cs-get-previous-value -2 -10 10 -1)
(mktest cs-get-previous-value -1 -10 10 0)
(mktest cs-get-previous-value 8 -10 10 9)
(mktest cs-get-previous-value 9 -10 10 10)

(cs-end)

;; epilogue
(test-end)





