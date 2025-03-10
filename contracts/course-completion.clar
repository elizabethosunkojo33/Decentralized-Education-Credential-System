;; Course Completion Contract

;; Data
(define-map courses uint {name: (string-ascii 64), credits: uint})
(define-map completions {student: principal, course-id: uint} {completed: bool, grade: (string-ascii 2)})

;; Error codes
(define-constant ERR-NOT-FOUND (err u404))
(define-constant ERR-UNAUTHORIZED (err u403))

;; Functions
(define-public (add-course (id uint) (name (string-ascii 64)) (credits uint))
  (ok (map-set courses id {name: name, credits: credits})))

(define-public (complete-course (course-id uint) (grade (string-ascii 2)))
  (ok (map-set completions {student: tx-sender, course-id: course-id} {completed: true, grade: grade})))

(define-read-only (get-course (id uint))
  (match (map-get? courses id)
    course (ok course)
    ERR-NOT-FOUND))

(define-read-only (get-completion (student principal) (course-id uint))
  (match (map-get? completions {student: student, course-id: course-id})
    completion (ok completion)
    ERR-NOT-FOUND))
