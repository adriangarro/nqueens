# N Queens Problem.

# (c) E. Adrian Garro S. Costa Rica Institute of Technology.

include("combinatorial.jl")

type NQueens
    queens_quant::Int
    solutions::Array{Array{Int}}
    solutions_num::Int
end

function set_queens_quant!(problem::NQueens, queens_quant::Int)
    if queens_quant > 3
        problem.queens_quant = queens_quant
    else
        error("Invalid number for this problem.")
    end
end

function are_in_diag(queen1_row::Int, queen1_col::Int, queen2_row::Int, queen2_col::Int)
    result_diag45 = queen1_row - queen1_col == queen2_row - queen2_col
    result_diag135 = queen1_row + queen1_col == queen2_row + queen2_col
    result_diag = result_diag45 || result_diag135
end

function attack(queens_cols::Array{Int})
    queens_pos = enumerate(queens_cols)
    inv_queen_pos = Dict((col, row) for (row, col) in queens_pos)
    pairs_queen_cols = combinations_of_2(queens_cols)
    there_attack = false
    for (queen1_col, queen2_col) in pairs_queen_cols
        queen1_row = inv_queen_pos[queen1_col]
        queen2_row = inv_queen_pos[queen2_col]
        if are_in_diag(queen1_row, queen1_col, queen2_row, queen2_col)
            there_attack = true
            break
        end
    end
    return there_attack
end

function not_attack(queens_cols)
    !attack(queens_cols)
end
    
function solve!(problem::NQueens)
    if problem.queens_quant != 0
        all_possible_queens_cols = @task permutations(
            collect(1:problem.queens_quant)
        )
        problem.solutions = collect(all_possible_queens_cols)
        filter!(not_attack, problem.solutions)
        problem.solutions_num = length(problem.solutions)
    else
       error("Number of queens not available.") 
    end
end

function print_solution(problem::NQueens, solution_num::Int)
    if solution_num in collect(1:problem.solutions_num)
        solution = problem.solutions[solution_num]
        function create_box(queen_pos::Int)
            queen_pos -= 1
            string(
                "\n|", 
                "   |" ^ queen_pos, 
                " X |", 
                "   |" ^ (problem.queens_quant - (queen_pos + 1))
            )
        end
        boxes = [create_box(queens_cols) for queens_cols in solution]
        chain = string("\n+", "---+"  ^ problem.queens_quant)
        chessboard = string(string(chain, join(boxes, chain)), chain)
        print(string("\nSolution #", solution_num, "\n"))
        print(chessboard)
    else
        error("Solution not exist.")
    end
end
