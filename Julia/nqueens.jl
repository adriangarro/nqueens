# N Queens. -#

# (c) E. Adrian Garro S. Costa Rica Institute of Technology. -#

function are_in_diag45(queen1_row::Int, queen1_col::Int, queen2_row::Int, queen2_col::Int)
    return queen1_row - queen1_col == queen2_row - queen2_col
end

function are_in_diag135(queen1_row::Int, queen1_col::Int, queen2_row::Int, queen2_col::Int)
    return queen1_row + queen1_col == queen2_row + queen2_col
end

function are_in_diag(queen1_row::Int, queen1_col::Int, queen2_row::Int, queen2_col::Int)
    result_diag45 = are_in_diag45(
        queen1_row, queen1_col, queen2_row, queen2_col
    )
    result_diag135 = are_in_diag135(
        queen1_row, queen1_col, queen2_row, queen2_col
    )
    result_diag = result_diag45 || result_diag135
    return result_diag
end

function combinations_of_2(elements)
    elements_len = length(elements)
    function _it()
        for i = 1:elements_len
            for j = i+1:elements_len
                produce(
                    (elements[i], elements[j])
                )
            end
        end
    end
    Task(_it)
end

function attack(queens_cols)
    queens_pos = Dict(enumerate(queens_cols))
    inv_queens_pos = Dict((col, row) for (row, col) in queens_pos)
    pairs_queen_cols = combinations_of_2(queens_cols)
    there_attack = false
    for (queen1_col, queen2_col) in pairs_queen_cols
        queen1_row = inv_queens_pos[queen1_col]
        queen2_row = inv_queens_pos[queen2_col]
        if are_in_diag(queen1_row, queen1_col, queen2_row, queen2_col)
            there_attack = true
            break
        end
    end
    return there_attack
end

function not_attack(queens_cols)
    return !attack(queens_cols)
end

function permutations(elements)
    return elements
end

