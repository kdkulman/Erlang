-module(cooperate).
-author("Anthony archie").
-author("Kevin Kulman").
-compile(export_all).

%Problem 1
producer(_, 0) -> ok;
producer(Pid, N) -> 
    %Generate random numbers
    RandomNumber = rand:uniform(2000),

    %Print random number
    io:format("Producer: ~p ",[RandomNumber]),

    %Print process id
    io:format("~p~n",[self()]),

    %Send random number to the process
    Pid ! RandomNumber,
    %Recursion
    producer(Pid, N-1).

%Problem 2
consumer() ->
    %timer:sleep(10),
    %Print the received numbers along with the process id
    receive
        Num -> io:format("Consumer: ~p", [Num]),
        io:format("~p~n", [self()]),
        consumer()
    end.

