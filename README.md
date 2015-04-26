# Paradigms_Erlang_Msg

TO START SYSTEM

C = spawn(fun control:loop/0). C ! new.


INSTRUCTIONS

C ! {convertToCelcius, C}.
C ! {convertToFahrenheit, F}.
