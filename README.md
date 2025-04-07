# DuePrint3
Duet 3 to Stratasys PDB Interface Board. Used to convert a Stratasys Prodigy series printer (Dimension, uPrint, Fortus 250) to use a modern control board & firmware. This conversion is fully reversable (assuming the printer functions to begin with). Many thanks to AJ Quick and Archeantus (Jeremy) for their past efforts in detailing the electronics of the Dimension/uPrint machines, as well as sharing details on their Duet 2 WiFi conversions.
* https://wiki.cnc.xyz/Stratasys_uPrint_Retrofit
* https://forum.duet3d.com/topic/12647/another-stratasys-uprint-retrofit

[Additional details for this project on the Duet3D forums.](https://forum.duet3d.com/topic/37434/dueprint-with-a-duet-3-6hc-stratasys-dimension-conversion)

![DuetPrint3 Block Diagram](https://github.com/user-attachments/assets/d893a41b-7536-4017-afb7-c809d2a8a8e0)

![sIMG_3466](https://github.com/user-attachments/assets/8c3cf30a-84b2-4f6a-b758-526c402385b2)

![DuePrint3 v1 0 0](https://github.com/user-attachments/assets/10ca4358-5615-4864-a5b6-852c5a8fc1fb)

At present, the implementation focuses on the Dimension 1200es printers (the implementations linked above focus on the uPrint series, which is quite similar. The electronics are laid out a touch differently, meaning the layout of the new hardware must change, as well where the stepper motor wiring taps in to the existing harness). The Duet 3 Mainboard 6HC, as well as the Sammy-C21 module (natively running RepRapFirmware) interface with 19 inputs, and 9 outputs.
### Inputs
|Input|Description|GCode|Note|
|---|---|---|---|
|6HC IO_7 io7.in|PRINT HEAD TEMP ALARM|`M950 J9 C"!io7.in" ; Print Head Temp Alarm`|Feature not yet implemented|
|6HC IO_2 io2.in|PRINT BED TOUCH PR LIM SW|`M558 P5 H5 F1200:200 T18000 A3 C"!io2.in" ; Z probe`|Used in bed probing|
|6HC IO_6 io6.in|Z-AXIS EOT|`M574 Z2 S1 P"!io6.in"  ; assign Z EOT to x endstop on high side`|Used as part of homing (find max Z)|
|6HC IO_8 io8.in|CHAMBER TEMP ALARM|`M950 J10 C"!io8.in" ; Chamber Temp Alarm`|Feature not yet implemented|
|6HC IO_4 io4.in|Y-AXIS EOT|`M950 J6 C"!io4.in" ; Y-axis EOT`|Used in macro to measure max Y|
|6HC IO_3 io3.in|X-AXIS EOT|`M950 J5 C"!io3.in" ; X-axis EOT`|Used in macro to measure max X|
|6HC IO_0 io0.in|X-AXIS HOME SW|`M574 X1 S1 P"!io0.in" ; X home limit (low side)`|Used in homing|
|6HC IO_1 io1.in|Y-AXIS HOME SW|`M574 Y1 S1 P"!io1.in" ; Y home limit (low side)`|Used in homing|
|6HC IO_5 io5.in|Z-AXIS HOME SW|`M950 J7 C"!io5.in" ; Z-axis Home`|I/O works, Feature not yet implemented|
|SAMMY-C21 PB08|Filament Detection 2|Not Implemented|Feature not yet implemented|
|SAMMY-C21 PA04|Gecko Error|`M950 J0 C"124.pa04" ; Gecko Error In`|Was used to detect an error on Geckodrive G320x. No longer used|
|SAMMY-C21 PA05|HEAD THERMOSTAT STATUS|`M950 J1 C"124.pa05" ;Head Thermostat Status`|Feature not yet implemented|
|SAMMY-C21 PA06|DOOR SWITCH|`M950 J2 C"124.pa06" ; Door`|I/O works, Feature not yet implemented|
|SAMMY-C21 PA07|SUPPORT TOGGLE SW|`M950 J3 C"124.pa07" ; Support Toggle`|Sense Support toolchange|
|SAMMY-C21 PA12|Filament Detection 1|Not Implemented|Feature not yet implemented|
|SAMMY-C21 PA19|MODEL TOGGLE SW|`M950 J4 C"124.pa19" ; Model Toggle`|Sense Model toolchange|
|6HC TEMP_0 VSSA & temp0|CHAMBER THERM|`M308 S0 A"Chamber Test" P"temp0" Y"linear-analog" F0 B-42 C113`||
|6HC TEMP_1 VSSA & temp1|MODEL THERM|`M308 S1 A"Model Test" P"temp1" Y"linear-analog" F0 B12.5 C328`||
|6HC TEMP_2 VSSA & temp2|SUPPORT THERM|`M308 S2 A"Support Test" P"temp2" Y"linear-analog" F0 B12.5 C328`||

### Outputs
|Output|Description|GCode|Note|
|---|---|---|---|
|6HC OUT_8 V_OUTLC8 & out8|EXTRUDER MODEL HEATER ENA|`M950 H1 C"!out8" T1 ; Model, sensor 1`|
|6HC OUT_9 V_OUTLC9 & out9|SUPPORT HEATER ENA|`M950 H2 C"!out9" T2 ; Support, sensor 2`|
|6HC IO_2 io2.out|LED LIGHTS ENA|`M950 P4 C""io2.out"" ; LED Lights - M42 P4 S1 ; lights on`|
|6HC IO_6 io6.out|DOOR SOLENOID ENA|`M950 P3 C""io6.out"" ; Door Solenoid - M42 P3 S0 ; unlocked`|
|6HC OUT_7 V_OUTLC7 & out7|CHAMBER HEATER ENA|`M950 H0 C"!out7" T0 ; Chamber, sensor 0`||
|6HC OUT_6 V_OUTLC6 & out6|PRINT BED TOUCH PR ENA|`M950 P2 C""!out6"" ; Touch Power Enable` - `M42 P2 S0`|Unsure on purpose? Doesn't seem to function at all/as expected|
|6HC IO_0 io0.out|GECKO RESET|`M950 P5 C""io0.out"" ; Gecko Reset` - `M42 P5 S0`|Was used to reset an error on Geckodrive G320x. No longer used|
|6HC OUT_5 V_OUTLC5 & out5|MOTOR ENA|`M950 P1 C""!out5"" ; Extruder Motor` - `M42 P1 S0 ; motor off`|
|6HC OUT_4 V_OUTLC4 & out4|BLOWER ENA|`M950 P0 C""!out4"" ; Head Blower Fan` - `M42 P0 S0 ; enable blower`|

The 6HC directly drives the X, Y, and Z stepper motors (vs. controlling them through the Stratasys PDB). The 6HC, unlike the Duet2 (and Duex boards) does not natively have STEP/DIR pins used to emit step and direction pulses. Instead, a Sammy-C21 ([running RepRapFirmware](https://docs.duet3d.com/Duet3D_hardware/Duet_3_family/Using_the_Sammy-C21_development_board_with_Duet_3)) is used to emit step and direction pulses to a STM32 Nucelo-64, which in turn is running [SimpleDCMotor](https://github.com/simplefoc/Arduino-FOC-dcmotor) to control the extruder's closed loop DC motor. Note that this design was initially setup to use a Geckodrive G320x, however early into commissioning, I burnt up a few series resistors and a 74AC14 on the PDB. The Nucleo-64 with SimpleDCMotor is a much better solution, with a significantly lower cost.

## Materials
[A detailed BOM can be found here](https://github.com/jcwebber93/DuePrint3/blob/main/DuePrint3%20BOM.xlsx), with the approximate cost being ~$500 (60% of this is Duet3D 6HC and Sammy-C21).

## Interface Board Design
[The KidCad project for the DuePrint3 board can be found here](https://github.com/jcwebber93/DuePrint3/tree/main/DuePrint3%20KiCad%20Project)

## Wiring
[A detailed wire list can be found here.](https://github.com/jcwebber93/DuePrint3/blob/main/DuePrint3%20Wire%20List.xlsx) Connectors & crimps for the Duet 3 6HC are supplied with the board, but are JST VH (stepper motors) and Molex KK / Wurth WR-WTB (Wurth connectors/contacts are supplied with Duet Boards). Interface board uses Molex Micro-3.0 series connectors & crimps, whereas the connectors for the PBD ribbon cables are Samtec EHT headers.

> [!WARNING]
> Do not connect connectors `P13`, `P20`, and `P26` (Model heater, support heater, chamber heater) to the 6HC until after the model, support, and chamber thermocouple functionality has been validated

## Sammy-C21 Prep
If using a Sammy-C21 purchased with the preloaded Duet3D bootloader, no special programming is needed. J100 needs to be unbridged, as 5V is supplied to pins 15 and 32 (V33, for 5V logic, and VCC).

<img src="https://github.com/user-attachments/assets/43eb749a-145f-4268-8572-ef63ae50c817" width="300">

## Interface Board Prep
If the Interface Board (w/Sammy-C21) is the only CAN-FD device, aside from the Duet 3 6HC, place a 2-socket jumper here to enable the CAN-FD termination resistor.

<img src="https://github.com/user-attachments/assets/87da6098-6184-4fa2-a2c0-e8d032940f3f" width="700">

J4 connects to the 6HC. J5 (marking suspiciously missing on silkscreen) can be used with additional expansion boards (such as a Duet 3 SZP on the print head, could be used as an accelerometer or for bed scanning), provided the CAN-FD bus is terminated on the additional board.

## RepRapFirmware Prep
At present, the 6HC and Sammy-C21 are running 3.6.0-rc.1 (April 2025). [Configuration files are located here](https://github.com/jcwebber93/DuePrint3/tree/main/Duet%203%20Configuration/System%20Directory), and [Macros are located here.](https://github.com/jcwebber93/DuePrint3/tree/main/Duet%203%20Configuration/Macros%20Directory)

> [!WARNING]
> Do not connect connectors `P13`, `P20`, and `P26` (Model heater, support heater, chamber heater) to the 6HC until after the model, support, and chamber thermocouple functionality has been validated (a spare K-type thermocouple can be used to validate the linear-analog values in the `M308` commands - ice water and boiling water (for the chamber), boiling water for the extruders)

## SimpleDCMotor / Nucleo-64
TODO - upload sketch. Prep your build enviornment [per the SimpleFOC documentation.](https://docs.simplefoc.com/) I used Ardiono IDE, and [added boards via](https://github.com/stm32duino/Arduino_Core_STM32/wiki/Getting-Started). I bench programmed the Nucleo-64, then prepped it for install in the Stratasys by janging jumper JP5 to set power via E5V instead of U5V (USB).
