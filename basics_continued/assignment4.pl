makepairs(_, [], []).
makepairs(A, [H|T], B) :-
    B1 = [pair(A, H)],
    makepairs(A, T, B2),
    append(B1, B2, B).
cartesian([], _, []).
cartesian([XH|XT], Y, Z) :-
    makepairs(XH, Y, B1),
    cartesian(XT, Y, B2),
    append(B1, B2, Z).

deepsum([], 0).
deepsum([H|T], Y) :-
    not(number(H)),
    not(string(H)),
    not(atom(H)),
    deepsum(H, Y1),
    deepsum(T, Y2),
    Y is Y1+Y2;
	
    string(H),
    deepsum(T, Y);
    
    atom(H),
    deepsum(T, Y);
    
    number(H),
    deepsum(T, Y1),
    Y = H + Y1.
deepsum([], 0, 0).
deepsum([H|T], Pos, Neg) :-
    not(number(H)),
    deepsum(H, Pos1, Neg1),
    deepsum(T, Pos2, Neg2),
    Pos is Pos1 + Pos2,
    Neg is Neg1 + Neg2;
    
    string(H),
    deepsum(T, Pos, Neg);
    
    atom(H),
    deepsum(T, Pos, Neg);
    
    number(H),
    H > 0,
    deepsum(T, Pos1, Neg),
    Pos is H + Pos1;
    
    number(H),
    H < 0,
    deepsum(T, Pos, Neg1),
    Neg is H + Neg1.
numbers([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]).

select(X, [X|T], T).
select(X, [H|T], L2):-
    select(X, T, L3),
    L2 = [H|L3].
sumfits(N1, N2, N3, N4) :-
    number(N4),
    N5 is N1+N2+N3+N4,
    N5 = 34;
    not(number(N4)),
    N4 is 34-N1-N2-N3.

start( S, Free16 ) :-
	S = [ [ _A11, _A12, _A13, _A14 ],
	[ _A21, _A22, _A23, _A24 ],
	[ _A31, _A32, _A33, _A34 ],
	[ _A41, _A42, _A43, _A44 ] ],
	numbers( Free16 ).

printsquare([A11, A12, A13, A14|S]) :-
    write([A11, A12, A13, A14]), nl, printsquare(S).

step1( S, Free7 ) :-
	S = [ [ A11, A12, A13, A14 ],
		  [ A21, _A22, A23, _A24 ],
		  [ A31, A32, _A33, _A34 ],
		  [ A41, _A42, _A43, _A44 ] ],
	start( S, Free16 ),
    select(A11,Free16,Free15), select(A12,Free15,Free14), select(A13, Free14, Free13),
    sumfits(A11, A12, A13, A14), select(A14, Free13, Free12), A11 < A14,
    select(A21,Free12,Free11), select(A31,Free11,Free10), sumfits(A11, A21, A31, A41),
    select(A41, Free10, Free9), A11 < A41,  A41 < A14,
    select(A23,Free9,Free8), sumfits(A14, A23, A41, A32), select(A32, Free8, Free7).

step2( S, Free4 ) :-
	S = [ [ _A11, A12, _A13, _A14 ],
	[ A21, A22, A23, A24 ],
	[ _A31, A32, _A33, _A34 ],
	[ _A41, A42, _A43, _A44 ] ],
	step1( S, Free7 ),
    select(A22,Free7,Free6), sumfits(A21, A22, A23, A24), select(A24,Free6,Free5),
    sumfits(A12, A22, A32, A42), select(A42,Free5,Free4).

step3( S, Free2 ) :-
	S = [ [ A11, _A12, _A13, _A14 ],
	[ _A21, A22, _A23, _A24 ],
	[ _A31, _A32, A33, _A34 ],
	[ _A41, _A42, _A43, A44 ] ],
	step2( S, Free4 ),
    select(A33, Free4, Free3), sumfits(A11, A22, A33, A44), select(A44, Free3, Free2),
    A11 < A44.

step4( S, Free0 ) :-
	S = [ [ _A11, _A12, _A13, A14 ],
	[ _A21, _A22, _A23, A24 ],
	[ _A31, _A32, _A33, A34 ],
	[ A41, A42, A43, A44 ] ],
	step3( S, Free2 ),
    sumfits(A41, A42, A44, A43), select(A43, Free2, Free1),
    sumfits(A14, A24, A44, A34), select(A34, Free1, Free0).
    
printall :-
	step4( S, Free0 ),
	Free0 = [],
	printsquare(S), fail.