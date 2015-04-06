%% @author Julian Fenner
%% @doc @todo Add description to control.


%http://www.erlang.org/doc/getting_started/conc_prog.html

-module(control).

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
			io:format("control creating and supervising converter.~n"),
			register(converter,spawn_link(fun convert:loop/0)),
			converter ! new,
			loop();
		{F} ->
			converter ! F,
			loop();
		_ ->
			io:format("Unexpected message received.~n"),
			loop()
	end.



% C = spawn(fun control:loop/0). C ! new.
% erlang:is_process_alive(C)
