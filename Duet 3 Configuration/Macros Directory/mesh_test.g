;M401
;M564 H0 S0
M208 X-163.8 Y-137.5 S1           ;set axis minima
M208 X164.4 Y178.5 S0              ;set axis maxima
;M557 X-190:72 Y-160:0 P3:3
M557 X-134:134 Y-64.5:135.5 P10:10
;G1 X-134 Y-127 F6000
;M400
;echo "at -134, -127"
;G4 S1
G29 S0
echo "finished probing"
G4 S1
M400
echo "move to purge park"
G4 S1
M98 P"/macros/purgepark.g"
M400
;M564 H1 S1
echo "reset axis limits"
G4 S1
M208 X-138.3 Y-137.5 Z-2 S1           ;set axis minima
M208 X160.4 Y178.5 Z325.116 S0              ;set axis maxima
echo "done"
;M402