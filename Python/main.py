#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
main.py: N Queens Problem.
'''

from nqueens import N_Queens

__copyright__ = '(c) 2016 E. Adrian Garro S. Costa Rica Institute of Technology.'

def int_input(message):
    return int(input(message))
        
def main():
    options = ['1']
    problem =  N_Queens()
    while True:
        print('--------(N Queens Problem)---------')
        print('---------------Menu----------------')
        print('    	1) Input problem.')
        if '2' in options: print(' 	2) See solutions.')
        print('    	0) End.')
        print('----------------------------------')
        choice = input('Select an option to continue: ')
        if choice in ['1', '2']:
            if choice == '1':
                queens_quant = int_input(
                    '\nWelcome, please write the number of queens: '
                )
                try:
                    problem.set_queens_quant(queens_quant)
                    problem.solve()
                    print('Problem solve! Please see the solutions :)\n')
                    # show option: see solutions
                    if '2' not in options: options.append('2')
                except ValueError:
                    print('The number of queens can not be lower than 4.')
                    print('Try it again please.\n')
            if choice == '2':
                solutions_num = problem.solutions_num
                print('\nThe number of solutions for this problem are:', solutions_num)
                solution_num = int_input(
                    'Please write the number of the solution that you want see: '
                )
                try:
                    problem.print_solution(solution_num)
                    print('\n')
                except IndexError:
                    print('Sorry, this solution does not exist.\n')
        elif choice == '0':
            print('Thank you for your time. ;)')
            return
        else:
            print('Pick a valid option from menu.')

if __name__ == '__main__':
    main()
            