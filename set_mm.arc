

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
($a ax-14 nil nil (TT (-> (= x y) (-> (ee z x) (ee z y)))))

($a ax-17 nil ((x ph)) (-> ph (AA x ph)))

; L 16485
($a ax-15 nil nil (TT (-> (not (AA z (= z x)))
                          (-> (not (AA z (= z y)))
                              (-> (ee x y) (AA z (ee x y)))))))