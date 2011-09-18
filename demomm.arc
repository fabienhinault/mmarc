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
     (= (f* ,var) ,name)))

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
