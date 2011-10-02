(= c* nil)
(= v* nil)
(= f* (table))

(mac $c cts
  `(++ c* ',cts))

(mac $v vars
  `(++ v* ',vars))

(mac $f (name ct var)
  `(do
     (= ,name (table))
     (= (,name 'statement) '(,ct ,var))
     (= (,name 'verify)
        (fn (stack)
          (push stack '(,ct ,var))))
     (= (f* ',var) ,name)))

(def vars (statement)
  (dedup (keep [find _ v*] (flat statement))))

;; (def vars (statement)
;;   (dedup (treewise + [aif (find _ v*) (list it) nil] statement)))

(def getfs (ccl)
  (map [f* _] (vars ccl)))

(mac $a (name hyps ccl)
  (w/uniq ghyps
    `(let ,ghyps ,(+(getfs ccl) hyps)
       (do
         (= ,name (table))
         (= (,name 'verify)
            (fn (stack)
              (let (,(bind ghyp) . r) stack
                (= stack r)
                (push ,(bind ccl) stack))))))))


;; (mac $a (name es ccl)
;;   (let fs (map [(f* _) 'statement] (vars ccl))
;;     `(do
;;        (= ,name (table))
;;        (= (,name 'verify)
;;           (fn (stack)
;;             (let (,fs . r) stack
;;                  (let (,es . r) r
;;                       (= stack (cons ,ccl r)))))))))

;    $c 0 + = -> ( ) term wff |- $.
($c 0 + = -> term wff T.)

;    $v t r s P Q $.
($v u r s P Q)

;    tt $f term t $.
($f tu term u)
($f tr term r)
($f ts term s)
;    wp $f wff P $.
($f wp wff P)
($f wq wff Q)
;    tze $a term 0 $.
($a tze nil (term 0))

;; (def sublis (al tree)
;;   (treewise cons [aif (assoc _ al) (cdr it) _] tree))

;; (def subst-base (atom)
;;   (when atom
;;     (

(mac pushal (x al key)
  `(aif (assoc ,key , al)
         (push ,x (cdr it))
         (push (list ,key ,x) ,al)))
; this worked with a hash table
;; (def gtree (tree)
;;   (withs (al nil
;;           base (fn (atom)
;;                  (when atom
;;                    (w/uniq g
;;                      (pushal g al atom)
;;                      g))))
;;     (list al (treewise cons base tree))))

(mac gtree (tree)
  `(withs (al nil
           base (fn (atom)
                 (when atom
                   (w/uniq g
                     (pushal g al atom)
                     g)))
           restree (treewise cons base ,tree))
     (list al restree)))

;(gtree '(TT (-> (= u (+ u 0)) (= u u))))


;; val  '((TT (= u (+ u 0)))
;;        (TT (-> (= u (+ u 0)) (= u u))))


(mac mlet (var val . body)
  (let (al gvar) (gtree var)
    `(let ,gvar ,val
       (each (k . vs) ,al
         (when (no (apply is vs))
           (err (+ "different values for " k))))
       (withs ,(each (k . vs) al
                    k
                    (car vs))
         ,@body))))
