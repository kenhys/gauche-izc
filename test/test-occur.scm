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

(test-section "cs-if-eq")





(test-section "cs-if-neq")

(test-section "cs-occur")

(test-section "cs-occur-domain")

(test-section "cs-occur-constraints")

(test* "cs-occur-constraints {1}, 3 times occur in ({1},{1},{1})" #t (cs-occur-constraints (csint 1) 3 (cs-create-csint-array 3 1 1)))
(test* "cs-occur-constraints {1}, 0 times occur in ({1},{1},{1})" #t (cs-occur-constraints (csint 1) 0 (cs-create-csint-array 3 1 1)))
(test* "cs-occur-constraints {1}, 0 times occur in ({1},{1},{1})" #t (cs-occur-constraints (csint 1) 1 (cs-create-csint-array 3 1 1)))
(test* "cs-occur-constraints {1}, 0 times occur in ({1},{1},{1})" #t (cs-occur-constraints (csint 1) 2 (cs-create-csint-array 3 1 1)))

(define vars (cs-create-csint-array 3 1 10))
(define vint (cs-create-csint 1 1))
(define times 2)
(test* "cs-occur-constraints {1}, 0 times occur in ({1},{1},{1})" #t (cs-occur-constraints vint times vars))


(test-section "cs-index")

(test-section "cs-element")
(cs-end)

;;(test* "test-izc" 0 (cs-get-min (cs-csint 0)))

;; epilogue
(test-end)





