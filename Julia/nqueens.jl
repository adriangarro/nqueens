# N Queens Problem.

# (c) E. Adrian Garro S. Costa Rica Institute of Technology.

type NQueens
    queens_quant::Int
    solutions::Array{Array{Int}}
    solutions_num::Int
end

"""
`permutations(xs)`
Permutations without repeated elements.
"""
function permutations(xs)
    if xs == []
        produce(Int[])
    else
        for x in xs
            temp = copy(xs)
            filter!(e -> e != x, temp)
            for ys in @task permutations(temp)
                produce(union(Int[x], ys))
            end
        end
    end
end

function set_queens_quant!(problem::NQueens, queens_quant::Int)
    if queens_quant > 3
        problem.queens_quant = queens_quant
    else
        error("Invalid number for this problem.")
    end
end

function attack(queens_cols::Array{Int})
    queens_quant = length(queens_cols)
    queens_rows = 1:queens_quant
    queens_pos = zip(queens_rows, queens_cols)
    sum_of_pos = [sum(pos) for pos in queens_pos]
    negative_queens_cols = [-1 * queen_col for queen_col in queens_cols]
    queens_pos = zip(queens_rows, negative_queens_cols)
    diff_of_pos = [sum(pos) for pos in queens_pos]
    # all results are different?
    in_diag45 = length(sum_of_pos) > length(Set(sum_of_pos))
    in_diag135 = length(diff_of_pos) > length(Set(diff_of_pos))
    there_attack = in_diag45 || in_diag135
end

function not_attack(queens_cols::Array{Int})
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
        println(string("\nSolution #", solution_num, "\n"))
        println(chessboard)
    else
        error("Solution not exist.")
    end
end
