/* 
    N Queens Problem.
    
    (c) E. Adrian Garro S. Costa Rica Institute of Technology.
 */

elem(X, [X|_]).
elem(X, [_|T]):- 
    elem(X, T).
    
len([], 0).
len([_|T], N):- 
    len(T, N1), 
    N is 1 + N1.

cat([], L, L).
cat([H|L1], L2, [H|L3]):- 
    cat(L1, L2, L3).
    
all_diff([_]).
all_diff([H|T]):-  
    \+ elem(H, T), 
       all_diff(T).
    
range(0, []):-!.
range(N, R):-
    N1 is N - 1,
    range(N1, R1),
    cat(R1, [N1], R).

permut([], []).
permut([H|T], P):- 
    permut(T, T1), 
    cat(L1, L2, T1), 
    cat(L1, [H], P1), 
    cat(P1, L2, P).

comb([], [], [], []).
comb([R|RT], [C|CT], [S|ST], [D|DT]):-
     S is R + C,
     D is R - C,
     comb(RT, CT, ST, DT).

solve(N, C):-
    range(N, R),
    permut(R, C), 
    comb(R, C, S, D),
    all_diff(S),
    all_diff(D).
    
    