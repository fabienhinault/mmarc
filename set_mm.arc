; L 3858
($c -> not wff TT)

; L 3870
($v ph) ; Greek phi
($v ps); Greek psi 
($v ch); Greek chi 
($v th); Greek theta 
($v ta); Greek tau 
($v et); Greek eta 
($v ze); Greek zeta 
($v si); Greek sigma 
($v rh); Greek rho 

; L 3880
($f wph wff ph)
; Let variable ` ps ` be a wff. 
($f wps  wff ps )
; Let variable ` ch ` be a wff. 
($f wch  wff ch )
; Let variable ` th ` be a wff. 
($f wth  wff th )
; Let variable ` ta ` be a wff. 
($f wta  wff ta )
; Let variable ` et ` be a wff. 
($f wet  wff et )
; Let variable ` ze ` be a wff. 
($f wze  wff ze )
; Let variable ` si ` be a wff. 
($f wsi  wff si )
; Let variable ` rh ` be a wff. 
($f wrh  wff rh )

; L 3969
($a wn nil nil (wff (not ph)))

; L 3979
($a wi nil nil (wff (-> ph ps)))

; L 4024
($a ax-1 nil nil (TT (-> ph (-> ps ph))))

; L 4032
($a ax-2 nil nil (TT (-> (-> ph (-> ps ch)) (-> (-> ph ps) (-> ph ch)))))

; L 4044
($a ax-3 nil nil (TT (-> (-> (not ph) (not ps)) (-> ps ph))))

; L 4065
($a mp ((TT ph) (TT (-> ph ps))) nil (TT ps))

; L 5264
($c <->)
($a wb nil nil (wff (<-> ph ps)))
($a df-bi nil nil 
    (TT 
      (not 
        (->
          (->
            (<-> ph ps)
            (not (-> (-> ph ps) (not (ps -> ph)))))
          (not
            (->
              (-> (-> ph ps) (not (ps -> ph)))
              (<-> ph ps)))))))

; ph ps (-> ph ps) (not (-> ps ph)) (-> (-> ph ps) (not (-> ps ph))) (<-> ph ps)
; T  T  T          F                F                                T
; T  F  F          F                T                                F
; F  T  T          T                T                                F
; F  F  T          F                F                                T

; L 5955
($c \\/ /\\)

; special mmarc
($c lwff)
($v l)
($f lwl lwff l)
($a lwph nil nil (lwff (ph . l)))
($a lwnil nil nil (lwff nil))

; L 5959
($a wo nil nil (wff (\\/ . l)))
($a wa nil nil (wff (/\\ . l)))


($a ornil nil nil (TT (not (\\/)))
; L 5972
($a df-or nil nil (TT (<-> (\\/ ph . l) (-> (not ph) (\\/ l)))))

($a andnil nil nil (TT (/\\)))
; L 5975
($a df-an nil nil (TT (<-> (/\\ ph . l) (not (-> ph (not (/\\ l)))))))


; L 12214
($c AA)
($c set)
($v x y z w v u)
($f set x)
($f set y)
($f set z)
($f set w)
($f set v)
($f set u)
($a wal nil nil (wff (AA x ph)))
($c =)
($c class)
($a cv nil nil (class x))
($a 

($a ax-5 nil nil (TT (-> (AA x (-> ph ps)) (-> (AA x ph) (AA x ps)))))
($a ax-6 nil nil (TT (-> (not (AA x ph)) (AAx (not (AA x ph)))))
($a ax-7 nil nil (TT (-> (AA x (AA y ph)) (AA y (AA x ph)))))
;ax-gen
($a ax-8 nil nil (TT (-> (= x y) (-> (= x z) (= y z)))))
($a ax-9 nil nil (TT (not (AA x (not (= x y))))))
($a ax-10 nil nil (TT (-> (AA x (= x y)) (AA y (= y x)))))
($a ax-11 nil nil (TT (-> (= x y) (-> (AA y ph) (AA x (-> (= x y) ph))))))
($a ax-12 nil nil (TT (-> (not (AA z (= z x)))
                          (-> (not (AA z (= z y)))
                              (-> (= x y) (AA z (= x y)))))))
($a ax-13 nil nil (TT (-> (= x y) (-> (ee x z) (ee y z)))))
; L 12527
($a ax-14 nil nil (TT (-> (= x y) (-> (ee z x) (ee z y)))))

; L 12583
($a ax-17 nil ((x ph)) (-> ph (AA x ph)))

; L 16485
($a ax-15 nil nil (TT (-> (not (AA z (= z x)))
                          (-> (not (AA z (= z y)))
                              (-> (ee x y) (AA z (ee x y)))))))