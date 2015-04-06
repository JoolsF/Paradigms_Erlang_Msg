%% @author Julian Fenner
-module(convert).

%% ====================================================================
%% API functions
%% ====================================================================
-export([loop/0]).



%% ====================================================================
%% Internal functions
%% ====================================================================

loop() ->
	receive
		new ->
			io:format("converter creating and supervising display.~n"),
			register(display,spawn_link(fun convert:loop/0)),
			loop();
		{F} ->
			io:format("F " + F + " received"),
			loop();
		_ ->
			io:format("Unexpected message received.~n"),
			loop()
	end.

