M950 J6 C"nil"  ; Y-axis EOT unassign
M574 Y2 S1 P"!io4.in"  ; assign Y EOT to x endstop on high side
G1 H4 Y200 F1200
M574 Y1 S1 P"!io1.in" ;reassign old y home
M950 J5 C"!io4.in"      ; y-axis EOT