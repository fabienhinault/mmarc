(= c* nil)
(= v* nil)
(= f* (table))

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
          (push stack '(,ct ,var))))
     (= (f* ,var) ,name)))

(def vars (statement)
  (dedup (keep [find _ v*] (flat statement))))

(mac $a (name es ccl)
  (let fs (map [(f* _) 'statement] (vars ccl))
    `(do
       (= ,name (table))
       (= (,name 'verify)
          (fn (stack)
            (let (,fs . r) stack
                 (let (,es . r) r
                      (= stack (cons ,ccl r)))))))))