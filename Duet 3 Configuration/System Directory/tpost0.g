; notional steps
; change extruder motor direction
; enable extruder
; check for toggle state
; depending on toggle, move to model togle position
; wait for temperature
; move to waste bin
; extrude
; clean
;if (heat.heaters[1].active) > 280
;  M98 P"/macros/purgepark.g"
;M116 P0

;M83     ; relative extruder movement

;M569 P124.0 S0  ; extruder forward
;M42 P1 S1   ; enable extruder
;if (heat.heaters[1].active) > 300
;    G1 E10 F200 ; extrude 30mm
;    G4 S1
;    M98 P"/macros/Wipe.g"
;else
;    G1 X0 Y0 F18000
;G1 R2 X0 Y0 Z2 F18000    ; restore position 2mm above

echo "starting tpost0"
M83     ; relative extruder movement
M569 P124.0 S0  ; extruder forward
M42 P1 S1   ; enable extruder

if (heat.heaters[1].active) > 280
  M98 P"/macros/purgepark.g"
  M116 P0
  if (heat.heaters[1].active) > 300
      G1 E10 F200 ; extrude 10mm
      G4 S1
      M98 P"/macros/Wipe.g"
  else
      G1 X0 Y0 F18000
G1 R2 X0 Y0 Z2 F18000    ; restore position 2mm above
echo "ending tpost0"