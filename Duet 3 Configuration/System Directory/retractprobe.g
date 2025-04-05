if !move.axes[0].homed || !move.axes[1].homed	        ; If the printer hasn't been homed, home it
	G28 XY	                                             ; home X, Y. Z will be homed if its not in X homing script
T-1			; Deselect Tool
echo "retracting probe"
M564 S0 ; Allow movement beyond printer limits
G1 X100 Y178.5 F18000 ; Move to back of Printer
G1 X176.7 F1800; Retract Z-probe
M98 P"/macros/purgepark.g"
M400
if sensors.probes[0].value[0] = 0
	M564 S1 ; Limit movements to printer limits
	abort "Z-Probe appears to be faulty"
M564 S1 ; Limit movements to printer limits
echo "retract complete"