;;;
;;; Test izc
;;;

(use gauche.test)
(use gauche.interactive)
(use izc)
(test-start "izc")
(test-module 'izc)

;; The following is a dummy test code.
;; Replace it for your tests.

(cs-init)
;;(test* "test-izc" 0 (cs-get-err))

(cs-init-err)

(test-section "cs-get-min")
(test* "test-izc" 0 (cs-get-min (cs-create-csint 0 1)))
(test* "test-izc" -1 (cs-get-min (cs-create-csint -1 1)))
(test* "test-izc" -2 (cs-get-min (cs-create-csint -2 -1)))

(test-section "cs-get-max")
(test* "test-izc" -1 (cs-get-max (cs-create-csint -2 -1)))
(test* "test-izc" 1 (cs-get-max (cs-create-csint -1 1)))
(test* "cs-get-max" 0 (cs-get-max (cs-create-csint -2 0)))

(cs-end)

;; epilogue
(test-end)





