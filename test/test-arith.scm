;;;
;;; Test izc
;;;

(use gauche.test)
(use gauche.interactive)
(use izc)

(test-record-file "test.record")

(test-start "arith")
(test-module 'izc)

;; The following is a dummy test code.
;; Replace it for your tests.

(cs-init)
;;(test* "test-izc" 0 (cs-get-err))

(test-section "cs-add")

(test* "cs-add {0} and {0}" 0 (cs-get-value (cs-add (csint 0) (csint 0))))
(test* "cs-add {0} and {0}, cs-get-min" 0 (cs-get-min (cs-add (csint 0) (csint 0))))
(test* "cs-add {0} and {0}, cs-get-max" 0 (cs-get-max (cs-add (csint 0) (csint 0))))


(test* "cs-add {0} and {1}, cs-get-value" 1 (cs-get-value (cs-add (csint 0) (csint 1))))
(test* "cs-add {0} and {1}, cs-get-min" 1 (cs-get-min (cs-add (cs-create-csint 0 0) (cs-create-csint 1 1))))
(test* "cs-add {0} and {1}, cs-get-max" 1 (cs-get-max (cs-add (cs-create-csint 0 0) (cs-create-csint 1 1))))

(test* "cs-add {0} and {1}, cs-get-domain" '(1) (cs-get-domain (cs-add (csint 0) (csint 1))))
(test* "cs-add {1} and {1}, cs-get-domain" '(2) (cs-get-domain (cs-add (csint 1) (csint 1))))
(test* "cs-add {0} and {2}, cs-get-domain" '(2) (cs-get-domain (cs-add (csint 0) (csint 2))))
(test* "cs-add {-1} and {1}, cs-get-domain" '(0) (cs-get-domain (cs-add (csint -1) (csint 1))))

(test* "cs-add {0..1} and {1..2}, cs-get-domain" '(1 2 3) (cs-get-domain (cs-add (cs-create-csint 0 1) (cs-create-csint 1 2))))

(test* "cs-add {-1..1} and {-2..2}, cs-get-domain" '(-3 -2 -1 0 1 2 3) (cs-get-domain (cs-add (cs-create-csint -1 1) (cs-create-csint -2 2))))


(test-section "cs-sub")

(test* "cs-sub {0} and {0}" 0 (cs-get-value (cs-sub (csint 0) (csint 0))))
(test* "cs-sub {0} and {0}, cs-get-min" 0 (cs-get-min (cs-sub (csint 0) (csint 0))))
(test* "cs-sub {0} and {0}, cs-get-max" 0 (cs-get-max (cs-sub (csint 0) (csint 0))))

(test* "cs-sub {0} and {1}" -1 (cs-get-value (cs-sub (csint 0) (csint 1))))
(test* "cs-sub {0} and {1}, cs-get-min" -1 (cs-get-min (cs-sub (csint 0) (csint 1))))
(test* "cs-sub {0} and {1}, cs-get-max" -1 (cs-get-max (cs-sub (csint 0) (csint 1))))

(test* "cs-sub {-1} and {-1}" 0 (cs-get-value (cs-sub (csint -1) (csint -1))))
(test* "cs-sub {-1} and {-1}, cs-get-min" 0 (cs-get-min (cs-sub (csint -1) (csint -1))))
(test* "cs-sub {-1} and {-1}, cs-get-max" 0 (cs-get-max (cs-sub (csint -1) (csint -1))))

(test* "cs-sub {1..10} and {0..1}" 0 (cs-get-value (cs-sub (cs-create-csint 1 10) (cs-create-csint 0 1))))
(test* "cs-sub {-1} and {-1}, cs-get-min" 0 (cs-get-min (cs-sub (csint -1) (csint -1))))
(test* "cs-sub {-1} and {-1}, cs-get-max" 0 (cs-get-max (cs-sub (csint -1) (csint -1))))

(cs-end)

;; epilogue
(test-end)





