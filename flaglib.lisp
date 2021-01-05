;;;; flaglib.lisp

(in-package #:flaglib)

(def-ps-package flaglib
  :ps-requirements '(#:reacl #:ps-gadgets #:ps-react-gadgets)
  :js-requirements '(;; "polyfill" ;; who needs?
                     ;; "lodash"
                     ;; "jquery"
                     ;; "rangy/lib/rangy" ;; Need this?
                     "rangy/lib/rangy-textrange"
                     "react-portal-tooltip"
                     "react-tabs"
                     "react-on-screen"
                     "react-helmet")
  :ps-files '("displayables.parenscript"
              "grouped.parenscript"
              "misc.parenscript"
              "mood.parenscript"
              "opinion-page.parenscript"
              "target-article.parenscript"
              "target.parenscript"
              "target-summary.parenscript"
              "target-thread.parenscript"
              "things.parenscript"
              "titlebar.parenscript"))

#|

def-ps-package should probably have a field for resources such as css

  :@css-link "/static/css/target.css"
  ;;FIXME: Need better way to include:
  :@css-link "/static/css/react-tabs.css"

|#

;; For target styling
(defparameter *intensity-thresholds*
  '((0 . 2) (5 . 4) (20 . 6) (50 . 8) (100 . 16)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Status indicator for targets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *indicator-names* (list :x-supported "thumbs_up_sign"
                                      :x-dissed "thumbs_down_sign"
                                      :x-right "check_mark"
                                      :x-wrong "ballot_x"
                                      :x-problematic "heavy_exclamation_mark_symbol"
                                      :x-unverified "black_question_mark_ornament"))

(defparameter *warstat-text*
  (list :x-supported "Has approval"
        :x-dissed "Has disapproval"
        :x-right "Has supporting evidence"
        :x-wrong "Has contradicting evidence"
        :x-problematic "Has conflict"
        :x-unverified "Has unresolved questions"))

;;FIXME: Removing draw-indicator and display-warstats because they render server side. But they
;; refer to *indicator-names* and *warstat-text* above. Decide how duplicates should be removed.
