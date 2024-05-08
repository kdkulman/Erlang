-module(demo).

-export([double/1, message/1, times/2, greet/2, classify/1, fact/1]).

-import(io,[fwrite/2]).

% I am a comment.

double(N) -> 
        Result = times(N, 2),
	Result.

times(Value, Times) ->
	Value * Times. 

message(N) ->
        % this is a function with side effects
        A = 5.34,
	io:format("here it comes~nhello ~s~n~f~n", [N,A]).
        % may also be: io:fwrite("here it comes~nhello ~w~n~f~n", [N,A]).

% greet(DayType, Name) ->
%         if
%                 DayType == weekday -> "Time to work " ++ Name;
%                 DayType == weekend -> "Time to play " ++ Name;
%                 true -> "Enjoy your retirement " ++ Name
%         end.

greet(weekday, Name) -> "Time to work " ++ Name;
greet(weekend, Name) -> "Time to play " ++ Name;
greet(_, Name) -> "Enjoy your retirement " ++ Name.

% greet(weekday) -> "Time to work ";
% greet(weekend) -> "Time to play ";
% greet(Name) -> "Enjoy your retirement ".


classify(N) when (N > 0) -> positive;
classify(N) when N < 0 -> negative.


fact(0) -> 1;
fact(N) -> N * fact(N - 1).