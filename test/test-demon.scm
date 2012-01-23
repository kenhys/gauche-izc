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
;;(test* "CS_ERR_NONE" CS_ERR_NONE (cs-get-err))

(test-section "cs-event-known")

(define (test-known val index array)
  (begin
    (display (format "test-known proc called val:~a index:~a\n" val index))
    (display "test-known proc called\n")
    #t))

(define vint (cs-create-csint 0 10))
(d vint)
(define vars (make-vector 1 vint))
(d vars)
(cs-event-known vars test-known)
(cs-eq vint 10)

(cs-end)

;;(test* "test-izc" 0 (cs-get-min (cs-csint 0)))

;; epilogue
(test-end)
