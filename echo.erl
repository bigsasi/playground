-module(echo).

-export([start/0, ping/0, ping/1, pong/1]).

start() -> spawn(?MODULE, pong, [4]).

ping(Pid) ->
  Pid ! {self(), ping},
  receive
    pong -> ok;
    _ -> "I don't understand this guy"
  end.

ping() ->
  Pid = spawn(?MODULE, pong, [4]),
  Pid ! {self(), ping},
  receive
    pong -> ok;
    _ -> "I don't understand this guy"
  end.

pong(0) ->
  receive
    {Pid, _} -> Pid ! jackass;
    _ -> ok
  end;
pong(N) ->
  receive
    {Pid, _} -> Pid ! pong;
    _ -> ok
  end,
  pong(N - 1).
