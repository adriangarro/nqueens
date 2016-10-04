/* 
    N Queens Problem.
    
    SWI Prolog 7.2.3.
    
    (c) E. Adrian Garro S. Costa Rica Institute of Technology.
 */

:- use_module(library(clpfd)). % (all_different)

range(0, []):-!.
range(N, R):-
    N1 is N - 1,
    range(N1, R1),
    append(R1, [N1], R).

permut([], []).
permut([H|T], P):- 
    permut(T, T1), 
    append(L1, L2, T1), 
    append(L1, [H], P1), 
    append(P1, L2, P).

comb([], [], [], []).
comb([R|RT], [C|CT], [S|ST], [D|DT]):-
     S is R + C,
     D is R - C,
     comb(RT, CT, ST, DT).

solve(N, C):-
    range(N, R),
    permut(R, C), 
    comb(R, C, S, D),
    all_different(S),
    all_different(D).
    
get_all_solutions(N, S):-
    findall(C, solve(N, C), S).
   
duplicate(_, 0, ""):-!.    
duplicate(S, 1, S).
duplicate(S, N, R):-
    N1 is N - 1,
    duplicate(S, N1, R1),
    string_concat(S, R1, R).
    
print_chain(QQ):-
    duplicate("---+", QQ, CHT),
    string_concat("\n+", CHT, CH),
    write(CH).
    
print_box(QQ, QC):-
    F is QQ - (QC + 1),
    duplicate("   |", F, S),
    string_concat(" X |", S, S1),
    duplicate("   |", QC, S2),
    string_concat(S2, S1, S3),
    string_concat("\n|", S3, B),
    write(B).
 
print_solution(QQ, []):-
    print_chain(QQ),
    write("\n").   
print_solution(QQ, [QC|T]):-
    print_chain(QQ),
    print_box(QQ, QC),
    print_solution(QQ, T).
 
print_solutions(_, []):-!. 
print_solutions(N, [S|ST]):-
    print_solution(N, S),
    print_solutions(N, ST).
    
nqueens(N):-
    get_all_solutions(N, S),
    length(S, NS),
    write("Number of solutions: "),
    write(NS),
    print_solutions(N, S).
       