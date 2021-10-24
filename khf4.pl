:- use_module(library(lists)).

satrak_mx(NM, Fs, Ss, Mx) :-
  N-M = NM,
  satrak_helper(NM, Fs, Ss, [], ResultArr),
  matrix_epito(N,M,N,ResultArr,Mx).

%Létrehoz egy sort az eredmény mátrixából a ResultArr tömbből és a megadott sor számából.
sorepito(M, RowI, 0, ResultArr, Row) :-
  print(Row).

sorepito(M, RowI, I, ResultArr, Row) :-
  length(Row, M),
  I =< M,
  I > 0,
  \+ member([RowI,I], ResultArr),
  T is I - 1,
  nth1(I,Row,0),
  sorepito(M, RowI, T, ResultArr, Row);
  length(Row, M),  
  I =< M,
  I > 0,
  member([RowI,I], ResultArr),
  T is I - 1,
  nth1(I,Row,1),
  sorepito(M, RowI, T, ResultArr, Row).

%Létrehozza az eredménymátrixot a ResultArr segítségével
matrix_epito(N,M, 0, ResultArr, Mx).

matrix_epito(N,M, I, ResultArr, Mx) :-
  length(Mx, N),
  I =< N,
  I > 0,
  T is I - 1,
  sorepito(M,I,M,ResultArr,Row),
  nth1(I, Mx, Row),
  matrix_epito(N,M,T,ResultArr, Mx).

%Ellenőrzi, hogy fa van-e a sátor helyén. NEM KELL A FELADATHOZ
satornemfan(Fs, []) .

satornemfan(Fs, [[X,Y] | ResultTail]) :-
  \+ member(X-Y, Fs),
  satornemfan(Fs, ResultTail).

satrak_helper(N-M, [], [], Tmp, Result) :-
  append(Tmp, [], Result).

%Minden elemre a fa listából előállítja a sátor lehetséges koordinátáját
%Ha már van olyan koordináta amit előállít akkor hibára futva megáll a futás.
satrak_helper(N-M,[I-J | Tail], [Direction | DirectionTail ], TmpArr, ResultArr) :-
  %North Direction
  Direction == n,
  I =< N,
  I > 1,
  I =< N,
  J =< M,
  J > 0,
  Y is I - 1, 
  X is J,
  \+ member([Y,X], TmpArr),
  append([[Y,X]], TmpArr, TmpArr2),
  satrak_helper(N-M,Tail, DirectionTail, TmpArr2, ResultArr);
  %East Direction
  Direction == e,
  J + 1 =< M,
  J > 0,
  I =< N,
  I > 0,
  Y is I,
  X is J + 1,
  \+ member([Y,X], TmpArr),
  append([[Y,X]], TmpArr, TmpArr2),
  satrak_helper(N-M,Tail, DirectionTail, TmpArr2, ResultArr);
  %South Direction
  Direction == s,
  I > 0,
  I + 1 =< N,
  J > 0,
  J =< M,
  Y is I + 1,
  X is J,
  \+ member([Y,X], TmpArr),
  append([[Y,X]], TmpArr, TmpArr2),
  satrak_helper(N-M,Tail, DirectionTail, TmpArr2, ResultArr);
  %West Direction
  Direction == w,
  I > 0,
  I =< N,
  J > 1,
  J =< M,
  Y is I,
  X is J - 1,
  \+ member([Y,X], TmpArr),
  append([[Y,X]], TmpArr, TmpArr2),
  satrak_helper(N-M,Tail, DirectionTail, TmpArr2, ResultArr);
  I < 0.
