// Structred text programming( Codesys code) for PLC programming
// Obecjt : SET ALARM FOR ANALOGUE SIGNAL AFTER TIMEDELAY IF THE SIGNAL OUT OF RANGE ALARMQ := TRUE

FUNCTION_BLOCK Fb_Alarm_Analogue_Value
VAR_INPUT
	LimitH : REAL; (* Upper limit *)
	AnalogValue : REAL;	(* Value from sensor *)
	LimitL : REAL;	(* Lower limit *)
	AlarmDelay : TIME;	(* Delay prima che Q = TRUE e AnalogValue e fuori di limits range *)
END_VAR
VAR_OUTPUT
	Q : BOOL; (* True si AnalogueValue e fuori di range *)
END_VAR
VAR
	AlarmTimer : TON;
	LimitTemp : REAL; (* salva limit *)
END_VAR
--------------------------------------------------------------------

IF(LimitL > LimitH) THEN
	LimitTemp := LimitL;
	LimitL := LimitH;
	LimitH := LimitTemp;
END_IF;

(* Start timer si AnalogueValue E fuori di limit range *)
IF(AnalogValue < LimitL) OR (AnalogValue > LimitH) THEN
	AlarmTimer(IN:= TRUE, PT:= AlarmDelay);
ELSE
	AlarmTimer(IN:= FALSE);
END_IF
(* Set output value *)
Q := AlarmTimer.Q;

