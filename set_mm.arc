; L 3858
($c -> neg wff TT)

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
($a wn nil nil (wff (neg ph)))

; L 3979
($a wi nil nil (wff (-> ph ps)))

; L 4024
($a ax-1 nil nil (TT (-> ph (-> ps ph))))

; L 4032
($a ax-2 nil nil (TT (-> (-> ph (-> ps ch)) (-> (-> ph ps) (-> ph ch)))))

; L 4044
($a ax-3 nil nil (TT (-> (-> (neg ph) (neg ps)) (-> ps ph))))

; L 4065
($a mp (mp.1 (TT ph) mp.2 (TT (-> ph ps))) nil (TT ps))



; L 4546
($a syl6com
    (syl6com.1 (TT (-> ps (-> ph ch)))
     syl6com.2 (TT (-> ch (-> ph th))))
    nil
    (TT (-> ps (-> ph th))))

; L 5264
($c <->)
($a wb nil nil (wff (<-> ph ps)))
($a df-bi nil nil 
    (TT 
      (neg 
        (->
          (->
            (<-> ph ps)
            (neg (-> (-> ph ps) (neg (ps -> ph)))))
          (neg
            (->
              (-> (-> ph ps) (neg (ps -> ph)))
              (<-> ph ps)))))))

; ph ps (-> ph ps) (neg (-> ps ph)) (-> (-> ph ps) (neg (-> ps ph))) (<-> ph ps)
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


($a ornil nil nil (TT (neg (\\/))))
; L 5972
($a df-or nil nil (TT (<-> (\\/ ph . l) (-> (neg ph) (\\/ l)))))

($a andnil nil nil (TT (/\\)))
; L 5975
($a df-an nil nil (TT (<-> (/\\ ph . l) (neg (-> ph (neg (/\\ l)))))))


; L 12214
($c AA)
($c set)
($v x y z w v u)
($f vx set x)
($f vy set y)
($f vz set z)
($f vw set w)
($f vv set v)
($f vu set u)

; L 12245
($a wal nil nil (wff (AA x ph)))

; L 12248
($c =)

; L 12251
($c class)

; L 12273
;($a cv nil nil (class x))

; L 12321
($a weq nil nil (wff (= x y)))

; L 12326
($c ee)

; L 12392
($a wel nil nil (wff (ee x y)))

; L 12397
($a ax-5 nil nil (TT (-> (AA x (-> ph ps)) (-> (AA x ph) (AA x ps)))))

; L 12400
($a ax-6 nil nil (TT (-> (neg (AA x ph)) (AA x (neg (AA x ph))))))

; L 12408
($a ax-7 nil nil (TT (-> (AA x (AA y ph)) (AA y (AA x ph)))))

; L 12419
($a ax-gen (ax-g_1 (TT ph)) nil (TT (AA x ph)))

; L 12435
($a ax-8 nil nil (TT (-> (= x y) (-> (= x z) (= y z)))))

; L 12450
($a ax-9 nil nil (TT (neg (AA x (neg (= x y))))))

; L 12460
($a ax-10 nil nil (TT (-> (AA x (= x y)) (AA y (= y x)))))

; L 12489
($a ax-11 nil nil (TT (-> (= x y) (-> (AA y ph) (AA x (-> (= x y) ph))))))

; L 12405
($a ax-12 nil nil (TT (-> (neg (AA z (= z x)))
                          (-> (neg (AA z (= z y)))
                              (-> (= x y) (AA z (= x y)))))))

; L 12519
($a ax-13 nil nil (TT (-> (= x y) (-> (ee x z) (ee y z)))))

; L 12527
($a ax-14 nil nil (TT (-> (= x y) (-> (ee z x) (ee z y)))))

; L 12583
($a ax-17 nil ((x ph)) (-> ph (AA x ph)))

; L 12656
($a ax-4 nil nil (TT (-> (AA x ph) ph)))

; L 12738
($c EE)

;L 12742
($a wex nil nil (wff (EE x ph)))

; L 12747
($a df-ex nil nil (TT (<-> (EE x ph) (neg (AA x (neg ph))))))

; L 14228
($a a4im (a4im_1 (TT (-> ps (AA x ps)))
          a4im_2 (TT (-> (= x y) (-> ph ps))))
    nil
    (TT (-> (AA x ph) ps)))

; L 14383
($c /)

; L 14427
($a wsb nil nil (wff (/ y x ph)))

; L 14465
($a df-sb nil nil (TT (<-> (/ y x ph)
                   (/\\ (-> (= x y) ph) (EE x (/\\ (= x y) ph))))))

($p a4imv 
    (a4imv_1 (TT (-> (= x y) (-> ph ps))))
    ((x ps))
    (TT (-> (AA x ph) ps))
    (wph wps vx vy wps vx ax-17 a4imv_1 a4im))

;; 1 wph            $f wff ph
;; 2 wps            $f wff ps
;; 3 vx             $f set x
;; 4 vy             $f set y
;; 5 2,3 ax-17      $a |- ( ps -> A. x ps )
;; 6 a4imv.1        $e |- ( x = y -> ( ph -> ps ) )
;; 7 1,2,3,4,5,6 a4im  $p |- ( A. x ph -> ps )


; L 16485
($a ax-15 nil nil (TT (-> (neg (AA z (= z x)))
                          (-> (neg (AA z (= z y)))
                              (-> (ee x y) (AA z (ee x y)))))))