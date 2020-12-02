;; Given a stream of elements too large to store in memory, pick a
;; random element from the stream with uniform probability.

(defclass iterator () ())

(defgeneric next (iterator)
  (:documentation "get the next element from the iterator"))

(defclass list-iterator (iterator)
  ((list :initarg :list)))

(defun make-list-iterator (list)
  (make-instance 'list-iterator :list list))

(defmethod next ((iterator list-iterator))
  (pop (slot-value iterator 'list)))

(defclass stream-iterator (iterator)
  ((stream :initarg :stream)))

(defun make-stream-iterator (stream)
  (make-instance 'stream-iterator :stream stream))

(defmethod next ((iterator stream-iterator))
  (read (slot-value iterator 'stream) nil nil))

(defmethod random-element ((iterator iterator))
  (loop with random-element = nil
        for i from 0
        for element = (next iterator)
        when (null element)
          return random-element
        when (zerop (random (1+ i)))
          do (setf random-element element)))

(dotimes (i 5)
  (let ((iterator (make-list-iterator (list 1 2 3 4 5))))
    (print (random-element iterator))))
(dotimes (i 5)
  (let ((iterator (make-stream-iterator (make-string-input-stream "1 2 3 4 5"))))
    (print (random-element iterator))))
