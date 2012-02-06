;;;
;;; Test izc
;;;


(use gauche.test)
(use gauche.interactive)
(use izc)

(test-record-file "test.record")

(test-start "domain")
(test-module 'izc)

;; The following is a dum

(cs-init)


(test* "test-izc" 0 (cs-get-err))

;;
;; cs-create-csint
;;
(test-section "cs-create-csint")

(define (mktest min max)
  (let* ((vint (cs-create-csint min max)))
    (test* (format #f "domain {~D..~D}" min max)
	   #t (is-a? vint <csint>))))

(mktest 0 0)
(mktest 0 CS_INT_MAX)
(mktest CS_INT_MIN 0)
(mktest CS_INT_MIN CS_INT_MAX)


;;
;; cs-create-named-csint
;;
(test-section "cs-create-named-csint")

;;
;; cs-csint
;;
(test-section "cs-csint")

(define (mktest expect)
  (test* (format #f "domain {~D..~D}" expect expect)
         expect (cs-get-value (csint expect))))

(mktest 0)
(mktest 1)
(mktest -1)
(mktest CS_INT_MIN)
(mktest CS_INT_MAX)

(test-section "cs-create-csint-from-domain")
(test-section "cs-create-csint-array")

;;
;; cs-set-name
;;
(test-section "cs-set-name/cs-get-name")

(define (mktest expect name min max)
  (let* ((vint (cs-create-csint min max))
	 (null (cs-set-name vint name)))
    (test* (format #f "domain {~D..~D} name" min max)
	   expect (cs-get-name vint))))

(mktest "dummy" "dummy" 1 10)
;; SEGV
;;(test* "nil" #f (cs-get-name (csint 0)))

;;
;; cs-get-value
;;
(test-section "cs-get-value")

(define (mktest expect min max)
  (test* (format #f "domain {~D..~D} value" min max)
         expect (cs-get-value (cs-create-csint min max))))

(mktest 0 0 0)
(mktest 1 1 1)
(mktest CS_INT_MIN CS_INT_MIN CS_INT_MIN)
(mktest CS_INT_MAX CS_INT_MAX CS_INT_MAX)

;; not instantiated CSint
(mktest 0 0 CS_INT_MAX)
(mktest CS_INT_MIN CS_INT_MIN 0)


;;
;; cs-get-next-value
;;
(test-section "cs-get-next-value")

(define (mktest expect base min max)
  (test* (format #f "domain {~D..~D} next ~D" min max base)
         expect (cs-get-next-value (cs-create-csint min max) base)))

(mktest 1 0 1 10)
(mktest 2 1 1 10)
(mktest 3 2 1 10)
(mktest 10 9 1 10)
(mktest CS_INT_MAX 10 1 10)
(mktest CS_INT_MAX 11 1 10)

(mktest 2 1 1 CS_INT_MAX)
(mktest 3 2 1 CS_INT_MAX)
(mktest CS_INT_MAX  (- CS_INT_MAX 1) 1 CS_INT_MAX)
(mktest CS_INT_MAX CS_INT_MAX 1 CS_INT_MAX)

;;
;; cs-get-previous-value
;;
(test-section "cs-get-previous-value")

(define (mktest expect base min max)
  (test* (format #f "domain {~D..~D} previous ~D" min max base)
         expect (cs-get-previous-value (cs-create-csint min max) base)))

(mktest CS_INT_MIN 1 1 10)
(mktest 1 2 1 10)
(mktest 8 9 1 10)
(mktest 9 10 1 10)
(mktest 10 11 1 10)

(mktest CS_INT_MIN 1 1 CS_INT_MAX)
(mktest 1 2 1 CS_INT_MAX)
(mktest (- CS_INT_MAX 2) (- CS_INT_MAX 1) 1 CS_INT_MAX)
(mktest (- CS_INT_MAX 1) CS_INT_MAX 1 CS_INT_MAX)

(test-section "cs-is-free")
(test-section "cs-is-instantiated")
(test-section "cs-get-nb-elements")
(test-section "cs-get-nb-constraints")


;;;
;;; cs-get-domain
;;;
(test-section "cs-get-domain")

(define (mktest expect min max)
  (test* (format #f "domain {~D..~D}" min max)
         expect (cs-get-domain (cs-create-csint min max))))

(mktest '(0) 0 0)
(mktest '(-1 0 1) -1 1)
;(mktest '(-1 0 1) 0 CS_INT_MAX)
;(cs-info (cs-create-csint CS_INT_MIN CS_INT_MAX))

;; NOTE: SEGV
;;(mktest '((- CS_INT_MAX 1) CS_INT_MAX) (- CS_INT_MAX 1) CS_INT_MAX)

;;(test* "CS_ERR_NONE" CS_ERR_NONE (cs-get-err))

;; (test* "test-izc" 0 (cs-get-min (cs-create-csint 0 1)))
;; (test* "test-izc" -1 (cs-get-min (cs-create-csint -1 1)))
;; (test* "test-izc" -2 (cs-get-min (cs-create-csint -2 -1)))

;; (test* "test-izc" -1 (cs-get-max (cs-create-csint -2 -1)))
;; (test* "test-izc" 1 (cs-get-max (cs-create-csint -1 1)))
;; (test* "cs-get-max" 0 (cs-get-max (cs-create-csint -2 0)))


;; NOTE: SEGV
;;(test* "domain" (list 2147483647) (cs-get-domain (cs-create-csint 2147483647 2147483647)))
;; SEGV
;;(test* "domain" (list -2147483648) (cs-get-domain (cs-create-csint -2147483648 -2147483648)))
;; SEGV
;;(test* "domain" (list 2147483647) (cs-get-domain (cs-create-csint 2147483647 2147483648)))

;; (test* "cs-get-nb-elements" 3 (cs-get-nb-elements (cs-create-csint -2 0)))
;; (test* "cs-get-nb-constraints" 0 (cs-get-nb-constraints (cs-create-csint -2 0)))

;; ;;(test* "cs-get-name" "" (cs-get-name (cs-create-csint 0 2)))
;; (test* "cs-get-name" "tmp" (cs-get-name (cs-create-named-csint 0 2 "tmp")))
;; ;;(test* "domain" 5 (cs-get-max (cs-create-csint-from-domain (list 1 4 5 2 3))))
;; (test* "domain" 5 (cs-get-max (cs-create-csint-from-domain (list 1 2 3 4 5))))


;; (test* "cs-in-array" #t (cs-in-array (cs-create-csint 1 3) (list 1 2)))

;; (test* "cs-not-in-array" #t (cs-not-in-array (cs-create-csint 1 3) (list 0)))
;; (test* "cs-not-in-array" #t (cs-not-in-array (cs-create-csint 1 3) (list 3 0)))

;; ;; cs-create-csint-array
;; (d (vector-ref (cs-create-csint-array 10 0 10) 0))
;; (d (vector-ref (cs-create-csint-array 10 0 10) 1))


;;(test* "test-izc" 0 (cs-get-min (cs-csint 0)))

(cs-end)

;; epilogue
(test-end)





