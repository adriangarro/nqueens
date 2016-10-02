#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
nqp.py: N Queens Problem.
'''

from combinatorial import permutations, combinations_of_2

__copyright__ = '(c) 2016 E. Adrian Garro S. Costa Rica Institute of Technology.'

class N_Queens:
    def __init__(self):
        self.queens_quant = 0
        self.solutions = []
        self.solutions_num = 0
        
    def set_queens_quant(self, queens_quant):
        if queens_quant > 3:
            self.queens_quant = queens_quant
        else:
            raise ValueError('Invalid number for this problem.')
    
    def are_in_diag(self, queen1_row, queen1_col, queen2_row, queen2_col):
        values = [queen1_row, queen1_col, queen2_row, queen2_col]
        if False not in [isinstance(value, int) for value in values]:
            in_diag45 = queen1_row - queen1_col == queen2_row - queen2_col
            in_diag135 = queen1_row + queen1_col == queen2_row + queen2_col
            in_diag = in_diag45 or in_diag135
            return in_diag
        else:
            raise TypeError('The parameters must be integers.')
                
    def attack(self, queens_cols):
        queens_pos = dict(enumerate(queens_cols))
        inv_queens_pos = {col : row for row, col in queens_pos.items()}
        pairs_queen_cols = combinations_of_2(queens_cols)
        there_attack = False
        for queen1_col, queen2_col in pairs_queen_cols:
            queen1_row = inv_queens_pos[queen1_col]
            queen2_row = inv_queens_pos[queen2_col]
            if self.are_in_diag(queen1_row, queen1_col, queen2_row, queen2_col):
                there_attack = True
                break
        return there_attack
        
    def not_attack(self, queens_cols):
        return not self.attack(queens_cols)
    
    def solve(self):
        if self.queens_quant:
            all_possible_queens_cols = permutations(
                list(range(self.queens_quant))
            )
            self.solutions = [
                queens_cols for queens_cols in all_possible_queens_cols 
                if self.not_attack(queens_cols)
            ]
            self.solutions_num = len(self.solutions)
        else:
            raise AttributeError('Number of queens not available.')
    
    def print_solution(self, solution_num):
        if solution_num in range(1, self.solutions_num+1):
            solution = self.solutions[solution_num-1]
            def create_box(queen_pos):
                box = (
                    '\n|' 
                    + '   |' * queen_pos 
                    + ' X |' 
                    + '   |' * (self.queens_quant - (queen_pos + 1))
                )
                return box
            boxes = [create_box(queens_cols) for queens_cols in solution]
            chain = '\n+' + '---+' * self.queens_quant
            chessboard = chain + chain.join(boxes) + chain
            print('\nSolution #' + str(solution_num) + '\n')
            print(chessboard)
        else:
            raise IndexError('Solution not exist.')
