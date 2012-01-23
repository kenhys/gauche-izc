;;;
;;; Test izc
;;;


(use gauche.test)
(use gauche.interactive)
(use izc)
(test-start "izc")
(test-module 'izc)

;; The following is a dum

(cs-init)


(test* "test-izc" 0 (cs-get-err))

(cs-info (cs-create-csint 0 0))
;;(test* "CS_ERR_NONE" CS_ERR_NONE (cs-get-err))

;; (test* "test-izc" 0 (cs-get-min (cs-create-csint 0 1)))
;; (test* "test-izc" -1 (cs-get-min (cs-create-csint -1 1)))
;; (test* "test-izc" -2 (cs-get-min (cs-create-csint -2 -1)))

;; (test* "test-izc" -1 (cs-get-max (cs-create-csint -2 -1)))
;; (test* "test-izc" 1 (cs-get-max (cs-create-csint -1 1)))
;; (test* "cs-get-max" 0 (cs-get-max (cs-create-csint -2 0)))

(test-section "cs-get-domain")
(test* "domain" (list 0) (cs-get-domain (cs-create-csint 0 0)))
(test* "domain" (list -2 -1 0) (cs-get-domain (cs-create-csint -2 0)))

;; SEGV
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

;; (test* "cs-get-next-value" 2 (cs-get-next-value (cs-create-csint 0 10) 1))
;; (test* "cs-get-next-value" 2147483647 (cs-get-next-value (cs-create-csint 0 10) 11))

;; (test* "cs-get-previous-value" 0 (cs-get-previous-value (cs-create-csint 0 10) 1))
;; (test* "cs-get-previous-value" -2147483648 (cs-get-previous-value (cs-create-csint 0 10) -1))

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





