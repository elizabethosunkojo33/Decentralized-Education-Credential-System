;; Credential Issuance Contract

;; Data
(define-map credentials uint {student: principal, course-id: uint, issued-on: uint})

;; Error codes
(define-constant ERR-NOT-FOUND (err u404))
(define-constant ERR-UNAUTHORIZED (err u403))

;; Functions
(define-public (issue-credential (id uint) (student principal) (course-id uint))
  (ok (map-set credentials id {student: student, course-id: course-id, issued-on: block-height})))

(define-read-only (get-credential (id uint))
  (match (map-get? credentials id)
    credential (ok credential)
    ERR-NOT-FOUND))

(define-read-only (verify-credential (id uint) (student principal) (course-id uint))
  (match (map-get? credentials id)
    credential (ok (and
                    (is-eq (get student credential) student)
                    (is-eq (get course-id credential) course-id)))
    ERR-NOT-FOUND))

