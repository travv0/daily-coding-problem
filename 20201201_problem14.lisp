;; The area of a circle is defined as πr^2. Estimate π to 3 decimal
;; places using a Monte Carlo method.

;; Hint: The basic equation of a circle is x^2 + y^2 = r^2.

(defun estimate-pi ()
  (loop with m = 0
        with estimate = 0
        for n from 1
        until (< (abs (- estimate pi)) 0.0001)
        if (< (+ (expt (- (random 1.0) 0.5) 2)
                 (expt (- (random 1.0) 0.5) 2))
              (expt 0.5 2))
          do (incf m)
             (setf estimate (float (/ (* 4 m) n)))
        finally (return estimate)))

(print (estimate-pi))
