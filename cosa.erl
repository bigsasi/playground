-module(cosa).

-export([my_fun/0, my_fun2/0]).

my_fun2() ->
	List = [1, 2, 3, 4],
	f(List).

my_fun() ->
	List = [f1, f2, f3, f4],
	f(List).

f([]) -> undefined;
f([H|T]) -> ?MODULEH, f(T).

f1() -> io:format("f1"), ok.
f2() -> io:format("f2"), ok.
f3() -> io:format("f3"), ok.
f4() -> io:format("f4"), ok.
