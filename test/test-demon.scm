;;;
;;; Test izc
;;;

(use gauche.test)
(use gauche.interactive)
(use gauche.parameter)
(use izc)

(test-record-file "test.record")

(test-start "demon")
(test-module 'izc)

;; The following is a dummy test code.
;; Replace it for your tests.

(cs-init)

(define cs_inst (make-parameter #f))
(define cs_val (make-parameter 0))
(define cs_index (make-parameter 0))

;;
;; cs-event-all-known
;;
(test-section "cs-event-all-known")

;;
;; cs-event-known
;;
(test-section "cs-event-known")

(define (test-known val index array)
  (begin
    (display (format "test-known proc called val:~a index:~a\n" val index))
    (display "test-known proc called\n")
    (set! (cs_inst) #t)
    (set! (cs_index) index)
    (set! (cs_val) val)))

(define vars (cs-create-csint-array 10 0 10))
(cs-event-known vars test-known)

(define (mktest index val)
  (let* ()
    (set! (cs_inst) #f)
    (set! (cs_val) -1)
    (set! (cs_index) -1)
    (test* "" #f (cs_inst))
    (cs-eq (~ vars index) val)
    (test* "" #t (cs_inst))
    (test* "" index (cs_index))
    (test* "" val (cs_val))))

(dotimes (i 10 #f) (mktest i i))



;;
;; cs-event-new-min
;;
(test-section "cs-event-new-min")

(define (test-new-min vint index oldmin allvars)
  (begin
    (format "test-new-min proc called val:~a index:~a\n" oldmin index)
    (display "test-new-min proc called\n")
    (set! (cs_inst) #t)
    (set! (cs_index) index)
    (set! (cs_val) oldmin)))

(define (mktest index min)
  (let* ((oldmin (cs-get-min (~ vars index)))
	 (oldmax (cs-get-max (~ vars index)))
	 (newmin oldmin)
	 (newmax oldmax))
    (set! (cs_inst) #f)
    (set! (cs_val) -1)
    (set! (cs_index) -1)
    (test* "" #f (cs_inst))
    (cs-ge (~ vars index) min)
    (test* (format #f "{~D..~D} min changed to {~D..~D}" 
		   oldmin oldmax 
		   (cs-get-min (~ vars index)) newmax)
	   min (cs-get-min (~ vars index)))
    (test* (format #f "vars[~D]" index) index (cs_index))
    (test* "" oldmin (cs_val))))

(define vars (cs-create-csint-array 10 0 10))
(cs-event-new-min vars test-new-min)
(dotimes (i 10 #f) (mktest i (+ i 1)))


;;
;; cs-event-new-max
;;
(test-section "cs-event-new-max")

(define (test-new-max vint index old allvars)
  (begin
    (format "test-new-max proc called val:~a index:~a\n" old index)
    (display "test-new-max proc called\n")
    (set! (cs_inst) #t)
    (set! (cs_index) index)
    (set! (cs_val) old)))

(define (mktest index max)
  (let* ((oldmin (cs-get-min (~ vars index)))
	 (oldmax (cs-get-max (~ vars index)))
	 (newmin oldmin)
	 (newmax oldmax))
    (set! (cs_inst) #f)
    (set! (cs_val) -1)
    (set! (cs_index) -1)
    (test* "" #f (cs_inst))
    (cs-le (~ vars index) max)
    (test* (format #f "{~D..~D} max changed to {~D..~D}" 
		   oldmin oldmax 
		   newmin (cs-get-max (~ vars index)))
	   max (cs-get-max (~ vars index)))
    (test* (format #f "vars[~D]" index) index (cs_index))
    (test* "" oldmax (cs_val))))

(define vars (cs-create-csint-array 10 0 10))
(cs-event-new-max vars test-new-max)
(dotimes (i 10 #f) (mktest i (+ i 1)))

;;
;; cs-event-neq
;;
(test-section "cs-event-neq")

(define (test-neq vint index val allvars)
  (begin
    (format "test-neq proc is called csint:{~D..~D} index:~D val:~D\n"
	    (cs-get-min vint) (cs-get-max vint) index val)
    (display "test-new-max proc called\n")
    (set! (cs_inst) #t)
    (set! (cs_index) index)
    (set! (cs_val) val)))

(define (mktest index val expect)
  (let* ((oldmin (cs-get-min (~ vars index)))
	 (oldmax (cs-get-max (~ vars index)))
	 (newmin oldmin)
	 (newmax oldmax))
    (set! (cs_inst) #f)
    (set! (cs_val) -1)
    (set! (cs_index) -1)
    (test* "" #f (cs_inst))
    (cs-neq (~ vars index) val)
    (test* (format #f "{~D..~D} max changed to {~a}" 
		   oldmin oldmax 
		   (cs-get-domain (~ vars index)))
	   expect (cs-get-domain (~ vars index)))
    (test* (format #f "vars[~D]" index) index (cs_index))
    (test* "" val (cs_val))))

(define vars (cs-create-csint-array 10 0 10))
(cs-event-neq vars test-neq)
;;(dotimes (i 10 #f) (mktest i (+ i 1)))
(mktest 0 2 '(0 1 3 4 5 6 7 8 9 10))

(cs-end)

;; epilogue
(test-end)
