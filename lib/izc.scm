;;;
;;; izc
;;;

(define-module izc
  (export-all)
  )
(select-module izc)

;; Loads extension
(dynamic-load "izc")

;;
;; Put your Scheme definitions here
;;

;; default return type is vector.
(define cs-create-csint-array cs-create-csint-vector)
;;(define cs-create-csint-array cs-create-csint-list)

(define-method cs-all-neq ((self <list>)) (cs-all-neq-list self))
(define-method cs-all-neq ((self <vector>)) (cs-all-neq-vector self))

;; Epilogue
(provide "izc")


