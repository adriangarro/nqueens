{- N Queens Problem.
 
(c) E. Adrian Garro S. Costa Rica Institute of Technology. -}

import Data.Maybe (fromJust)
import Data.List (delete, intercalate)
import qualified Data.Map as Map (fromList, lookup)

duplicate :: String -> Int -> String
duplicate string n = concat $ replicate n string

-- Finds all combinations of two in a given list 
-- without repeated elements in increasing order.
combsOfTwo :: (Ord e) => [e] -> [(e, e)]
combsOfTwo [] = []
combsOfTwo xs = [(x, y) | x <- xs, y <- xs, y > x]

-- Finds all permutations on a given list without repeated elements.
permutations :: (Eq e) => [e] -> [[e]]
permutations [] = [[]]
permutations xs = [x : ys | x <- xs, ys <- permutations $ delete x xs]

-- Checks if a pair of queens are in the same diagonal.
inDiag :: (Int, Int) -> (Int, Int) -> Bool
inDiag (queen1Row, queen2Row) (queen1Col, queen2Col) = inDiag45 || inDiag135
    where inDiag45 = queen1Row - queen1Col == queen2Row - queen2Col
          inDiag135 = queen1Row + queen1Col == queen2Row + queen2Col

-- Check if a list of queens in a chessboard attack each other.
attack :: [Int] -> Bool
attack []  = False
attack (queenCol:[])  = False       
attack queensCols = thereAttack
    where thereAttack = elem True possibleAttacks
          possibleAttacks = zipWith inDiag pairsOfRows pairsOfCols
          pairsOfRows = map toRows pairsOfCols
          pairsOfCols = combsOfTwo queensCols 
          toRows (col1, col2) = (rowOf col1, rowOf col2)
          rowOf col = fromJust $ Map.lookup col queensPosMap
          queensPosMap = Map.fromList queensPos
          queensPos = zip queensCols queensRows
          queensRows = [0..length(queensCols)-1]
 
-- Checks if a list of queens in a chessboard not attack each other. 
notAttack :: [Int] -> Bool      
notAttack queensCols = not $ attack queensCols

-- Solves the N Queens Problem for a given quantity of queens.
solve :: Int -> [[Int]]
solve queensQuant
    | queensQuant < 4 = [[]]
    | otherwise = solutions
        where solutions = filter notAttack allPossibleQueensCols
              allPossibleQueensCols = permutations [0..queensQuant-1]

createBox:: Int -> Int -> String
createBox queensQuant queenPos = box
    where box = "\n|" ++ startPipes ++ mark ++ endPipes
          startPipes = duplicate "   |" queenPos
          mark = " X |"
          endPipes = duplicate "   |" endPipesNum
          endPipesNum = queensQuant -  (queenPos + 1)
        
createChessboard:: [Int] -> String
createChessboard solution = chessboard
    where chessboard = chain ++ incompleteBoard ++ chain
          incompleteBoard = intercalate chain boxes
          chain = "\n+" ++ duplicate "---+" queensQuant
          boxes = map createBox' solution
          createBox' = createBox queensQuant
          queensQuant = length solution

-- Gets user's input as integer.            
getInt message = do
    putStr message
    number <- getLine
    return (read number::Int)

main = do
    putStrLn "N Queens Problem"
    queensQuant <- getInt "Enter the number of queens: "
    let solutions = solve queensQuant
    putStr "The number of solutions are: "
    print (length solutions)
    putStrLn "Solutions: "
    let printableSolutions = map createChessboard solutions
    putStr ( unlines printableSolutions )
    