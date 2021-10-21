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
  write(X).

satrak_helper(N-M, [], [], Tmp, Result) :-
  write("ARRRRR"),
  write(Result),
  write(Tmp),
  Result is Tmp.

%megnézi a i-j fához viszonyítva a direction jó-e ha igen akkor belerakja az eredménybe
satrak_helper(N-M,[I-J | Tail], [Direction | DirectionTail ], TmpArr, ResultArr) :-
  % Direction is "n",
  I > 1,
  I =< N,
  J =< M,
  J > 0,
  X is I - 1, 
  Y is J,
  \+ member([X,Y], TmpArr),
  append([[X,Y]], TmpArr, TmpArr2),
  writeln(Direction),
  satrak_helper(N-M,Tail, DirectionTail, TmpArr2, ResultArr),
  write(TmpArr2),
  write("X: "),
  write(X),
  write(" Y: "),
  write(Y);
  I < 0.

kakker(X,Y,Z) :-
  \+ member(X, Y).


length_list(N, L) :-
  length(L, N).

n_matrix(N, Xss) :-
  length(Xss, N),
  maplist(length_list(N),Xss).

% generate_matrix(N, M, Mx) :-
