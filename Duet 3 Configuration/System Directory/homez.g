;if !move.axes[0].homed || !move.axes[1].homed	        ; If the printer hasn't been homed, home it
;	G28 XY	                                            ; home y and x

G91                ; relative positioning
if sensors.endstops[2].triggered = true     ; if we're hard against the endstop we need to move away
	M564 H0 S0
	G1 Z-20 F1200
	M564 H1 S1
	M400
	if sensors.endstops[2].triggered = true
		G90
		abort "Z Endstop appears to be faulty.  Still in triggered state."
G1 H1 Z335 F1200		;Home to bottom of printer
if result != 0
	G90
	abort "Print cancelled due error during fast homing"
G1 Z-5 F1200
G1 H1 Z7 F360
if result != 0
	G90
	abort "Print cancelled due to error during slow homing"
G90                ; absolute positioning
G1 Z100 F1200		;Go to middleish of chamber

;M564 S0 ; Allow movement beyond printer limits
;G1 X-100 Y178.5 F12000; Move to back of Printer
;G1 X-157.3 F1800; Drop Z-probe
;G1 X-100 F12000
;M564 S1 ; Limit movements to printer limits

;G1 X{sensors.probes[0].offsets[0]} Y{sensors.probes[0].offsets[1]} F12000 ; go to first probe point
;G30                ; home Z by probing the bed

;M564 S0 ; Allow movement beyond printer limits
;G1 Z50 F1200
;G1 X100 Y178.5 F6000 ; Move to back of Printer
;G1 X176.7 F1800; Lift Z-probe
;G1 X166.7 Y 138.5 F12000
;G1 X185.2 F1800 ; Model Filament Select *may need to adjust X position based on tool offset!
;M564 S1 ; Limit movements to printer limits

;G1 X0 Y0 F12000; Center tool head




