;; Given the mapping a = 1, b = 2, ... z = 26, and an encoded message,
;; count the number of ways it can be decoded.

;; For example, the message '111' would give 3, since it could be
;; decoded as 'aaa', 'ka', and 'ak'.

;; You can assume that the messages are decodable. For example, '001'
;; is not allowed.

(defun decodable-p (str)
  (<= 1 (parse-integer str) 26))

(defun count-decodings (str)
  (flet ((process (n)
           (cond ((< (length str) n) 0)
                 ((= (length str) n) (if (decodable-p str) 1 0))
                 (t (let ((head (subseq str 0 n))
                          (tail (subseq str n)))
                      (if (decodable-p head)
                          (count-decodings tail)
                          0))))))
    (+ (process 1) (process 2))))

(assert (= (count-decodings "111") 3))
(assert (= (count-decodings "226") 3))
(assert (= (count-decodings "622") 2))
