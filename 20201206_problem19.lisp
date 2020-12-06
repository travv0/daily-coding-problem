;; A builder is looking to build a row of N houses that can be of K
;; different colors. He has a goal of minimizing cost while ensuring
;; that no two neighboring houses are of the same color.

;; Given an N by K matrix where the nth row and kth column represents
;; the cost to build the nth house with kth color, return the minimum
;; cost which achieves this goal.

(defun find-cheapest-combo (matrix)
  (let ((house-count (array-dimension matrix 0))
        (color-count (array-dimension matrix 1)))
    (labels ((find-cheapest-combo* (house exclude-color)
               (multiple-value-bind (min-color min-price)
                   (loop with min-color = 0
                         with min-price = most-positive-fixnum
                         for i from 0
                         for price across (array-slice matrix house)
                         when (and (/= i exclude-color)
                                   (< price min-price))
                           do (setf min-color i min-price price)
                         finally (return (values min-color min-price)))
                 (if (< house (1- house-count))
                     (+ min-price (find-cheapest-combo* (1+ house) min-color))
                     min-price))))
      (loop for color below color-count
            minimizing (+ (aref matrix 0 color)
                          (find-cheapest-combo* 1 color))))))

(defun array-slice (arr row)
  (make-array (array-dimension arr 1)
              :displaced-to arr
              :displaced-index-offset (* row (array-dimension arr 1))))

(let ((matrix (make-array (list 5 5)
                          :initial-contents
                          (loop repeat 5 collect (loop repeat 5 collect (random 100))))))
  (format t "matrix: ~a~%minimum cost: ~a~%" matrix (find-cheapest-combo matrix)))
