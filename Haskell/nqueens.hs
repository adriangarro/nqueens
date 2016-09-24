{- N Queens Problem.
 
(c) E. Adrian Garro S. Costa Rica Institute of Technology. -}

-- Find all combinations of two in a given list without repeated elements.
combsOfTwo :: (Ord e) => [e] -> [(e, e)]
combsOfTwo [] = []
combsOfTwo xs = [(x, y) | x <- xs, y <- xs, y > x]

-- Find all permutations on a given list without repeated elements.
permutations' :: (Eq e) => [e] -> [[e]]
permutations' [] = [[]]
permutations' xs = [x : ys | x <- xs, ys <- permutations' $ delete x xs]

main = do
    putStrLn "N Queens!"