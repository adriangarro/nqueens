# N Queens Problem. -#

# (c) E. Adrian Garro S. Costa Rica Institute of Technology. -#

include("combinatorial.jl")

function areInDiag45(queen1Row::Int, queen1Col::Int, queen2Row::Int, queen2Col::Int)
    queen1Row - queen1Col == queen2Row - queen2Col
end

function areInDiag135(queen1Row::Int, queen1Col::Int, queen2Row::Int, queen2Col::Int)
    queen1Row + queen1Col == queen2Row + queen2Col
end

function areInDiag(queen1Row::Int, queen1Col::Int, queen2Row::Int, queen2Col::Int)
    resultDiag45 = areInDiag45(
        queen1Row, queen1Col, queen2Row, queen2Col
    )
    resultDiag135 = areInDiag135(
        queen1Row, queen1Col, queen2Row, queen2Col
    )
    resultDiag = resultDiag45 || resultDiag135
end

function attack(queensCols::Array{Int})
    queensPos = Dict(enumerate(queensCols))
    invQueenPos = Dict((col, row) for (row, col) in queensPos)
    pairsQueenCols = combinationsOf2(queensCols)
    thereAttack = false
    for (queen1Col, queen2Col) in pairsQueenCols
        queen1Row = invQueenPos[queen1Col]
        queen2Row = invQueenPos[queen2Col]
        if areInDiag(queen1Row, queen1Col, queen2Row, queen2Col)
            thereAttack = true
            break
        end
    end
    return thereAttack
end

function notAttack(queensCols)
    !attack(queensCols)
end
    
function solve(queensQuant::Int)
    solutions = @task permutations(
        collect(1:queensQuant)
    )
    solutions = collect(solutions)
    filter!(notAttack, solutions)
end

function createBox(queensQuant, queenPos)
    queenPos -= 1
    string(
        "\n|", 
        "   |" ^ queenPos, 
        " X |", 
        "   |" ^ (queensQuant - (queenPos + 1))
    )
end

function printSolution(queensQuant, solution)
    boxes = [createBox(queensQuant, queens_cols) for queens_cols in solution]
    chain = string("\n+", "---+"  ^ queensQuant)
    chessboard = string(string(chain, join(boxes, chain)), chain)
    # print('\nSolution #' + str(solution_num) + '\n')
    print(chessboard)
end

solutions = solve(4)
printSolution(4, solutions[2])
