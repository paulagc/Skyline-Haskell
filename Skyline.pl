%ed(XA,XB,H).

%c(X,Y).

%skyline([c(X,Y)]).

resuelveSkyline([],[]).
resuelveSkyline([ed(XA,XB,H)|[]],S):- edificioASkyline(ed(XA,XB,H),S).
resuelveSkyline(ED,SOL):- divide(ED,SK1,SK2),resuelveSkyline(SK1, S1),resuelveSkyline(SK2,S2), combina(S1,S2,SOL).

edificioASkyline(ed(X1,X2,H),S):- S=[c(X1,H),c(X2,0)].


divide(L,L1,L2):-length(L,N), Mitad is N div 2, length(L1, Mitad), length(L2,_), append(L1,L2,L).


combina(Sk1,Sk1).
combina(Sk1,Sk2,SOL):-
combina2(Sk1,Sk2,SOL,0,0,0).
combina2([],[],[],_,_,_).

combina2([c(X,HX)|XS],[],[c(X,Z)|SOL],_,ULTHY,ULTH):-
(maximo(HX,ULTHY,Z),ULTH =\= Z,
combina2(XS,[],SOL,HX,ULTHY,Z)).

combina2([c(_,HX)|XS],[],SOL,_,ULTHY,ULTH):-
(maximo(HX,ULTHY,Z),ULTH == Z,
combina2(XS,[],SOL,HX,ULTHY,Z)).

% —------------------------------------------------—
combina2([],[c(Y,HY)|YS],[c(Y,Z)|SOL],ULTHX,_,ULTH):-
(maximo(ULTHX,HY,Z),ULTH =\= Z,
combina2([],YS,SOL,ULTHX,HY,Z)).

combina2([],[c(_,HY)|YS],SOL,ULTHX,_,ULTH):-
(maximo(ULTHX,HY,Z),ULTH == Z,
combina2([],YS,SOL,ULTHX,HY,Z)).
% —------------------------------------------------------


combina2([c(X,HX)|XS],[c(Y,HY)|YS],[c(X,Z)|SOL],_,ULTHY,ULTH):-
(X<Y,maximo(HX,ULTHY,Z),ULTH =\= Z,
combina2(XS,[c(Y,HY)|YS],SOL,HX,ULTHY,Z)).

%bien
combina2([c(X,HX)|XS],[c(Y,HY)|YS],SOL,_,ULTHY,ULTH):-
(X<Y,maximo(HX,ULTHY,Z),ULTH == Z,
combina2(XS,[c(Y,HY)|YS],SOL,HX,ULTHY,Z)).
%—------------------------------------------------------


combina2([c(X,HX)|XS],[c(Y,HY)|YS],SOL,_,_,ULTH):-
(X == Y,maximo(HX,HY,Z),ULTH ==Z,
combina2(XS,YS,SOL,HX,HY,ULTH)).




combina2([c(X,HX)|XS],[c(Y,HY)|YS],[c(X,Z)|SOL],_,_,ULTH):-
(X == Y, maximo(HX,HY,Z),ULTH =\= Z,
combina2(XS,YS,SOL,HX,HY,Z)).


% —------------------------------------------------—

combina2([c(X,HX)|XS],[c(Y,HY)|YS],[c(Y,Z)|SOL],ULTHX,_,ULTH):-
(X>Y,maximo(ULTHX,HY,Z),ULTH =\= Z,
combina2([c(X,HX)|XS],YS,SOL,ULTHX,HY,Z)).


combina2([c(X,HX)|XS],[c(Y,HY)|YS],SOL,ULTHX,_,ULTH):-
(X>Y,maximo(ULTHX,HY,Z),ULTH == Z,
combina2([c(X,HX)|XS],YS,SOL,ULTHX,HY,Z)).

maximo(A,B,C):- (A=<B->C=B;C=A).
