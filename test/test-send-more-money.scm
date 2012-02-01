;;;
;;; Test izc
;;;

(use gauche.test)
(use gauche.interactive)
(use izc)

(test-record-file "test.record")

(test-start "send-more-money")
(test-module 'izc)

;; The following is a dummy test code.
;; Replace it for your tests.

(cs-init)

(test-section "send-more-money")

(define elements 8)
(define min 0)
(define max 9)

(define vint (cs-create-csint-array elements min max))
(cs-all-neq vint) 
;;
(define S (~ vint 0))
(define E (~ vint 1))
(define N (~ vint 2))
(define D (~ vint 3))
(define M (~ vint 4))
(define O (~ vint 5))
(define R (~ vint 6))
(define Y (~ vint 7))

(define val (list->vector '(1000 100 10 1)))
(define val2 (list->vector '(10000 1000 100 10 1)))

;; must not use list->vector
(define send (make-vector 4))
(vector-set! send 0 S)
(vector-set! send 1 E)
(vector-set! send 2 N)
(vector-set! send 3 D)

(define more (make-vector 4))
(vector-set! more 0 M)
(vector-set! more 1 O)
(vector-set! more 2 R)
(vector-set! more 3 E)

(define money (make-vector 5))
(vector-set! money 0 M)
(vector-set! money 1 O)
(vector-set! money 2 N)
(vector-set! money 3 E)
(vector-set! money 4 Y)

(define l1 (cs-scal-prod  send val 4))
(define l2 (cs-scal-prod more val 4))
(define l3 (cs-scal-prod money val2 5))
(cs-eq-csint l3 (cs-add l1 l2))
(cs-neq S 0)
(cs-neq M 0)

(cs-search vint)

(define (mktest val index ans)
  (test* "" (~ ans index) (cs-get-value (~ val index))))

(define send-ans '(9 5 6 7))
(mktest send 0 send-ans)
(mktest send 1 send-ans)
(mktest send 2 send-ans)
(mktest send 3 send-ans)

(define more-ans '(1 0 8 5))
(mktest more 0 more-ans)
(mktest more 1 more-ans)
(mktest more 2 more-ans)
(mktest more 3 more-ans)
;;(9,5,6,7,1,0,8,2};
(define money-ans '(1 0 6 5 2))
(mktest money 0 money-ans)
(mktest money 1 money-ans)
(mktest money 2 money-ans)
(mktest money 3 money-ans)
(mktest money 4 money-ans)
(cs-end)

;; epilogue
(test-end)





