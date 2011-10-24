(= c* nil)
(= v* nil)
(= f* (table))
(= p* (table))

(mac $c cts
  `(++ c* ',cts))

(mac $v vars
  `(++ v* ',vars))

(mac $f (name ct var)
  `(do
     (= ,name (table))
     (= (,name 'statement) '(,ct ,var))
     (= (,name 'step)
        (fn (stack)
          (cons '(,ct ,var) stack)))
     (= (f* ',var) ,name)))

(def vars (x)
  (dedup (keep [find _ v*] (flat x))))

(def getfs (ccl)
  (map [(f* _) 'statement] (vars ccl)))




(mac w/cs body
  `(withs ,(mappend
             (fn (c)
               `(,c ',c))
             c*)
     ,@body))

(mac check-cs ()
  `(do
     ,@(map
        (fn (c) `(when (no (is ,c ',c)) (err "checks: mismatch " ,c ',c)))
        c*)))


;must be a macro, because it uses push
(mac pushal (x al key)
  `(aif (assoc ,key , al)
         (push ,x (cdr it))
         (push (list ,key ,x) ,al)))

; doesn't work : the push keeps local to the function
;; (def pushal (x al key)
;;   (aif (assoc key al)
;;        (push x (cdr it))
;;        (push (list key x) al)))

(def gtree (tree)
  (withs (al nil
          base (fn (atom)
                 (when atom
                   (w/uniq g
                     (pushal g al atom)
                     g)))
          restree (treewise cons base tree))
    (list al restree)))

;iso with n args
(def ison xs
  (or (apply is xs)
      (and (all acons xs)
           (apply ison (map car xs))
           (apply ison (map cdr xs)))))

(mac mlet (var val . body)
  (let (al gvar) (gtree var)
    `(let ,gvar ,val
       ,@(map
           (fn (x) 
             `(when 
                  (no (ison ,@(cdr x)))
                (err ,(+ "mlet: different values for " (car x) ": ")
                     (list ,@(cdr x)))))
           al)
       (withs ,(mappend
                 [list (car _) (cadr _)]
                 al)
         ,@body))))

;; (mlet ((wff P)
;;        (wff Q)
;;        (wff (-> P Q))
;;        (TT P)
;;        (TT (-> P Q))
;;        . rest)
;;       '((wff (= u (+ u 0))) 
;;         (wff (= u u)) 
;;         (wff (-> (= u (+ u 0)) (= u u)))
;;         (TT (= u (+ u 0)))
;;         (TT (-> (= u (+ u 0)) (= u u)))) 
;;       (pr P Q))

(def mbind (l)
  (if (no l) nil
      (atom l) l
      `(cons ,(mbind (car l)) ,(mbind (cdr l)))))

(def check-d-vars (ds)
  (each d ds
    (each dv d
      (when (no (find dv v*)) 
        (err "MM $a symbol in ds is not var " dv)))))

(def tense-1n (x l)
  (map [list x _] l))

(def tense-nn (l1 l2)
  (mappend [tense-1n _ l2] l1))

(def all2sets (l)
  (if (no l) nil
      (no (cdr l)) nil
      (+ (tense-1n (car l) (cdr l)) (all2sets (cdr l)))))

(mac check-ds (ds)
  `(do
     ,@(map
        (fn (d)
          `(do
             ,@(map
                (fn (d2)
                  (withs (a (car d2)
                            b (cadr d2))
                    `(withs (varsa (vars ,a)
                             varsb (vars ,b))
                       (awhen (some [find _ varsa] varsb)
                         (err "MM check-ds common var" it ',a ',b))
                       (each vab (tense-nn varsa varsb)
                         (withs (va (car vab)
                                 vb (cadr vab))
                           (unless (some [find vb _] (keep [find va _] 
                                                           ',ds))
                             (err "MM check-ds no d for " 
                                  va vb 'in ',a ',b)))))))
                (all2sets d))))
        ds)))

(mac $a (name es ds ccl)
  (w/uniq rest
    (let hyps (+ (getfs (list es ccl)) es)
      (check-d-vars ds)
      `(do
         (= ,name (table))
         (= (,name 'step)
            (fn (stack)
              ,(if hyps
                  `(w/cs
                     (mlet (,@(rev hyps) . ,rest) stack
                        (check-cs)
                        (check-ds ,ds)
                        (cons ,(mbind ccl) ,rest)))
                  `(cons ',ccl stack))))))))

(mac $p (name es ds ccl proof)
  `(do
     ($a ,name ,es ,ds ,ccl)
     (= (,name 'verify)
        (fn ()
          (let stack nil
            ,@(map 
               (fn (s)
                 `(= stack ((,s 'step) stack)))
               proof)
            (if (no (iso stack '(,ccl)))
                (err "MM verify: " ',name stack)))))
     (= (p* ,name) ,name)))

(def verify-all ()
  (each p p* (p 'verify)))