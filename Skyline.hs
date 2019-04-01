module Skyline where

-- Cabecera del programa Skyline.hs
-- Práctica de Teoría de los Lenguajes de Programación
-- Curso 2015-2016

type Edificio = (Int,Int,Int)
type Coordenada = (Int,Int)
type Skyline = [Coordenada] -- Lista de coordenadas

resuelveSkyline::[Edificio] -> Skyline
resuelveSkyline [] = []
resuelveSkyline [x] = edificioAskyline x
resuelveSkyline xs = combina (resuelveSkyline(fst(divide(xs)))) (resuelveSkyline(snd(divide(xs))))


edificioAskyline::Edificio->Skyline
edificioAskyline (x1, x2, h) = [(x1, h), (x2, 0)] 



divide::[Edificio]-> ([Edificio], [Edificio])
divide lista = splitAt n lista
    where n = (((length lista)) `div` 2)


 
combina::Skyline -> Skyline -> Skyline
combina xs ys = combinaSub (xs,0)(ys, 0) 0
    where
    combinaSub ([], _) ([], _) ultH = [] -- no quedan coord en ninguna
    combinaSub (xs,_) ([], _) ultH = xs --solo quedan coord en la primera, añado la primera
    combinaSub ([], _) (ys, _) ultH = ys -- solo quedan coord en la segunda, añado la segunda
    combinaSub ((x, hx):xs, ult_hx) ((y, hy):ys, ult_hy) ultH
        | x == y && ((max hx hy) == ultH) = combinaSub (xs, hx) (ys, hy) ultH 
        | x == y && ((max hx hy) /= ultH) = (max x y, (max hx hy)) :combinaSub (xs, hx) (ys, hy)  (max hx hy) 
        | x > y && ((max ult_hx hy) == ultH) = combinaSub ((x,hx):xs, ult_hx) (ys, hy) ultH 
        | x > y && ((max ult_hx hy) /= ultH) = (y, max ult_hx hy):combinaSub ((x, hx):xs, ult_hx) (ys, hy) (max ult_hx hy) 
        | x < y && ((max hx ult_hy) == ultH) = combinaSub (xs, hx) ((y, hy):ys, ult_hy) ultH 
        | x < y && ((max hx ult_hy) /= ultH) = (x, max hx ult_hy):combinaSub (xs, hx) ((y, hy):ys, ult_hy) (max hx ult_hy) 
        | otherwise = [(0,0)]