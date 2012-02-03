;;;
;;; Test izc
;;;

(use gauche.test)
(use gauche.interactive)
(use izc)

(test-record-file "test.record")

(test-start "occur")
(test-module 'izc)

;; The following is a dummy test code.
;; Replace it for your tests.

(cs-init)

;;
;; cs-if-neq
;;
(test-section "cs-if-eq")

(define (mktest min max min2 max2 inst aff)
  (let* ((vint (cs-create-csint min max))
	 (vint2 (cs-create-csint min2 max2))
	 (null (test* "not instantiated" #f (cs-is-instantiated vint)))
	 (null (test* "not instantiated" #f (cs-is-instantiated vint)))
	 (null (test* (format #f "conditional constraints if {~D..~D} instantiated to ~D, then {~D..~D} instantiated to ~D"
			      min max inst min max aff) 
		      #t (cs-if-eq vint vint2 inst aff)))
	 )
    (begin
      (test* (format #f "{~D..~D} min value" min max) min (cs-get-min vint))
      (test* (format #f "{~D..~D} max value" min max) max (cs-get-max vint))
      (test* (format #f "{~D..~D} min value" min2 max2) min2 (cs-get-min vint2))
      (test* (format #f "{~D..~D} max value" min2 max2) max2 (cs-get-max vint2))
      (test* (format #f "{~D..~D} instantiated to ~D" min max inst) #t (cs-eq vint inst))
      ;;(test* (format #f "if {~D..~D} instantiated to ~D, then {~D..~D} instantiated to ~D"
      (test* (format #f "{~D..~D} instantiated to ~D(min)" min2 max2 aff) aff (cs-get-min vint2))  
      (test* (format #f "{~D..~D} instantiated to ~D(max)" min2 max2 aff) aff (cs-get-min vint2))
      (test* (format #f "{~D..~D} instantiated to ~D" min2 max2 aff) aff (cs-get-max vint2))
      )))

(mktest 0 10 0 10 0 10)
(mktest 0 10 0 10 0 0)


;;
;; cs-if-neq
;;
(test-section "cs-if-neq")

;;
;; cs-occur
;;
(test-section "cs-occur")

;;
;; cs-occur-domain
;;
(test-section "cs-occur-domain")

;;
;; cs-occur-constraints
;;
(test-section "cs-occur-constraints")

(test* "cs-occur-constraints {1}, 3 times occur in ({1},{1},{1})" #t (cs-occur-constraints (csint 1) 3 (cs-create-csint-array 3 1 1)))
(test* "cs-occur-constraints {1}, 0 times occur in ({1},{1},{1})" #t (cs-occur-constraints (csint 1) 0 (cs-create-csint-array 3 1 1)))
(test* "cs-occur-constraints {1}, 0 times occur in ({1},{1},{1})" #t (cs-occur-constraints (csint 1) 1 (cs-create-csint-array 3 1 1)))
(test* "cs-occur-constraints {1}, 0 times occur in ({1},{1},{1})" #t (cs-occur-constraints (csint 1) 2 (cs-create-csint-array 3 1 1)))

(define vars (cs-create-csint-array 3 1 10))
(define vint (cs-create-csint 1 1))
(define times 2)
(test* "cs-occur-constraints {1}, 0 times occur in ({1},{1},{1})" #t (cs-occur-constraints vint times vars))

;;
;; cs-index
;;
(test-section "cs-index")

;;
;; cs-element
;;
(test-section "cs-element")

(cs-end)

;;(test* "test-izc" 0 (cs-get-min (cs-csint 0)))

;; epilogue
(test-end)





