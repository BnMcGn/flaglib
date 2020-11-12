;;;; flaglib.lisp

(in-package #:flaglib)



;;FIXME: react, react-dom should be loaded from the npm bundle.
(define-default-parts warflagger-base
  :@javascript-link "https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/6.26.0/polyfill.js"
  ;;:@javascript-link "https://unpkg.com/react@16.12.0/umd/react.development.js"
  ;;:@javascript-link "https://unpkg.com/react-dom@16.12.0/umd/react-dom.development.js"
  :@javascript-link "/static/javascript/warflagger-bundle.js"
  :@javascript (ps:ps
                 (setf -react (require "react"))
                 (setf (ps:@ -react #:create-class) (require "create-react-class"))
                 (setf (ps:@ -react -d-o-m) (require "react-dom-factories"))
                 (setf -redux (require "redux"))
                 (setf -react-redux (require "react-redux")))
  ;;:@javascript-link
  ;;"https://cdnjs.cloudflare.com/ajax/libs/redux/4.0.0/redux.js"
  ;;:@javascript-link
  ;;"https://cdnjs.cloudflare.com/ajax/libs/react-redux/5.0.7/react-redux.js"

  :@account-info #'account-bar
  :@javascript-link "/static/javascript/jquery/1.9.1/jquery.js"
  :@javascript-link  "https://cdn.jsdelivr.net/npm/lodash@4/lodash.min.js"
  ;;FIXME: Should be able to bundle these with browserify. Can't.
  :@javascript-link "/static/node_modules/rangy/lib/rangy-core.js"
  :@javascript-link "/static/node_modules/rangy/lib/rangy-textrange.js"
  :@javascript-link *warflagger-js-resources*
  :@head #'favicon-links
  :@site-index)


(define-parts target-parts
  :@css-link "/static/css/target.css"
  ;;FIXME: Need better way to include:
  :@css-link "/static/css/react-tabs.css")


(defparameter *intensity-thresholds*
  '((0 . 2) (5 . 4) (20 . 6) (50 . 8) (100 . 16)))



;;Where is this stuff being used?:

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


(defun draw-indicator (category direction text)
  (html-out
    (:span :style (format nil "background-color: ~a; margin-left: 1px; margin-right: 1px;"
                          (getf *direction-colors* direction))
           (:img :src (format nil "/static/img/~a.svg"
                              (getf *indicator-names* category))
                 :title text
                 :style "height: .75em; :background-color: black;"))))

(defun display-warstats (wstats)
  (when (<= 1 (car (getf wstats :x-supported)))
    (draw-indicator :x-supported :positive (getf *warstat-text* :x-supported)))
  (when (<= 1 (car (getf wstats :x-dissed)))
    (draw-indicator :x-dissed :negative (getf *warstat-text* :x-dissed)))
  (when (<= 1 (car (getf wstats :x-right)))
    (draw-indicator :x-right :positive (getf *warstat-text* :x-right)))
  (when (<= 1 (car (getf wstats :x-wrong)))
    (draw-indicator :x-wrong :negative (getf *warstat-text* :x-wrong)))
  (when (or (<= 1 (car (getf wstats :x-problematic)))
            (<= 1 (second (getf wstats :x-supported)))
            (<= 1 (second (getf wstats :x-dissed)))
            (<= 1 (second (getf wstats :x-right)))
            (<= 1 (second (getf wstats :x-wrong)))
            (<= 1 (second (getf wstats :x-unverified))))
    (draw-indicator :x-problematic :contested (getf *warstat-text* :x-problematic)))
  (when (<= 1 (car (getf wstats :x-unverified)))
    (draw-indicator :x-unverified :contested (getf *warstat-text* :x-unverified))))
