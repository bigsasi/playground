-module(concurrency).

-export([fun1/1, fun2/2]).
-export([p1/1, p2/2]).
-export([fun2inner/1]).

fun1(N) -> 
  Pid1 = spawn(?MODULE, p1, [N]),
  spawn(?MODULE, p2, [N, Pid1]).

p1(0) ->
  ok;
p1(N) -> 
  receive
    {Pid, Msg} -> 
      io:format("P1 got ~p~n", [Msg]),
      Pid ! {self, N - 1};
    _ -> ok
  end,
  p1(N - 1).

p2(0, _) ->
  ok;
p2(N, Pid) ->
  Pid ! {self(), N - 1},
  receive
    {_, Msg} ->
      io:format("P2 got ~p~n", [Msg]);
    _ -> ok
  end,
  p2(N - 1, Pid).
  

fun2(N, M) ->
  Pids = [spawn(?MODULE, fun2inner, [M]) || _ <- lists:seq(1, N)].

fun2inner(M) -> ok.
