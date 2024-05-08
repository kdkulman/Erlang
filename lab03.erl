%Kevin Kulman
%Elijah Amian
%10/20/22
%Lab 3

-module(lab03).
-import(lists, [map/2, foldl/3, filter/2]).
-compile(export_all).

%Problem 1
myDiv(Value) when (Value == integer) -> fun (Num, Divisor) -> (Num div Divisor) end;
myDiv(Value) when (Value == float)-> fun (Num, Divisor) -> (Num / Divisor) end.

%Problem 2
cuboidVolume(Length, Width) -> 
    fun (Height) -> (Length * Width * Height) end.

%Problem 3
mapReduce(F1, F2, Acc, List) -> 
    MappedList = lists:map(F1, List),
    FoldedList = lists:foldl(F2, Acc, MappedList),
    FoldedList.

flip(N) ->
    -1 * N.
add(X, Sum) -> X + Sum.

%Problem 4
myPartition(Pred, List) -> 
List1 = lists:filter(Pred, List),
List2 = lists:filter(fun (X) -> not Pred(X) end, List),
{List1, List2}.

