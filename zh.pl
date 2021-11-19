
kakis("haha").

f4(L,X) :-
  % findall(Y, (member(Y,L),Y > 7), X).
  reverse(L, Z),
  member(Y,Z),
  Y > 7,
  X is Y.
  % setof(Y, (member(Y,L),Y > 7), Z),
  % reverse(Z, X).


f5(L, X) :-
  append(_,[A,X,B|_], L),
  ( X > A,
    X > B;
    X < A,
    X < B).

  % select([X,Y,B],L,R),
  % write(A),
  % write(L),
  % write(A).

f6(L, A-B) :-
  append(_, [X,Y|_],L),
  X + Y =:= 5,
  A is X,
  B is Y.

f7(L, h(A,S,B)) :-
  append(_, [X|L1],L),
  append(_,[Y|L2], L1),
  append(_,[Z|_],L2),
  X + Z =:= Y,
  A is X,
  B is Z,
  S is Y.
  % write(X),
  % write(Y),
  % write(Z).

f8(L, S) :-
  findall(X,(member(X,L), mod(X,2) =:= 0 ),TmpList),
  sumlist(TmpList, S).
  % write(TmpList).

helyettesitese(K, HL,E) :-
  (number(K),
  E is K,!;
  member(K-X,HL),E is X,!;
  E is 0
  ).


erteke(Kif, Hely, Ert) :-
  (atom(Kif),
  helyettesitese(Kif,Hely, X),
  !, Ert is X;
  number(Kif),
  helyettesitese(Kif, Hely, X),
  !, Ert is X;
  %egy operandusu
  Kif =.. [Op, A1],
  erteke(A1, Hely, A1E),
  EKif =.. [Op, A1E],
  !, Ert is EKif;
  %ket operandusu
  Kif =.. [Op, A1, A2],
  erteke(A1, Hely, A1E),
  erteke(A2, Hely, A2E),
  EKif =.. [Op, A1E, A2E],
  !, Ert is EKif
  ).

kisbetu(K) :-
  K >= 0'a,
  K =< 0'z.

kezdo_szava(L, Kezdet, Maradek) :-
  kezdo_szava_help(L, X, Maradek),
  X = [_,_|_],
  X = Kezdet.

kezdo_szava_help([A|L], Kezdet, Maradek):-
  \+ kisbetu(A),
  Kezdet = [],
  Maradek = L;
  kisbetu(A),
  Kezdet = [A | Kezdet1],
  kezdo_szava_help(L, Kezdet1, Maradek).

szava(Atom, Szo, Index):-
  atom_codes(Atom, C),
  szava_helper(C, SzoC, Index).

szava_helper(AtomC, SzoC, Index):-
  \+ kezdo_szava(AtomC, Kezdet, Maradek),
  Index1 is Index + 1,
  AtomC = [AtomH | AtomT]
  szava(AtomT, Szo, Index1);
  kezdo_szava(AtomC)
  write("asdf").