% loves(romeo, juliet).

% loves(juliet, romeo):- loves(romeo, juliet).



male(albert).
male(bob).
male(bill).

female(alice).
female(betsy).


parent(alice, bob).
parent(alice, betsy).
parent(alice, bill).

% happy(albert).
happy(alice).
% happy(bob).
% happy(bill).
with_albert(alice).

% runs(albert) :- 
%   happy(albert).

dances(alice) :-
  happy(alice),
  with_albert(alice).

does_alice_dance :-
  dances(alice),
  write('when alice is happy and with albert she dances').

% swims(bill) :- 
%   happy(bill).

% swims(bill) :-
%   near_water(bill).



% :- type parcMutató ==   int-int.          % egy parcella helyét meghatározó egészszám-pár
% :- type fák        ==   list(parcMutató). % a fák helyeit tartalmazó lista
% :- type irány    --->   n                 % észak 
%                       ; e                 % kelet 
%                       ; s                 % dél   
%                       ; w.                % nyugat
% :- type sHelyek    ==   list(irany).      % a fákhoz tartozó sátrak irányát megadó lista
% :- type bool       ==   int               % csak 0 vagy 1 lehet
% :- type boolMx     ==   list(list(bool)). % a sátrak helyét leíró 0-1 mátrix

% :- pred satrak_mx(parcMutató::in,         % NM
%                   fák::in,                % Fs
%                   sHelyek::in,            % Ss
% %                   boolMx::out).           % Mx

% | ?- satrak_mx(2-3, [2-2], [n], Mx).
%                                                Mx = [[0,1,0],[0,0,0]] ? ; no
					       
% | ?- satrak_mx(2-3, [2-2], [e], Mx).	       
%                                                Mx = [[0,0,0],[0,0,1]] ? ; no
					       
% | ?- satrak_mx(2-3, [3-2], [n], Mx).           no            % (meghiúsulás 1)
					       
% | ?- satrak_mx(2-3, [2-2], [s], Mx).           no            % (meghiúsulás 2)
					       
% | ?- satrak_mx(2-3, [1-1,2-2], [e,n], Mx).     no            % (meghiúsulás 3)
% | ?- satrak_mx(4-5, [2-4,1-5,3-2], [s,w,w], Mx).
%                                                Mx = [[0,0,0,1,0],
%                                                      [0,0,0,0,0],
%                                                      [1,0,0,1,0],
%                                                      [0,0,0,0,0]] ? ; no
    

satrak_mx(NM, Fs, Ss, Mx) :-
  satrak_helper(NM, Fs, Ss, [], ResultArr),
  satornemfan(Fs, ResultArr),
  writeln("FINAL: "),
  writeln(ResultArr).

sorepito(M, RowI, 0, Tmp, ResultArr, Row).

%TODO ha eleme RowI,I a ResultArr-nak akkor 1 ha nem akkor 0
sorepito(M, RowI, I, Tmp, ResultArr, Row) :-
  I =< M,
  I > 0,
  \+ member([RowI,I], ResultArr),
  T is I - 1,
  write("not in it"),
  sorepito(M, RowI, T, Tmp2, ResultArr, Te),
  append([0], Te, Row);
  I =< M,
  I > 0,
  member([RowI,I], ResultArr),
  T is I - 1,
  write("in it"),
  sorepito(M, RowI, T, Tmp2, ResultArr, Te),
  append([1], Te, Row).

% kakker2(X,Y,Z) :-
%   member([X,Y],Z).


% sor(0, Tmp, ResultList) :-
%   append(Tmp, [], ResultList).

% sor(M, Tmp ,ResultList) :-
%   M > 0,
%   append([0], Tmp, TmpArr2),
%   T is M - 1,
%   sor(T, TmpArr2, ResultList).

% ures_matrix(N-M, Mx) :-
%  ures_matrix_helper(N,M,Mx).

% ures_matrix_helper(0,M,Mx).

% ures_matrix_helper(N,M,Mx) :-
%   N > 0,
%   N2 is N - 1,
%   sor(M, [], Sor),
%   % append([Sor], Mx, Tx),
%   ures_matrix_helper(N2, M, Tx),
%   append([Sor], Tx, Mx).

% matrix_iro( [X,Y], Mx, Result) :-

satornemfan(Fs, []) .

satornemfan(Fs, [[X,Y] | ResultTail]) :-
  write(X),
  \+ member(Y-X, Fs),
  satornemfan(Fs, ResultTail).

satrak_helper(N-M, [], [], Tmp, Result) :-
  write("ARRRRR"),
  % write(Result),
  % write(Tmp),
  append(Tmp, [], Result),
  write("Result: "), 
  write(Result).
  % Result is Tmp.

%megnézi a i-j fához viszonyítva a direction jó-e ha igen akkor belerakja az eredménybe
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
  \+ member([X,Y], TmpArr),
  append([[X,Y]], TmpArr, TmpArr2),
  % writeln(Direction),
  % format("X: ~w", X),
  % format("Y: ~w", Y),
  % writeln(""),
  satrak_helper(N-M,Tail, DirectionTail, TmpArr2, ResultArr);
  %East Direction
  Direction == e,
  J + 1 =< M,
  J > 0,
  I =< N,
  I > 0,
  Y is I,
  X is J + 1,
  \+ member([X,Y], TmpArr),
  append([[X,Y]], TmpArr, TmpArr2),
  % writeln(Direction),
  % format("X: ~w", X),
  % format("Y: ~w", Y),
  % writeln(""),
  satrak_helper(N-M,Tail, DirectionTail, TmpArr2, ResultArr);
  %South Direction
  Direction == s,
  I > 0,
  I + 1 =< N,
  J > 0,
  J =< M,
  Y is I + 1,
  X is J,
  \+ member([X,Y], TmpArr),
  append([[X,Y]], TmpArr, TmpArr2),
  % writeln(Direction),
  % format("X: ~w", X),
  % format("Y: ~w", Y),
  % writeln(""),
  satrak_helper(N-M,Tail, DirectionTail, TmpArr2, ResultArr);
  %West Direction
  Direction == w,
  I > 0,
  I =< N,
  J > 1,
  J =< M,
  Y is I,
  X is J - 1,
  \+ member([X,Y], TmpArr),
  append([[X,Y]], TmpArr, TmpArr2),
  % writeln(Direction),
  % format("X: ~w", X),
  % format("Y: ~w", Y),
  % writeln(""),
  satrak_helper(N-M,Tail, DirectionTail, TmpArr2, ResultArr);
  I < 0.

kakker(X,Y,Z) :-
  member(X-Y,Z).


length_list(N, L) :-
  length(L, N).

n_matrix(N, Xss) :-
  length(Xss, N),
  maplist(length_list(N),Xss).

% generate_matrix(N, M, Mx) :-
