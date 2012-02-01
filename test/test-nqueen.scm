;;;
;;; Test izc
;;;

(add-load-path "../")

(use gauche.test)
(use gauche.interactive)
(use gauche.uvector)
(use gauche.collection)
(use gauche.sequence)
(use izc)
(use srfi-1)

(test-record-file "test.record")

(test-start "nqueen")
(test-module 'izc)

(define (known-queen val index allvars)
  (define (chk-neq i vint)
    (let* (;(null (display (format "chk-neq: ~a\n" i)))
           ;(null (cs-info vint))
            )
      (if (not (= i index))
          (if (cs-neq vint val)
              (if (cs-neq vint (- (+ val index) i))
                  (if (cs-neq vint (- (+ val i) index))
                      #t
                      #f)
                  ;; may be true
                  #f)
              #f)
          #t)
      ))
    
        ;;(every (lambda (b) b) (map-with-index chk-neq allvars)))
    ((every$ (lambda (b) b)) (map-with-index chk-neq allvars)))
      ;;(d (format "known-queen val: ~a index: ~a" val index))
      ;;(d allvars)
      ;;(d flag)
      ;;flag))

;; (define (known-queen-test val index allvars)
;;   (define (chk-neq i vint)
;;     (list-ref
;;      ;;'(#t #t #t #t #t #t #t #f)
;;      ;;'(#f #f #f #f #f #f #f #f)
;;      ;;'(#t #t #t #t #t #t #t #f)
;;      ;;'(#t #t #t #t #t #t #t #f)
;;      i))
;;     ;;(every (lambda (b) b) (map-with-index chk-neq allvars)))
;;   ((every$ (lambda (b) b)) (map-with-index chk-neq allvars)))

;; (define tvec (make-vector 8))
;; (d (known-queen-test 0 1 tvec))
;; (exit)

(define vec (make-vector 1))

;; procedure 'found' passed vector of csint.
;; csint must be solved in specific integer.
;; (define (found vars)
;;   (let loop ((i 0))
;;     (if (< i (vector-length vars))
;;         (cond
;;          ((= i 0)
;;           (display (format "(~a " (cs-get-value (vector-ref vars i))))
;;           (loop (+ i 1)))
;;          ((= i (- (vector-length vars) 1))
;;           (display (format "~a)\n" (cs-get-value (vector-ref vars i)))))
;;          (else
;;           (display (format "~a " (cs-get-value (vector-ref vars i))))
;;           (loop (+ i 1))))
;;         )))
(define (found vars)
  (display (format "~a\n" (map cs-get-value vars))))

;; You must call first.
(cs-init)

(define nqueens 8)
(define allvars (cs-create-csint-array nqueens 1 8))
(map-with-index (lambda (index val) (cs-info val)) allvars)


(test-section "cs-search")
(define allvars (cs-create-csint-array nqueens 1 8))
(cs-event-known allvars known-queen)
(cs-search allvars 'elements-min)
(test* "cs-search 'elements-min" '(1 7 2 6 3 8 4 5) (map cs-get-value allvars))

(test-section "cs-find-all")
;; we decide to solve 8 queen problem!
(define allvars (cs-create-csint-array nqueens 1 8))
(cs-event-known allvars known-queen)
(cs-find-all allvars 'elements-min found)
(map-with-index (lambda (index val) (cs-info val)) allvars)
;;(cs-find-all allvars #f found)
;;(cs-find-all allvars cs-find-free-var-nb-elements-min found)



(cs-end)

;; epilogue
(test-end)





