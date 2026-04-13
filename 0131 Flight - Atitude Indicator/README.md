# Attitude Indicator

This is a 3d printed + Ardunio "Attitude Indicator", for use with Microsoft
Flight Simulator 2024, via Mobiflight.

An "Attitude Indicator" in the instrument, centered in the "6 pack", what show
if you've rolled to the left or right, and if you're pointed (slightly) up or
down.

This design is heavily based on [Captain Bob
Sim's](https://github.com/CaptainBobSim/The-Cessna-172-Project-V3/tree/main/Section%202%20-%20Component%20Library%20and%20Structure/2-5%20Instruments/6-PACK_Attitude%20Indicator),
although modified based on the hardware I had on hand and particular design
preferences. In particular:

- the "roll ring" and "pitch arm" are 3d printed in multiple colours (rather
  than applying decals after printing)
- the roll indicator is now an upward facing arrowhead, rather than a pair of
  downward facing match lines
- added an "electronics cage" for the back, to mount the stepper motor driver
  boards
- I'm using round 6x2 magnets for zeroing
- used nut traps in several places, rather than relying on screwing directly
  into the plastic

Modifications and new design was completed using OpenSCAD, using the
[BOLS2](https://github.com/BelfrySCAD/BOSL2/) library.


## (Remaining) To Do

- solder hall sensors
- install hall sensors
- replace electronic cage set up screws with M3x45
- configure zeroing (hall sensor) pins in Mobiflight
- add in lighting
- pin guide for Arduino
- desk mount


## Bill of Materials for Attitude Indicator

Brown filament  
Cyan ("blue") filament  
White filament  
Black filament  
Yellow filament  
Fighter Jet ("navy blue") filament (for front panels)  
Orange filament -- used "recycled" filament for many back/out of sight parts  
PETG filament -- for support interface  
wire, multiple colours -- used 20 AWG, but could be smaller (as small as AWG 26 or 28 might work)

2x 28BYJ-48 Stepper Motor (5V) c/ULN2003 driver boards  
2x hall effects sensors  
1x Ardunio Mega 2560 -- can be used with other instruments  
1x USB-A to USB-B cord -- for Ardunio  
powered USB hub -- can be used for other Ardunios/instruments

8x M2x20 cap head screws -- to attach the faceplate to the main body  
1x M2.5x14 (button head) screw + M2.5 water + M2.5 locking washer -- for rotating arm for up/down arm  
2x M2.5x14 (button head) + M2.5 washer -- mounting roll ring to inner body  
2x M3x8 countersunk screws + M3 nut -- for mounting stepper motors  
2x M3x12 (wafer head) screws + M3 nut -- for stops on up/down  
8x M3x5 wafer head screws -- mounting stepper driver boards
3x M3x50 + 3x M3 nuts -- attaching the electronics cage to the main body (to replace with M3x45)  
4x M3.5x25 + M3.5 nut -- mounting faceplate to body, and attaching to "dashboard"  

1x 2x7 "dupont" connector block + female pins -- back connection (actually used 2x2 + 2x5 blocks)  
2x 1x4 + 1x2 "dupont" connector blocks + female pins -- to driver boards  
1x 2x7 dupont connector block  
2x 6x2 round magnets  
~75mm clear plastic (lexan?) disk  
2x orange (small) mirettes (aka "wing nuts"?)


### Tools Used

3d printer, supporting multicolour/multi-material prints  
crimpers, for du pont connectors -- haven't found the right one yet. Want something that does round crimps  
wire cutters, wire strippers  
screwdrivers  
drill and bits  
breadboard and jumper wires (for initial desktop testing)

Mobiflight


### Anticipated

1x 2x7 + 2x 1x4 + 2x 1x2 du pont connector blocks -- backplate to Arduino  
screws for light access  
LED lighting strip

Mount Arduino to back?  
desk mount for single gauge?
light wiring on base?


### To Buy

2x7 du pont connector housing  
(better) du pont connector crimper -- SN-2, SN-025, TZ-4228B, IWS-3220M, Engineer PA-24, PR-3254, HT-0095 (official, but $2,500), ISW-1442L -- need something with round; ratcheting is nice, but sizing is more important  
M3x45 screws  
M3.5 brass inserts?  
longer USB-A to USB-B cord  
5V power supply?  
M2 tap  
1.5mm hex drive screwdriver  



## Thoughts for "Next" time

Takes a very long time to rework an existing design, but existing designs are
very sensitive to all the pieces you have on hand (even things like screw head
heights).

I would use a single screw if possible, and if not, the same size of hardware.
In particular, the original design was using metric hardware on the back and
imperial hardware for mounting to the dashboard. M3.5 hardware works (for the
dashboard mounting), but is a bit of a pain to find.

I'm generally leary of "screw into plastic" in favour of nut traps. But nut
traps should be accessible from the outside of the assembled unit. I considered
(M3.5) brass "push in" threads, but I don't think there's enough plastic around
the hole to hold it.

Final build uses (physically) drilled out holes into the main body. With more
time, these should be in place in the printed version. The internal cage also
has (vertical, when printing) support brackets that I ultimately cut away (to
allow the stepper motor to be installed).

Would rework how the faceplate is attached to the main body; right now it seems
to rely on being screwed through the "dashboard".

For the back "electronics cage", I would add "corners" to match the main body,
partly for stability, and partly to make it easier/less worrisome to pick up.

For the "electronics cage", add ability to "lock in" the du pont connectors
(rather than just pushing them out the back). Also, consider an arraignment
where they aren't pointing straight out.

Cost to date (including full packages of screws and several other parts, but
not including most tools) is ~USD 150.

For printing, don't do supports for the nut traps in the bottom half of the
main body; I can't get the supports out of the 2 mm holes.