{- User interaction with N Queens Problem.
 
(c) E. Adrian Garro S. Costa Rica Institute of Technology. -}

import NQueens

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
    putStr (unlines printableSolutions)
