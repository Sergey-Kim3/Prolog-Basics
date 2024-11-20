%------Task1------
ega(table, tisch, m).
ega(chair, stuhl, m).
ega(bed, bett, n).
ega(child, kind, n).
ega(brother, bruder, m).
ega(sister, schwester, f).
ega(house, haus, n).
ega(sun, sonne, f).
ega(cloud, wolke, f).
ega(wind, wind, m).
ega(rain, regen, m).


enggerm(E, G, A):-
    ega(E, G, A).

egai(table, tavolo, m).
egai(chair, sedia, f).
egai(bed, letto, m).
egai(child, bambino, m).
egai(child, bambina, f).
egai(brother, fratello, m).
egai(sister, sorella, f).
egai(house, casa, f).
egai(sun, sole, f).
egai(cloud, nube, f).
egai(wind, vento, m).
egai(rain, pioggia, f).

engit(E, I, A):-
    egai(E, I, A).

article( f, die ).
article( m, der ).
article( n, das ).

gerwitharticle( E, A, G ):-
    ega(E, G, Z),
    article(Z, A).

samegender(E):-
    ega(E, _G, A), 
    egai(E, _I, A).
    
%------Task2------
male(carl_gustav).
male(daniel_westling).
male(carl_philip).
male(christopher_o_neill).
male(oscar).
male(alexander).
male(gabriel).
male(nicolas).

female(silvia).
female(victoria).
female(sofia_hellqvist).
female(madeleine).
female(estelle).
female(leonore).
female(adrienne).

parent(victoria, estelle).
parent(victoria, oscar).
parent(daniel_westling, estelle).
parent(daniel_westling, oscar).
parent(carl_philip, alexander).
parent(carl_philip, gabriel).
parent(sofia_hellqvist, alexander).
parent(sofia_hellqvist, gabriel).
parent(madeleine, leonore).
parent(madeleine, nicolas).
parent(madeleine, adrienne).
parent(christopher_o_neill, leonore).
parent(christopher_o_neill, nicolas).
parent(christopher_o_neill, adrienne).
parent(carl_gustav, victoria).
parent(carl_gustav, carl_philip).
parent(carl_gustav, madeleine).
parent(silvia, victoria).
parent(silvia, carl_philip).
parent(silvia, madeleine).

rulesover(carl_gustav, sweden).
rulesover(silvia, sweden).
rulesover(victoria, vastergotland).
rulesover(daniel_westling, vastergotland).
rulesover(carl_philip, varmland).
rulesover(sofia_hellqvist, varmland).
rulesover(madeleine, halsingland_and_gastrikland).
rulesover(estelle, ostergotland).
rulesover(alexander, sodermanland).
rulesover(gabriel, datama).
rulesover(leonore, gotland).
rulesover(nicolas, angermanland).
rulesover(adrienne, blekinge).

sibling(X, Y):-
    parent(P, X), parent(PP, X),
    parent(P, Y), parent(PP, Y),
    P \= PP,
    X \= Y.

sister(X, Y):-
    female(X), sibling(X, Y).
brother(X, Y):-
    male(X), sibling(X, Y).

father(X, Y):-
    parent(X, Y), male(X).
mother(X, Y):-
    parent(X, Y), female(X).
son(X, Y):-
    parent(X, Y), male(Y).
daughter(X, Y):-
    parent(X, Y), female(Y).
king(X):-
    rulesover(X, sweden), male(X).
queen(X):-
    rulesover(X, sweden), female(X).
duchess(X):-
    rulesover(X, Y), female(X),
    not(queen(X)),
    Y \= "sweden".
duke(X):-
    rulesover(X, Y), male(X),
    not(king(X)),
    Y \= "sweden".
