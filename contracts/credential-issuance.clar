;; Skill Assessment Contract

;; Data
(define-map skills uint {name: (string-ascii 64), description: (string-ascii 256)})
(define-map assessments {student: principal, skill-id: uint} {score: uint, assessed-on: uint})

;; Error codes
(define-constant ERR-NOT-FOUND (err u404))
(define-constant ERR-UNAUTHORIZED (err u403))

;; Functions
(define-public (add-skill (id uint) (name (string-ascii 64)) (description (string-ascii 256)))
  (ok (map-set skills id {name: name, description: description})))

(define-public (assess-skill (student principal) (skill-id uint) (score uint))
  (ok (map-set assessments {student: student, skill-id: skill-id} {score: score, assessed-on: block-height})))

(define-read-only (get-skill (id uint))
  (match (map-get? skills id)
    skill (ok skill)
    ERR-NOT-FOUND))

(define-read-only (get-assessment (student principal) (skill-id uint))
  (match (map-get? assessments {student: student, skill-id: skill-id})
    assessment (ok assessment)
    ERR-NOT-FOUND))

