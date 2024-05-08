-module(listpractice).
-compile(export_all).


modList([]) -> [];
modList([H | T]) -> 
    NewH = H rem 2,
    [NewH | modList(T)]. 


%Return number of items in a list
numOfListItems([]) -> 0;
numOfListItems([_ | T]) -> 1 + numOfListItems(T).

%Given list L, use lists:map to map all the values in the list to double their value. 
%Assume the list is only numbers. 
%Use an anonymous function at the parameter to the map function.
mapDouble([], _) -> [];
mapDouble(List, Func) -> lists:map(Func, List).