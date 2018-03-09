-- Tipos
type Edificio = (Int,Int,Int)
type Coordenada = (Int,Int)
type Silueta = [Coordenada]

-------------------------------------------------
-- PARTE "OBLIGATORIA"
-------------------------------------------------

-- Esta función aplica un enfoque divide y vencerás al proceso de convertir las coordenadas de edificios en un skyline y luego une los resultados
resuelve :: [Edificio] -> Silueta
resuelve [] = []
resuelve [(x,y,z)] = siluetadeedificio (x,y,z)
resuelve horizonte = une (resuelve(fst(divide horizonte))) (resuelve(snd(divide horizonte)))

-- Esta función devuelve la silueta de un edificio dadas sus coordenadas
siluetadeedificio :: Edificio -> Silueta
siluetadeedificio (x,y,z) = [(x,z), (y,0)]

-- Esta función divide la lista de coordenadas pasada como argumento a la función 'resuelve'
divide :: [a] -> ([a], [a])
divide [] = ([], [])
divide [e] = ([e], [])
divide (x:y:z) = (x:xs, y:ys) where (xs, ys) = divide z

-- Esta función se usa para calcular la unión de las coordenadas de cada edificio
une :: Silueta -> Silueta -> Silueta
une [] [] = []
une xs [] = xs
une [] ys = ys
une xs ys = uneAux xs ys 0 0 0
    where
        uneAux ([]) (cd) _ _ _= cd
        uneAux (ab) ([]) _ _ _ = ab
        uneAux ((a,b):ab) ((c,d):cd) ux uy m 
            | (a == c) &&  (max b d == m)  =  uneAux (ab) (cd) b d m
            | (a == c) &&  (max b d /= m)  =  (a, max b d) : uneAux (ab) (cd) b d (max b d)
            | (a < c)  &&  (max b uy == m) =  uneAux (ab) ((c,d):cd) b uy m
            | (a < c)  &&  (max b uy /= m) =  (a, max b uy) : uneAux (ab) ((c,d):cd) b uy (max b uy)
            | (a > c)  &&  (max d ux == m) =  uneAux ((a,b):ab) (cd) ux d m
            | (a > c)  &&  (max d ux /= m) =  (c, max d ux) : uneAux ((a,b):ab) (cd) ux d (max d ux)
            | otherwise = [(0,0)]


-------------------------------------------------
-- PARTE OPTATIVA
-------------------------------------------------

-- Esta función dibuja el skyline de los edificios usando asteriscos, espacios y saltos de línea a partir de las alturas de los edificios
dibujar :: Silueta -> [Char]
dibujar h = dibujarAux (alturas h) (maximum (alturas h)) (alturas h)
    where
        dibujarAux lista y aux
            | (lista == []) && (y /= 0) = "\n" ++ dibujarAux aux (y-1) aux
            | (lista == []) && (y == 0) = ""
            | ((head lista)>=y) && (y /=0)= "*" ++ dibujarAux (tail lista) y aux
            | ((head lista)<y) && (y /=0) = " " ++ dibujarAux (tail lista) y aux
            | otherwise = "-" ++ dibujarAux (tail lista) y []

-- Esta función devuelve la altura de los edificios a partir de su silueta
alturas :: Silueta -> [Int]
alturas l = alturasAux l 0 0
    where 
        alturasAux [] _ _ = []
        alturasAux l i lx
            | i<(fst(head l)) = lx:alturasAux l (i+1) lx
            | i==(fst(head l)) = (snd(head l)):alturasAux (tail l) (i+1) (snd(head l))

---------------------------------------------------------------------------------------

-- Formatea el dibujo para que se vea correctamente
dibujar' :: Silueta -> IO ()
dibujar' h = putStr (dibujar h)

-- Dibuja directamente el skyline del conjunto de edificios que le pases
resuelve' :: [Edificio] -> IO ()
resuelve' horizonte = dibujar' (resuelve horizonte)