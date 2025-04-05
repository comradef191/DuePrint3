M950 J5 C"nil"  ; X-axis EOT unassign
M574 X2 S1 P"!io3.in"  ; assign X EOT to x endstop on high side
G1 H4 X165 F1200
M574 X1 S1 P"!io0.in" ;reassign old x home
M950 J5 C"!io3.in"      ; X-axis EOT