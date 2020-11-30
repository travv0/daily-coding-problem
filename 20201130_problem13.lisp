;; Given an integer k and a string s, find the length of the longest
;; substring that contains at most k distinct characters.

;; For example, given s = "abcba" and k = 2, the longest substring
;; with k distinct characters is "bcb".

(defun longest-substring-of-chars (s k)
  (loop with longest-substring = ""
        for chars = '()
        and start below (length s)
        do (loop for end from start to (length s)
                 and substring = (subseq s start end)
                 if (<= (length (remove-duplicates substring)) k)
                   when (> (length substring) (length longest-substring))
                     do (setf longest-substring substring)
                 end
                 else return nil)
        finally (return longest-substring)))

(assert (string= (longest-substring-of-chars "abcba" 2) "bcb"))
