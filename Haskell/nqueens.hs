{- N Queens Problem.
 
(c) E. Adrian Garro S. Costa Rica Institute of Technology. -}

import Data.List (delete)
import Data.Maybe (fromJust)
import qualified Data.Map as M (fromList, lookup)

-- Find all combinations of two in a given list 
-- without repeated elements in increasing order.
combsOfTwo :: (Ord e) => [e] -> [(e, e)]
combsOfTwo [] = []
combsOfTwo xs = [(x, y) | x <- xs, y <- xs, y > x]

-- Find all permutations on a given list without repeated elements.
permutations' :: (Eq e) => [e] -> [[e]]
permutations' [] = [[]]
permutations' xs = [x : ys | x <- xs, ys <- permutations' $ delete x xs]

-- Check if a pair of queens are in the same diagonal.
indiag :: (Integral i) => (i, i) -> (i, i) -> Bool
indiag (queen1Row, queen2Row) (queen1Col, queen2Col) = indiag45 || indiag135
    where indiag45 = queen1Row - queen1Col == queen2Row - queen2Col
          indiag135 = queen1Row + queen1Col == queen2Row + queen2Col

-- Check if a list of queens in a chessboard attack each other.
attack :: [Int] -> Bool
attack []  = False
attack (queenCol:[])  = False       
attack queensCols = thereAttack
    where thereAttack = elem True possibleAttacks
          possibleAttacks = zipWith indiag pairsOfRows pairsOfCols
          pairsOfRows = map toRows pairsOfCols
          pairsOfCols = combsOfTwo queensCols 
          toRows (col1, col2) = (rowOf col1, rowOf col2)
          rowOf col = fromJust $ M.lookup col invQueensPosMap
          invQueensPosMap = M.fromList invQueensPos
          invQueensPos = reverse queensPos
          queensPos = zip queensRows queensCols
          queensRows = [1..length(queensCols)]
 
-- Check if a list of queens in a chessboard not attack each other.       
notAttack queensCols = not $ attack queensCols


     