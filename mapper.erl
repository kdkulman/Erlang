-module(mapper).

-import(math, [pi/0]).
-import(lists, [nth/2]).
-import(lists, [reverse/1]).
-compile(export_all).

area(R) ->
    R * R * pi().

circ(R) ->
    2 * R * pi().

diam(R) ->
    2 * R.

double(X) -> X * 2.

higher(F, X) -> F(X).

myreturn(Y) -> fun (X) -> X * Y end.


map([], _) -> [];
map([H | T], F) -> [ F(H) | map(T, F)].

filter([], _) -> [];
filter([H|T], Pred)  -> 
  case Pred(H) of
    true -> [H | filter(T, Pred)];
    false -> filter(T, Pred)
  end.

genNorm({Min, Max}) -> 
  fun (X) -> (X - Min) / (Max - Min) end.

findMaxMin(L) -> {lists:min(L), lists:Max(L)}.

% shuffle(List) -> shuffle(List, []).
% shuffle([], Acc) -> Acc;
% shuffle(List, Acc) ->
%   {Leading, [H | T]} = lists:split(random:uniform(length(List)) - 1, List),
%   shuffle(Leading ++ T, [H | Acc]).

% split(L) ->
%   split(L, L, []).
% split([], L1, L2) ->
%   {reverse(L2), L1};
% split([_], L1, L2) ->
%   {reverse(L2), L1};
% split([_,_|TT], [H|T], L2) ->
%   split(TT, T, [H|L2]).

% merge(_, [], L2) ->
%   L2;
% merge(_, L1, []) ->
%   L1;
% merge(Comp, [H1|T1], [H2|T2]) ->
%   case Comp(H1, H2) of
%     true ->
%       [H1 | merge(Comp, T1, [H2|T2])];
%     false ->
%       [H2 | merge(Comp, [H1|T1], T2)]
%   end.

% msort(_, []) ->
%   [];
% msort(_, [H]) ->
%   [H];
% msort(Comp, L) ->
%   {Left, Right} = split(L),
%   merge(Comp, msort(Comp, Left), msort(Comp, Right)).