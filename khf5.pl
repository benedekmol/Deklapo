:- use_module(library(lists)).
:- use_module(library(between)).

iranylistak(NM, Fs, ILs) :-
  iranylistak_helper_all(NM, Fs, Fs,  Tmp),
  vanures(Tmp, ILs).

iranylistak_helper_all(_, [], _, Tmp).

iranylistak_helper_all(N-M, [ I-J | Fs_tail ], Fs, [Bag | TmpILs]) :-
  length([ I-J | Fs_tail ], L),
  length([Bag | TmpILs], L),
  iranylistak_helper_all(N-M, Fs_tail, Fs, TmpILs),
  findall(X, iranylistak_helper_ind(N-M,I-J, Fs, X), Tmp_Bag),
  % Tmp_Bag = [_|_],
  sort(Tmp_Bag, Bag).

%X sor száma
%Y oszlop száma
iranylistak_helper_ind(N-M, I-J, Fs, Res) :-
  %North direction
  I =< N,
  I > 1,
  J =< M,
  J > 0,
  X is I - 1, 
  Y is J,
  \+ member(X-Y, Fs),
  Res = n;
  %East direction
  I > 0,
  I =< N,
  J < M,
  J > 0,
  X is I,
  Y is J + 1,
  \+ member(X-Y, Fs),
  Res = e;
  %South direction
  I > 0,
  I < N,
  J =< M,
  J > 0,
  X is I + 1,
  Y is J,
  \+ member(X-Y, Fs),
  Res = s;
  %West direction
  I > 0,
  I =< N,
  J > 1,
  J =< M,
  X is I,
  Y is J - 1,
  \+ member(X-Y, Fs),
  Res = w.

poz_szamitas(I-J, Dir, X-Y) :-
  Dir = [n],
  X is I - 1,
  Y is J;
  Dir = [e],
  X is I,
  Y is J + 1;
  Dir = [s],
  X is I + 1,
  Y is J;
  Dir = [w],
  X is I,
  Y is J - 1.



%findall_helper()

inoctet(I-J,Xsator-Ysator) :-
  X is Xsator,
  Y is Ysator,
  Xlow is X - 1,
  Xhi is X + 1,
  Ylow is Y - 1,
  Yhi is Y + 1,
  between(Xlow, Xhi, I),
  between(Ylow, Yhi, J).

iranylista_helper(I-J, _, _, [], Tmp, Res) :-
  append(Tmp, [], Res).

iranylista_helper(I-J, Fa_poz, Sator_poz, [Irany | ILTail ], Tmp, Res ) :-
  % write(I-J),
  % write("IRANY"),
  % write(Irany),
  %irany bent marad

  [Irany | ILTail] = [_|_],
  poz_szamitas(I-J, [Irany], X-Y),
  % write(Sator_poz),
  X-Y \= Sator_poz,
  % write("IDE"),
  \+ inoctet(X-Y,Sator_poz),
  append(Tmp, [Irany], Tmp2),
  iranylista_helper(I-J, Fa_poz, Sator_poz, ILTail, Tmp2, Res);
  %irany kikerul
  [Irany | ILTail] = [_|_],
  poz_szamitas(I-J, [Irany], X-Y),
  inoctet(X-Y,Sator_poz),
  iranylista_helper(I-J, Fa_poz, Sator_poz, ILTail, Tmp, Res).

szukites_helper([],_,_,[],Res).
  
%szukites_helper(Fs, Fa_poz, Sator_poz, ILs0, Result)
szukites_helper( [I-J | Fs_tail], Fa_poz, Sator_poz, [ IL | ILs_tail], [ResItem | ResTail]) :-
  %epp kivalasztott
  I-J = Fa_poz,
  ResItem = IL,
  szukites_helper( Fs_tail, Fa_poz, Sator_poz, ILs_tail, ResTail);
  %Nem a kivalasztott
  I-J \= Fa_poz,
  length( [IL | ILs_tail], Length),
  length( [ResItem | ResTail ], Length),
  iranylista_helper(I-J,Fa_poz, Sator_poz, IL, [], ResItem),
  [ResItem] = [_|_],
  szukites_helper( Fs_tail, Fa_poz, Sator_poz, ILs_tail, ResTail).

vanures(TList, RList) :-
  member([], TList),
  RList = [];
  \+ member([], TList),
  append(TList, [], RList).

sator_szukites(Fs, I, ILs0, ILs) :-
  %Only one long list
  nth1(I, ILs0, Dir),
  length(Dir, Len),
  Len = 1,
  % ListOtherIL = ILs0 - A,
  % subtract( ILs0, [Dir], ListOtherIL),
  nth1(I, Fs, F_poz),
  % subtract(Fs, [F_poz], OtherFs),
  %Calculate pos of tree
  poz_szamitas(F_poz, Dir, Sator_poz),
  % write(Sator_poz),
  szukites_helper(Fs, F_poz, Sator_poz, ILs0, Tmp),
  vanures(Tmp, ILs).
  % write(ILs).
