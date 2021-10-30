iranylistak(NM, Fs, ILs) :-
  iranylistak_helper_all(NM, Fs, Fs,  ILs).

%X sor száma
%Y oszlop száma
iranylistak_helper_all(_, [], _, Tmp).

iranylistak_helper_all(N-M, [ I-J | Fs_tail ], Fs, [Bag | TmpILs]) :-
  length([ I-J | Fs_tail ], L),
  length([Bag | TmpILs], L),
  iranylistak_helper_all(N-M, Fs_tail, Fs, TmpILs),
  findall(X, iranylistak_helper_ind(N-M,I-J, Fs, X), Tmp_Bag),
  Tmp_Bag = [_|_],
  sort(Tmp_Bag, Bag).

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


% asdf_help(N-M, [I-J | Fs_tail], X) :-
asdf_help([ N | Tail], X) :-
  N == 2,
  X is 2;
  N < 5,
  X is 5.


