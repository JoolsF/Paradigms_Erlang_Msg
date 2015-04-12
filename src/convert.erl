%% @author Julian Fenner
-module(convert).

%% ====================================================================
%% API functions
%% ====================================================================
-export([loop/0]).

loop() ->
	receive
		new ->
			io:format("converter creating and supervising display.~n"),
			register(display,spawn_link(fun display:loop/0)),
			loop();
		({convertToCelcius, F}) ->
			C = (F-32)*(5/9),
			display ! {temperature, convert_to_list(C), convert_to_list(F)},
			loop();
		({convertToFahrenheit, C}) ->
			F = (C * (9/5) + 32),
			display ! {temperature, convert_to_list(C), convert_to_list(F)},
			loop();
		_ ->
			io:format("Unexpected message received in convert.~n"),
			loop()
	end.

%% ====================================================================
%% Internal functions
%% ====================================================================

% Functions convert result of calculation to list ready for printing in display
% Because of strong dynamic typing type needs to be checked here to apply appropriate to_list function.
% If is_float(number) number is returned to 2 decimal places
convert_to_list(Number)->
	if 
		is_float(Number) -> 
			float_to_list(Number,[{decimals,2}]);
		true -> integer_to_list(Number)
end.