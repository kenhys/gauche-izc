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

(test-section "cs-backtrack")

(test-section "cs-save-context")
(test-section "cs-forget-save-context")
(test-section "cs-restore-and-save-context")
(test-section "cs-accept-cotext")
(test-section "cs-accept-all")
(test-section "cs-restore-context")
(test-section "cs-restore-all")
(test-section "cs-forget-save-context-save-until")
(test-section "cs-accept-context-save-until")
(test-section "cs-restore-context-save-until")
(cs-end)

;;(test* "test-izc" 0 (cs-get-min (cs-csint 0)))

;; epilogue
(test-end)





