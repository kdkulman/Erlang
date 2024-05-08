-module(concurrent).

-compile(export_all).

from_module(X) ->
    io:format("~p~n", [X]),
    42.

listener() ->
    %more code, lots of code!
    receive
        hi -> io:format("Oh, hi!~n");
        hello -> io:format("KENOBI!~n");
        _ -> io:format("Hmmmm~n")
    end.

listener2() ->
    receive
        {From, hi} -> From ! "Oh, hi!";
        {From, hello} -> From ! "KENOBI!";
        _ -> io:format("Hmmmm~n")
    end.

listener3() ->
    receive
        {From, hi} ->
            From ! "Oh, hi!",
            listener3();
        {From, hello} ->
            From ! "KENOBI!",
            listener3();
        stop_me_please ->
            io:format("Shutting down all systems.~n");
        _ ->
            io:format("Thats not expected, try again~n"),
            listener3()
    after 10000 ->
        io:format("Shutting down all systems.~n"),
        stopping_terminus
    end.

terminator(Log) ->
    receive
        stop ->
            Log(["Shutting down all systems."]),
            stopping_terminus;
        Msg ->
            Log(["Message received: ", Msg]),
            terminator(Log)
        % after 15000 ->
        %     Log(["Shutting down all systems."]),
        %     stopping_terminus
    end.

middle(Log, NextPid) ->
    receive
        stop ->
            NextPid ! stop,
            Log(["Shutting down all systems."]);
        Msg ->
            NextPid ! Msg,
            Log(["Message recieved: ", Msg]),
            middle(Log, NextPid)
    end.

middleWare(Log, F, NextPid) ->
    receive
        stop ->
            NextPid ! stop,
            Log(["Shutting down all systems."]);
        Msg when erlang:is_number(Msg) ->
            Log(["Message recieved: ", Msg]),
            Log(["Function applied: ", F(Msg)]),
            NextPid ! F(Msg),
            middleWare(Log, F, NextPid);
        Msg ->
            Log(["Unexpected Value or Type: ", Msg]),
            middleWare(Log, F, NextPid)
    end.

createLogger(Tag) ->
    fun(List) ->
        S = unicode:characters_to_list(smooth_list(List), latin1),
        Tags = unicode:characters_to_list(smooth_list([Tag]), latin1),
        io:format("||~s|| ~s~n", [Tags, S])
    end.

smooth_list([]) -> [];
smooth_list([H | T]) -> [to_list(H) | smooth_list(T)].

to_list(Element) when erlang:is_atom(Element) -> erlang:atom_to_list(Element);
to_list(Element) when erlang:is_pid(Element) -> erlang:pid_to_list(Element);
to_list(Element) when erlang:is_binary(Element) -> erlang:binary_to_list(Element);
to_list(Element) when erlang:is_integer(Element) -> erlang:integer_to_list(Element);
to_list(Element) when erlang:is_float(Element) -> erlang:float_to_list(Element);
to_list(Element) when erlang:is_function(Element) -> erlang:fun_to_list(Element);
to_list(Element) when erlang:is_tuple(Element) -> smooth_list(erlang:tuple_to_list(Element));
% to_list(Element) when erlang:is_list(Element) -> smooth_list(Element);
to_list(Element) -> Element.

go() ->
    End = spawn(concurrent, terminator, [createLogger(the_end)]),
    Mid1 = spawn(concurrent, middle, [createLogger(middle1), End]),
    Mid2 = spawn(concurrent, middle, [createLogger(middle2), Mid1]),
    %
    %
    %
    Mid2.
