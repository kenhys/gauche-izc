;;;
;;; Test izc
;;;

(use gauche.test)
(use gauche.interactive)
(use izc)


(test-record-file "test.record")

(test-start "misc")
(test-module 'izc)

;; The following is a dummy test code.
;; Replace it for your tests.

(cs-init)
;;(test* "test-izc" 0 (cs-get-err))

(cs-init-err)
;;(test* "CS_ERR_NONE" CS_ERR_NONE (cs-get-err))

(test* "test-izc" 0 (cs-get-min (cs-create-csint 0 1)))
(test* "test-izc" -1 (cs-get-min (cs-create-csint -1 1)))
(test* "test-izc" -2 (cs-get-min (cs-create-csint -2 -1)))

(test* "test-izc" -1 (cs-get-max (cs-create-csint -2 -1)))
(test* "test-izc" 1 (cs-get-max (cs-create-csint -1 1)))
(test* "cs-get-max" 0 (cs-get-max (cs-create-csint -2 0)))

(define domain (cs-get-domain (cs-create-csint -2 0)))
(test* "domain" -2 (list-ref domain 0))
(test* "domain" -1 (list-ref domain 1))
(test* "domain" 0 (list-ref domain 2))

(test* "cs-get-nb-elements" 3 (cs-get-nb-elements (cs-create-csint -2 0)))
(test* "cs-get-nb-constraints" 0 (cs-get-nb-constraints (cs-create-csint -2 0)))

;;(test* "cs-get-name" "" (cs-get-name (cs-create-csint 0 2)))
(test* "cs-get-name" "tmp" (cs-get-name (cs-create-named-csint 0 2 "tmp")))
;;(test* "domain" 5 (cs-get-max (cs-create-csint-from-domain (list 1 4 5 2 3))))
(test* "domain" 5 (cs-get-max (cs-create-csint-from-domain (list 1 2 3 4 5))))

(test* "cs-in-array" #t (cs-in-array (cs-create-csint 1 3) (list 1 2)))

(test* "cs-not-in-array" #t (cs-not-in-array (cs-create-csint 1 3) (list 0)))
(test* "cs-not-in-array" #t (cs-not-in-array (cs-create-csint 1 3) (list 3 0)))

;; cs-create-csint-array
(d (vector-ref (cs-create-csint-array 10 0 10) 0))
(d (vector-ref (cs-create-csint-array 10 0 10) 1))


(cs-end)

;;(test* "test-izc" 0 (cs-get-min (cs-csint 0)))

;; epilogue
(test-end)





