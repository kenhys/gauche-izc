;;;
;;; Test izc
;;;

(use gauche.test)
(use gauche.interactive)
(use izc)

(test-record-file "test.record")

(test-start "renkan")
(test-module 'izc)

;; The following is a dummy test code.
;; Replace it for your tests.

(cs-init)

(test-section "renkan-2")

(define elements 3)
(define min 1)
(define max 3)

;; A{1..3} B{1..3} C{1..3}, B = A + C
(define vint (cs-create-csint-array elements min max))
;; A != B != C
(cs-all-neq vint) 
;; 
(cs-eq-csint (~ vint 1) (cs-add (~ vint 0) (~ vint 2)))
(cs-search vint)

(test* "A" 1 (cs-get-value (~ vint 0)))
(test* "B" 3 (cs-get-value (~ vint 1)))
(test* "C" 2 (cs-get-value (~ vint 2)))

(cs-end)

;; epilogue
(test-end)





