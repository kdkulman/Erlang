-module(cooperate2).
-author("Anthony archie").
-author("Kevin Kulman").
-compile(export_all).

producer(_, 0) -> ok;
producer(Pid, N)  ->    
RandomNum = rand:uniform(2000),
io:format("Process:~p Producing:~p~n", [Pid, RandomNum]),
Pid ! RandomNum, 
producer(Pid, N-1).

consumer() ->
    timer:sleep(10),   
    receive
        Num -> 
            io:format("Process:~p Consuming:~p~n", [self(), Num]),
            consumer()
    after 40 ->
        io:format("Shutting down all systems.~n"),
        stopping_terminus
    end.
    
    go() ->
        Cons = spawn(cooperate, consumer, []),
        Prod = spawn(cooperate, producer, [Cons, 4]),
        Prod.


%Problem 5 - Factorial Recursion
tail(0) -> 0;
tail(N) -> tailHelper(N, 1).
tailHelper(0, Answer) -> Answer;
tailHelper(N, Answer) -> tailHelper(N-1, Answer*N).


not_tail(0) -> 1;
not_tail(N) -> N * not_tail(N - 1).


sumList([H | T]) -> H + sumList(T).


%Problem 4
map_filter([H | T], _, _) when (H == []) -> ok;
map_filter([H | T], Pred, Function) when (Pred(H) == true) -> [Function(H) | map_filter(T, Pred, Function)],
map_filter([H | T], Pred, Function) when (Pred(H) == false) -> [H | map_filter(T, Pred, Function)].
    

%Test Predicate 
isOdd(N) when(N rem 2 == 0) -> false;
isOdd(_) -> true.

%Test Function
doubleNum(X) -> X + X.


%L: [1, 2, 3, 4, 5, 6, 7, 8, 9]
%P: is_odd
%F: X + X

mapTest(Function,List) -> 
    lists:map(Function, List).
