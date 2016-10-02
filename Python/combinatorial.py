#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
combinatorial.py: Combinatorial functions.
'''

__copyright__ = '(c) 2016 E. Adrian Garro S. Costa Rica Institute of Technology.'

def combinations_of_2(xs):
    '''
    Combinations of 2 without repeated elements.
    '''
    return ((x, y) for x in xs for y in xs if y > x)

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
