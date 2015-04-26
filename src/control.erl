%%  @author Julian Fenner

-module(control).
-export([loop/0]).

% TO START SYSTEM
% C = spawn(fun control:loop/0). C ! new.

% INSTRUCTIONS
% C ! {convertToCelcius, 45}.
% C ! {convertToFahrenheit, 65}.


loop() ->
	receive
		new ->
			io:format("control creating and supervising converter.~n"),
			register(converter,spawn_link(fun convert:loop/0)),
			converter ! new,
			loop();
		({convertToCelcius, F}) ->
			converter ! {convertToCelcius, F},
			loop();
		({convertToFahrenheit, C}) ->
			converter ! {convertToFahrenheit, C},
			loop();
		_ ->
			io:format("Unexpected message received in control.~n"),
			loop()
	end.