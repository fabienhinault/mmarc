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

(def vars (statement)
  (dedup (keep [find _ v*] (flat statement))))

(def getfs (ccl)
  (map [(f* _) 'statement] (vars ccl)))

;    $c 0 + = -> ( ) term wff |- $.
($c + = -> term wff TT)

(mac w/cs body
  `(withs ,(mappend
             (fn (c)
               `(,c ',c))
             c*)
     ,@body))

(mac checkcs ()
  `(do
     ,@(map
        (fn (c) `(when (no (is ,c ',c)) (err "checks: mismatch " ,c ',c)))
        c*)))

;    $v t r s P Q $.
($v u r s P Q)

;    tt $f term t $.
($f tu term u)
($f tr term r)
($f ts term s)
;    wp $f wff P $.
($f wp wff P)
($f wq wff Q)


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

(mac $a (name es ccl)
  (w/uniq rest
    (let hyps (+ (getfs (list es ccl)) es)
      `(do
         (= ,name (table))
         (= (,name 'step)
            (fn (stack)
              ,(if hyps
                  `(w/cs
                     (mlet (,@(rev hyps) . ,rest) stack
                        (checkcs)
                        (cons ,(mbind ccl) ,rest)))
                  `(cons ',ccl stack))))))))

;    tze $a term 0 $.
($a tze nil (term 0))
($a tpl nil (term (+ u r)))
($a weq nil (wff (= u r)))
($a wim nil (wff (-> P Q)))
($a a1 nil (TT (-> (= u r) (-> (= u s) (= r s)))))
($a a2 nil (TT (= (+ u 0) u)))
($a mp ((TT P) (TT (-> P Q))) (TT Q))

(mac $p (name hyps ccl proof)
  `(do
     ($a ,name ,hyps ,ccl)
     (= (,name 'verify)
        (fn ()
          (let stack nil
            ,@(map 
               (fn (s)
                 `(= stack ((,s 'step) stack)))
               proof)
            (if (no (iso stack ',ccl))
                (err "MM verify: " ',name stack)))))
     (= (p* ,name) ,name)))

($p th1 nil (TT (= u u))
    (tu tze tpl tu weq tu tu weq tu a2 tu tze tpl
     tu weq tu tze tpl tu weq tu tu weq wim tu a2
     tu tze tpl tu tu a1 mp mp))





(def verify-all ()
  (each p p* (p 'verify)))