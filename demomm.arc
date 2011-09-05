(= c* nil)
(= v* nil)


(mac $c cts
  (++ c* ',cts))

(mac $v vars
  (++ v* ',vars))

(mac $f (name ct var)
  `(do
     (= ,name (table))
     (= (,name 'statement) '(,ct ,var))
     (= (,name 'verify)
        (fn (stack)
          (push stack '(,ct ,var))))))

(def vars (statement)
  (dedup (keep [find _ v*] statement)))

