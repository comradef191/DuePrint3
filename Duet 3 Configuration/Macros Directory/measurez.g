;M950 J8 C"nil"  ; Z-axis EOT unassign
;M574 Z2 S1 P"!io6.in"  ; assign Z EOT to x endstop on high side
G91
G1 H4 Z329 F1800
G1 Z-5 F1200
G1 H4 Z7 F360
G90
;M574 Z2 S1 P"nil" ;reassign old Z home
;M950 J8 C"!io6.in"      ; Z-axis EOT