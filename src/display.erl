%% @author Julian Fenner
%% @doc @todo Add description to display.


-module(display).
-export([loop/0]).

% TO DO - concat strings into single line
loop() ->
	receive
		({temperature, C, F}) ->
			Cstr = string:concat("The temperature in celcius is ", C),
			Fstr = string:concat("The temperature in fahreheit is ", F),
			io:fwrite("~p~n", [Cstr]),
			io:fwrite("~p~n", [Fstr]),
			loop();
		_ ->
			io:format("Unexpected message received in display.~n"),
			loop()
	end.