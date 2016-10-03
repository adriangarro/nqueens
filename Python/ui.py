#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
main.py: User interaction with N Queens Problem.
'''

from nqueens import N_Queens

__copyright__ = '(c) 2016 E. Adrian Garro S. Costa Rica Institute of Technology.'

class UI:
    def __init__(self):
        self.option = ''
        self.problem = N_Queens()
    
    def int_input(self, message):
        return int(input(message))

    def read_option(self):
        print('\n--------(N Queens Problem)---------')
        print('    	1) Input problem.')
        print(' 	2) See solutions.')
        print('    	0) End.')
        print('----------------------------------\n')
        self.option = input('Select an option to continue: ')

    def input_problem(self):
        try:
            queens_quant = self.int_input(
                'Please write the number of queens: '
            )
            try:
                self.problem.set_queens_quant(queens_quant)
                self.problem.solve()
                print('Problem solve! Please see the solutions :)')
            except ValueError as verr:
                print(verr)
        except ValueError as verr:
            print(verr)

    def see_solutions(self):
        solutions_num = self.problem.solutions_num
        if solutions_num != 0:
            print('The number of solutions for this problem are:', solutions_num)
            try:
                solution_num = self.int_input(
                    'Please write the number of the solution you want to see: '
                )
                try:
                    self.problem.print_solution(solution_num)
                except IndexError as ierr:
                    print(ierr)
            except ValueError as verr:
                print(verr)
        else: print("See solutions is not available.")

    def menu(self):
        if self.option == '':
            return True
        elif self.option == '1':
            self.input_problem()
            return True
        elif self.option == '2':
            self.see_solutions()
            return True
        elif self.option == '0':
            print("Thank you for your time. ;)")
            return False
        else:
            print("Pick a valid option from menu!")
            return True
    
    def main(self):
        while(self.menu()):
            self.read_option()
            
if __name__ == '__main__':
    app = UI()
    app.main()
