{- N Queens Problem.
 
(c) E. Adrian Garro S. Costa Rica Institute of Technology. -}

module NQueens
( solve
, createChessboard
) where

import Data.Maybe (fromJust)
import Data.List (delete, intercalate)
import Data.Set as Set (fromList, toList)
import qualified Data.Map as Map (fromList, lookup)

-- Finds all permutations on a given list without repeated elements.
permutations :: (Eq e) => [e] -> [[e]]
permutations [] = [[]]
permutations xs = [x : ys | x <- xs, ys <- permutations $ delete x xs]

-- Check if a list of queens in a chessboard attack each other.
attack :: [Int] -> Bool
attack []  = False
attack (queenCol:[])  = False       
attack queensCols = thereAttack
    where thereAttack = inDiag45 || inDiag135
          inDiag135 = length diffOfPos > length diffOfPosNub
          inDiag45 = length sumOfPos > length sumOfPosNub
          diffOfPosNub = setNub diffOfPos
          sumOfPosNub = setNub sumOfPos
          setNub xs = Set.toList $ Set.fromList xs
          diffOfPos = [fst pos - snd pos | pos <- queensPos]
          sumOfPos = [fst pos + snd pos | pos <- queensPos]
          queensPos = zip queensRows queensCols
          queensRows = [0..(length $ queensCols)-1]
 
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
                            
duplicate :: String -> Int -> String
duplicate string n = concat $ replicate n string

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
