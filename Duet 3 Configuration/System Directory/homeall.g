M98 P"/sys/homez.g"                 ; call homez
M98 P"/sys/homex.g"                 ; call homex
M98 P"/sys/homey.g"                 ; call homey

if sensors.probes[0].value[0] = 0
    M402            ;retract probe

M98 P"/macros/purgepark.g"
;G91               ; relative positioning
;G1 H2 Z5 F6000    ; lift Z relative to current position
;;G1 H1 X10 F6000
;G1 H1 X-500 F1800 ; move quickly to X axis endstop and stop there (first pass)
;G1 H2 X5 F6000    ; go back a few mm
;G1 H1 X-500 F360  ; move slowly to X axis endstop once more (second pass)
;;G1 H2 Z-5 F6000   ; lower Z again
;G90               ; absolute positioning

;G91               ; relative positioning
;;G1 H2 Z5 F6000    ; lift Z relative to current position
;;G1 H2 X30 F1800
;;G1 H1 Y20 F1800
;G1 H1 Y-500 F1800 ; move quickly to Y axis endstop and stop there (first pass)
;G1 H2 Y5 F6000    ; go back a few mm
;G1 H1 Y-500 F360  ; move slowly to Y axis endstop once more (second pass)
;;G1 H2 Z-5 F6000   ; lower Z again
;G90               ; absolute positioning

;G91                ; relative positioning
;;G1 H2 Z5 F6000     ; lift Z relative to current position
;G90                ; absolute positioning
;M564 S0 ; Allow movement beyond printer limits
;G1 X-100 Y178.5 F12000; Move to back of Printer
;G1 X-157.3 F1800; Drop Z-probe
;G1 X0
;M564 S1 ; Limit movements to printer limits

;G1 X-24 Y-73 F12000 ; go to first probe point
;G30                ; home Z by probing the bed

;M564 S0 ; Allow movement beyond printer limits
;G1 X0 Y178.5 F6000 ; Move to back of Printer
;G1 X176.7 F1800; Lift Z-probe
;G1 X166.7 Y 138.5 F6000
;G1 X185.2 F1800 ; Model Filament Select *may need to adjust X position based on tool offset!
;M564 S1 ; Limit movements to printer limits

;G1 X0 Y0 F6000; Center tool head
