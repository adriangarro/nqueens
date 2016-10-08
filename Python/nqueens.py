#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
nqp.py: N Queens Problem.
'''

__copyright__ = '(c) 2016 E. Adrian Garro S. Costa Rica Institute of Technology.'

def permutations(xs):
    '''
    Permutations without repeated elements.
    '''
    if xs == []:
        yield []
    for x in xs:
        temp = xs[:]
        temp.remove(x)
        for ys in permutations(temp):
            yield [x] + ys


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
            
    def attack(self, queens_cols):
        queens_quant = len(queens_cols)
        queens_rows = range(queens_quant)
        queens_pos = zip(queens_rows, queens_cols)
        sum_of_pos = [sum(pos) for pos in queens_pos]
        negative_queens_cols = (-1 * queen_col for queen_col in queens_cols)
        queens_pos = zip(queens_rows, negative_queens_cols)
        diff_of_pos = [sum(pos) for pos in queens_pos]
        # all results are different?
        in_diag45 = len(sum_of_pos) > len(set(sum_of_pos))
        in_diag135 = len(diff_of_pos) > len(set(diff_of_pos))
        there_attack = in_diag45 or in_diag135
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
