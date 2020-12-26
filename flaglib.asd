;;;; flaglib.asd

(asdf:defsystem #:flaglib
  :description "Describe flaglib here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:reacl #:ps-lib-tool #:alexandria #:ps-gadgets 
               #:warflagger-core #:gadgets)
  :components ((:file "package")
               (:file "flaglib")))
