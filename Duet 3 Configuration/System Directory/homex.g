if !move.axes[2].homed	        ; If the Z-axis hasn't been homed
	M98 P"/sys/homez.g"	                                            ; home z
T-1 ; Deselect Tool

;G91               ; relative positioning
;G1 H2 Z5 F6000    ; lift Z relative to current position
;;G1 H1 X10 F6000
;G1 H1 X-500 F1800 ; move quickly to X axis endstop and stop there (first pass)
;G1 H2 X5 F6000    ; go back a few mm
;G1 H1 X-500 F360  ; move slowly to X axis endstop once more (second pass)
;;G1 H2 Z-5 F6000   ; lower Z again
;G90               ; absolute positioning

G91                                         ; relative positioning
if sensors.endstops[0].triggered = true     ; if we're hard against the endstop we need to move away
	M564 H0 S0
	G1 X50 F1200
	M564 H1 S1
	M400
	if sensors.endstops[0].triggered = true
		G90
		abort "X Endstop appears to be faulty.  Still in triggered state."
G1 H1 X-355 F6000                            ; move quickly to X axis endstop and stop there (first pass)
if result != 0
	G90
	abort "Print cancelled due error during fast homing"
G1 X5 F6000                                ; go back a few mm
G1 H1 X-355 F360                             ; move slowly to X axis endstop once more (second pass)
if result != 0
	G90
	abort "Print cancelled due to error during slow homing"
G1 X5 F6000                                ; go back a few mm
G90                                         ; absolute positioning