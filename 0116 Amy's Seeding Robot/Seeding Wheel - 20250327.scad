// Seeding Wheel for planting robot
//
// Amy Minchin, 2025-03-27 to 03-28

// next: transfer gears to odometer wheels

include <BOSL2/std.scad>
include <BOSL2/gears.scad>
include <BOSL2/screw_drive.scad>
include <BOSL2/threading.scad>
include <BOSL2/screws.scad>

inch = 25.4;  // inch to mm
m3_hardware = 3.5;  // diameter for loose fit
// how much space there is around the pin, from the edge of the pin
// to the edge of the hole, seems enough for it to be just loose
pin_clearance = 0.3; 

// [ Seeding Wheel ]
seeding_circumfrance = 12*inch;
marble_diameter = 9/16*inch;
marble_tolerance = 2;
wheel_outer_border = 12;

center_hole_diameter = m3_hardware;  // for M3 hardware

// including clearances
mounting_hardware_diameter = m3_hardware;  // for M3
// how much smaller than the seeding circumfrance
mounting_hole_inset = 15;
mounting_hole_count = 6;

line_width = 1;
deboss_depth = 1;

// font_face = "B612";
font_face = "Aldo";
font_size = 5;

// placement of measurements on top of seeding wheel
dimension_d_x = marble_diameter / 2 + line_width * 2 + 4;
dimension_d_y = 3;

seeding_radius = seeding_circumfrance / (2 * PI);
seeding_wheel_diameter = (seeding_radius + marble_diameter / 2 + wheel_outer_border) * 2;
measuring_line_length = marble_diameter / 2 + wheel_outer_border + line_width * 3; 
marble_hole_diameter = marble_diameter + marble_tolerance;
marble_exit_hole_diameter = marble_diameter + 2 * marble_tolerance;
seeding_wheel_height = marble_hole_diameter;

// [ Odometer Wheels ]
odometer_wheel_diameter = 33.5;
odometer_wheel_thickness =  6.6;
odometer_wheel_shaft_diameter = 3.0;
odometer_wheel_shaft_length = 8.7;
// odometer_wheel_shaft_d_height = 2.26;
odometer_wheel_shaft_d_height = 2.45;
odometer_wheel_hub_diameter = 8.0;
odometer_wheel_hub_thickness = 8.7;
odometer_wheel_hub_slot_width = 1.0;

// [ Seeding Gears ]
// tooth width. circular pitch = PI*d/teeth
circular_pitch = 1/4 * inch;
// circular_pitch = 1/16 * inch;
seeding_gear_diameter = seeding_radius * 2;
seeding_gear_thickness = 5;
// inside clear diameter
seeding_gear_shaft_diameter = seeding_radius * 2 - 38;
// industry standard is 20 degrees
pressure_angle = 20; 


seeding_gear_teeth = floor(PI * seeding_gear_diameter / circular_pitch);

// echo("seeding_gear_teeth", seeding_gear_teeth);

// [ Transfer Gears ]
transfer_spur_gear_diameter = odometer_wheel_diameter;
transfer_spur_gear_teeth = floor(PI * transfer_spur_gear_diameter / circular_pitch);
transfer_spur_gear_thickness = seeding_gear_thickness;
transfer_spur_gear_shaft_diameter = m3_hardware;

// gear diameter must be less than the odometer wheel
transfer_bevel_gear_diameter = 25;
transfer_bevel_gear_teeth = floor(PI * transfer_bevel_gear_diameter / circular_pitch);
transfer_bevel_gear_thickness = seeding_gear_thickness;

// [ Track Plate ]
track_plate_height = 3;
track_plate_flange = 3;
track_plate_min_height = 1;

upper_track_width = 1;
upper_track_height = 3;
upper_track_xy_tolerance = 0.8;
upper_track_z_tolerance = 0.4;

exit_pipe_length = 50;
exit_pipe_wall_thickness = 1.5;

exit_pipe_curve_radius = 1*inch;

track_plate_inner_diameter = seeding_radius - 1/2 * marble_hole_diameter - track_plate_flange;
track_plate_outer_diameter = seeding_radius + 1/2 * marble_hole_diameter + track_plate_flange;

exit_pipe_inner_diameter = marble_diameter + 4 * marble_tolerance;
exit_pipe_outer_diameter = exit_pipe_inner_diameter + 2 * exit_pipe_wall_thickness;

exit_pipe_mounting_screw_count = 3;

// [ Frame ]
pin_head_height = 2.5;  // to match M2.5 socket head screws
frame_thickness = 1/4 * inch;  // 6.35mm
frame_rotating_clearance = 1;
pin_tail_length = 3.0;
m25_thread_pitch = 0.45;  // coarse pitch

// M2.5 hardware has a 2.0mm hex drive
// https://ca.store.bambulab.com/products/m2-5-socket-head-cap-machine-screws-shcs
pin_k_25 = 2.0;
// https://ca.store.bambulab.com/products/m3-socket-head-cap-machine-screws-shcs
pin_k_3 = 2.0;
m3_wafer_head_diameter = 6.9;
m3_wafer_head_thickness = 0.76;


// [ Motor ]
// including the front plate, but not the back contracts
motor_length = 24.0;
motor_width = 12.0;
motor_height = 10.0;
motor_box_clearance = 0.5;
motor_box_thickness = 1.0;

// [ Marble Tank ]
marble_tank_thickness = 3;

// [ Arduino Standoffs ]
arduino_standoffs_height = 3;
arduino_standoffs_thickness = 1;

// [ Drafting Lines ]

// front of robot
//_x01 = 0;
// center of trackplate drop hole
// front support for seeding wheel
_x02 = seeding_radius - frame_thickness;
// centerline of odometer wheel
_x03 = 0;
// rear support bar for seeding wheel
_x04 = -seeding_radius;
// rear motor wheels centerline
_x07 = _x03 - 150;
// trailing wheels centerline, may be in front of _x05
_x06 = _x07 + odometer_wheel_diameter * 1.5;
// support bar for Arduino Uno
_x05 = _x07 - 50.8;


// centerline of seeding wheel
_y05 = 0;
// centerline of left spur/bevel gear
_y06 = seeding_gear_diameter / 2 + odometer_wheel_diameter / 2 - 0.8;
// inside of left transfer bevel gear
_y07 = _y06 + transfer_bevel_gear_diameter / 2;
// inside of left odometer wheel
_y08 = _y07 + frame_thickness + frame_rotating_clearance;

// centerline of second spur gear
_y04 = -1 * (seeding_gear_diameter / 2 + odometer_wheel_diameter / 2 - 0.8);
// centerline of right spur/bevel gears
_y03 = _y04 - odometer_wheel_diameter;
// inside of right transfer bevel gear
_y02 = _y03 - transfer_bevel_gear_diameter / 2;
// inside of right (sitting in the driver's seat) odometer wheel
_y01 = _y02 - frame_thickness - frame_rotating_clearance;


// seeding wheel bottom
_z02 = track_plate_height + upper_track_z_tolerance;
// seeding wheel top
_z01 = _z02 + seeding_wheel_height;
// track plate bottom
_z05 = 0;
// top of seeding gear
_z07 = -35;
// top of (main) frame
_z08 = _z07 - transfer_bevel_gear_thickness * 2 - frame_rotating_clearance;
// top of horizontal bevel gear
_z11 = _z07 - seeding_gear_thickness - frame_thickness - 3 * frame_rotating_clearance;
// centerline of wheels
_z12 = _z11 - transfer_bevel_gear_diameter / 2;
// bottom of frame
_z13 = _z12 - odometer_wheel_diameter / 6;

echo(
    "_z01", _z01,
    "_z02", _z02,
    "_z05", _z05,
    "_z07", _z07,
    "_z08", _z08,
    "_z11", _z11,
    "_z12", _z12,
    "_z13", _z13
);


$fn=90;

echo ("hello world !!!");

// assembly_view(exploded = 0);

seeding_wheel();
// track_plate();
// upper_frame_2();
// translate([0, 0, _z08])
// upper_frame ();
// frame();
// translate([-marble_diameter * 11 + marble_tolerance * 11 - seeding_wheel_diameter / 2, 0, 44])
// marble_tank();
// arduino_standoffs();
// exit_tube();

// translate([0, 0, 25 - 10])
// rotate([0, 0, 270])
// pin_wheel();

// color("Gold")
// #transfer_bevel_gear();

// pin_wheel();

track_plate();

// transfer_spur_gear();

module seeding_wheel() {
    _serial = "0116-01B";

    difference() {
        translate([0, 0, 0])
        cylinder(h = seeding_wheel_height, d = seeding_wheel_diameter);

        // hole for the marble to drop in and be carried around in
        translate([seeding_radius, 0, -0.01])
        cylinder(h = seeding_wheel_height + 0.02, d = marble_hole_diameter);

        // center hole (for rotating)
        translate([0, 0, -0.01])
        cylinder(h = seeding_wheel_height + 0.02, d = center_hole_diameter);

        // seeding ring
        translate([0, 0, seeding_wheel_height - deboss_depth])
        difference() {
            cylinder(h = deboss_depth + 0.01, r = seeding_radius + line_width/2);

            cylinder(h = deboss_depth + 0.01, r = seeding_radius - line_width/2);
        }

        // mounting holes
        _seeding_wheel_mounting_holes();

        // inch measures
        _labels = ["12\"", "1\"", "2\"", "3\"", "4\"", "5\"", "6\"", "7\"", "8\"", "9\"", "10\"", "11\""];
        for (i = [0 : len(_labels) - 1]){
            rotate([0,0,30 * i])
            translate([seeding_wheel_diameter / 2 - measuring_line_length, -line_width / 2, seeding_wheel_height - deboss_depth]) {
            cube([measuring_line_length, line_width, deboss_depth + 0.01]);

            translate([dimension_d_x, dimension_d_y, 0])
            rotate([0,0,0])
            linear_extrude(deboss_depth + 0.01)
            text(
                _labels[i],
                size = font_size,
                font = font_face,
                halign = "left",
                valign = "baseline"
            );
            }
        }


        // tracks to match track plate
        translate([0, 0, -0.01]) {
            // outer track
            difference() {
                cylinder (
                    h = upper_track_height + upper_track_z_tolerance,
                    r = track_plate_outer_diameter + 1/2 * upper_track_xy_tolerance
                );

                translate ([0, 0, -0.01])
                cylinder (
                    h = upper_track_height + upper_track_z_tolerance + 0.02,
                    r = track_plate_outer_diameter - upper_track_width - 1/2 * upper_track_xy_tolerance
                );
            }

            // inner track
            difference() {
                cylinder (
                    h = upper_track_height + upper_track_z_tolerance,
                    r = track_plate_inner_diameter + upper_track_width + 1/2 * upper_track_xy_tolerance
                );

                translate ([0, 0, -0.01])
                cylinder (
                    h = upper_track_height + upper_track_z_tolerance + 0.02,
                    r = track_plate_inner_diameter - 1/2 * upper_track_xy_tolerance
                );
            }
        }

        // serial
        translate([
            seeding_radius - mounting_hole_inset + 5,
            0,
            seeding_wheel_height - deboss_depth
        ])
        rotate([0, 0 ,90])
        linear_extrude(deboss_depth + 0.01)
        text(
            _serial,
            size = font_size,
            font = font_face,
            halign = "center",
            valign = "baseline"
        );
    }
}

module seeding_gear() {
    _serial = "0116-02A";

    difference() {
        spur_gear(
            circular_pitch,
            seeding_gear_teeth,
            seeding_gear_thickness,
            pressure_angle = pressure_angle,
            shaft_diam = seeding_gear_shaft_diameter
        );

        // mounting holes
        _seeding_wheel_mounting_holes();

        // serial
        translate([
            seeding_radius - 9,
            0,
            seeding_gear_thickness / 2 - deboss_depth
        ])
        rotate([0, 0 ,90])
        linear_extrude(deboss_depth + 0.01)
        text(
            _serial,
            size = font_size,
            font = font_face,
            halign = "center",
            valign = "baseline"
        );
    }
}

module _seeding_wheel_mounting_holes() {
    // for seeding wheel and gear, to connect the two together with screws
    translate([0, 0, -0.01])
    for (i = [0 : mounting_hole_count]){
        rotate([0, 0, (i + 0.5) * 360 / mounting_hole_count])
        translate([seeding_radius - mounting_hole_inset, 0, 0]) {
            cylinder(h = seeding_wheel_height + 0.02, d = mounting_hardware_diameter);

            // depression for screw heads
            translate([0, 0, 5])
            cylinder(h = seeding_wheel_height + 0.02, d = m3_wafer_head_diameter + 0.4);
        }

    }
}

module _exit_tube_mounting_holes() {
    // assumed M3 hardware

    module _a_hole() {
        cylinder(d = 3 + 0.2, h = 10);

        cylinder(d = m3_wafer_head_diameter + 0.3, h = m3_wafer_head_thickness + 0.2);

        // clear access path
        translate([0, 0, -10])
        cylinder(d = m3_wafer_head_diameter + 0.3, h = 10);
    }

    _angles = [72, 124, 302];

    for (i = [0 : len(_angles) - 1]) {
        rotate([0, 0, _angles[i]])
        translate([(exit_pipe_outer_diameter + 4) / 2, 0, 0])
        _a_hole();
    }
}

module exit_tube() {
    _serial = "0116-08A";

    // TO-DO: add serial

    // drop curve
    translate([seeding_radius, 0, 0])
    rotate([90, 180, 0])
    translate([-exit_pipe_curve_radius, 0, 0])
    rotate_extrude(angle=45)
    translate([exit_pipe_curve_radius, 0, 0])
    difference(){
        circle(d = exit_pipe_outer_diameter);
        circle(d = exit_pipe_inner_diameter);
    }

    translate([seeding_radius + 7.5, 0, -18.0])
    rotate([90, 45, 0])
    translate([0, -exit_pipe_curve_radius, 0])
    rotate_extrude(angle=45, start=45)
    translate([exit_pipe_curve_radius, 0, 0])
    difference(){
        circle(d = exit_pipe_outer_diameter);
        circle(d = exit_pipe_inner_diameter);
    }
    //plate to connect it to the track plate
    difference() {
        color("red")
            translate([exit_pipe_outer_diameter + 7, -exit_pipe_outer_diameter / 1.4, 0])
            cube([
                exit_pipe_outer_diameter * 1.2, 
                exit_pipe_outer_diameter * 1.4,
                1
            ]);

    //the holes for in the plate
    //didn't have time to proprely orient them, and we need the center hole
            // translate([exit_pipe_outer_diameter * 2, 0, 0])
            // #_exit_tube_mounting_holes();

    }
}

module track_plate() {
    // TO-DO: mounting to frame (so that it doesn't move)
    // TO-DO: separate exit tunnel from track plate so that it screws together
    //          (easier printing)

    _serial = "0116-03B";

    difference() {
        union() {
            // basic plate
            difference() {
                union() {
                    cylinder (
                        h = track_plate_height,
                        r = track_plate_outer_diameter
                    );

                    // bump out for extra support around exit tube mounting and frame
                    // mounts
                    _bump_angles = [
                        12.5,
                        38,
                        65,
                        115,
                        141,
                        218,
                        232,
                        308,
                        322
                    ];
                    for (i = [0: len(_bump_angles) -  1])
                    rotate([0, 0, _bump_angles[i]])
                    translate([track_plate_outer_diameter - 2, 0, 0])
                    cylinder(h = track_plate_height, d = m3_wafer_head_diameter * 1.25);
                }

                // center hole
                translate ([0, 0, -0.01])
                cylinder (
                    h = track_plate_height + 0.02,
                    r = track_plate_inner_diameter
                );

                // marble path
                translate([0, 0, marble_hole_diameter/2 + track_plate_min_height])
                rotate_extrude(convexity = 10)
                    translate([seeding_radius, 0, 0])
                        circle(d = marble_hole_diameter, $fn = 100);

                // hole for the marble to drop out
                translate([seeding_radius, 0, -0.01])
                cylinder(h = track_plate_height + 0.02, d = marble_exit_hole_diameter);

                // serial
                rotate([0, 0, 45])
                translate([
                    seeding_radius,
                    0,
                    deboss_depth,
                ])
                rotate([180, 0, 90])
                linear_extrude(deboss_depth + 0.01)
                text(
                    _serial,
                    size = font_size,
                    font = font_face,
                    halign = "center",
                    valign = "baseline"
                );
            }

            // marble stop
            difference() {
                translate([seeding_radius - 1/2 * marble_hole_diameter - 2, -marble_hole_diameter - 1, 0])
                cube([marble_hole_diameter + 2, marble_hole_diameter + 1, track_plate_height]);

                // hole for the marble to drop out
                translate([seeding_radius, 0, -0.01])
                cylinder(h = track_plate_height + 0.02, d = marble_exit_hole_diameter);
            }

            // mating tracks for seeding wheel
            translate([0, 0, track_plate_height]) {
                // outer track
                difference() {
                    cylinder (
                        h = upper_track_height,
                        r = track_plate_outer_diameter
                    );

                    translate ([0, 0, -0.01])
                    cylinder (
                        h = upper_track_height + 0.02,
                        r = track_plate_outer_diameter - upper_track_width
                    );
                }

                // inner track
                difference() {
                    cylinder (
                        h = upper_track_height,
                        r = track_plate_inner_diameter + upper_track_width
                    );

                    translate ([0, 0, -0.01])
                    cylinder (
                        h = upper_track_height + 0.02,
                        r = track_plate_inner_diameter
                    );
                }
            }
        }

        // exit tube mounting holes
        translate([seeding_radius, 0, track_plate_height + 0.01])
        rotate([180, 0, 0])
        _exit_tube_mounting_holes();

        // frame mounting holes
        translate([0, 0, track_plate_height + 0.01])
        _track_plate_to_frame_holes();
    }
}

module transfer_spur_gear() {
    //for all the other gears (cause they have to be the same size) 

    _serial = "0116-04C";

    difference() {
        spur_gear(
            circular_pitch,
            transfer_spur_gear_teeth,
            transfer_spur_gear_thickness,
            pressure_angle = pressure_angle
            // shaft_diam = transfer_spur_gear_shaft_diameter
        );

        // shaft
        translate([0, 0, -transfer_spur_gear_thickness])
        _d_shaft(shaft_length = transfer_spur_gear_thickness * 2, clearance = -0.2);

        // serial
        translate([
            font_size * 1.4,
            0,
            transfer_spur_gear_thickness / 2 - deboss_depth
        ])
        rotate([0, 0, 90])
        linear_extrude(deboss_depth + 0.01)
        text(
            _serial,
            size = font_size,
            font = font_face,
            halign = "center",
            valign = "baseline"
        );
    }
}

module odometer_wheel() {
    // origin is inside side of wheel (0, 0 is the inside, not vice versa)
    // this is a non-printed part; here only for the exploded view

    translate([0, 0, -odometer_wheel_hub_thickness])
    difference() {
        translate ([0, 0, 0])
        union() {
            cylinder(h = odometer_wheel_thickness, d = odometer_wheel_diameter);
            cylinder(h = odometer_wheel_hub_thickness, d = odometer_wheel_hub_diameter);
        }
        
        translate([0, 0, -0.01])
        _d_shaft(shaft_length = odometer_wheel_hub_thickness + 0.02, clearance = 0);
    }
}

module transfer_bevel_gear() {
    // one set is going to be underneath the spur gears and connected to the 2nd set connected to the wheels

    _serial_1 = "0116";
    _serial_2 = "-5C";

    difference(){
        bevel_gear(
            teeth = transfer_bevel_gear_teeth,
            mate_teeth = transfer_bevel_gear_teeth,
            shaft_angle = 90,
            spiral = 0,  // zero angle gives a zerol teeth
            circ_pitch = circular_pitch,  // doesn't have to match other spur gears
            thickness = transfer_bevel_gear_thickness
            // shaft_diam = m3_hardware
        );

        // shaft
        translate([0, 0, -transfer_spur_gear_thickness])
        _d_shaft(shaft_length = transfer_spur_gear_thickness * 2, clearance = -0.2);

        // serial
        translate([
            2.5,
            0,
            -transfer_bevel_gear_thickness / 2 + deboss_depth
        ])
        rotate([180, 0, 90])
        linear_extrude(deboss_depth + 0.01) {
            text(
                _serial_1,
                size = font_size,
                font = font_face,
                halign = "center",
                valign = "baseline"
            );
            translate([0, -2.5 - font_size * 1.4, 0])
            text(
                _serial_2,
                size = font_size,
                font = font_face,
                halign = "center",
                valign = "baseline"
            );
        }

        translate([
            -2,
            -0.5,
            transfer_bevel_gear_thickness / 2 - deboss_depth * 0.6
        ])
        rotate([0, 0, 90])
        linear_extrude(deboss_depth + 0.01)
        text(
            _serial_2,
            size = font_size * 0.8,
            font = font_face,
            halign = "center",
            valign = "baseline"
        );
    }
}

module _d_shaft(shaft_length, clearance = 0) {
    // it is our hole in the transfer gears and the (pre-made) wheels, so that
    // they spin together. This is cut from the gears, but a different model is
    // used to create the pins that tie everything together.
    //
    // shaft_length: how tall the shaft (hole/pin) is
    // clearance: how much is removed from the edges of the hole for the pin so
    //            that it fits nicely
    //
    // if in need of example (demo) (pink is pin, yellow is hole):
    //
    //    color("pink")
    //    _d_shaft(10, 0.3);
    //    _d_shaft(9);
    //
    // Test with pin:
    //
    //    color("pink")
    //    translate([0, 0, 15])
    //    rotate([0, 0, 270])
    //    pin_wheel();
    //
    //    _d_shaft(9, clearance = -0.2);

    difference() {
        cylinder(h = shaft_length, d = odometer_wheel_shaft_diameter - clearance);

        // translate x clearance:
        //      A & B have /2, C has /4
        translate([
            -odometer_wheel_shaft_diameter / 2 + odometer_wheel_shaft_d_height - clearance / 4,
            -odometer_wheel_shaft_diameter / 2,
            -0.01
        ])
        cube([
            odometer_wheel_shaft_diameter,
            odometer_wheel_shaft_diameter,
            shaft_length + 0.05
        ]);
    }
}

module _pin_shaft(shank_length, shaft_length) {
    // base model for making all pins
    // D-shaft to allow gears to turn together

    // stopped after K. I think the manufacturing tolerances (on a 0.4mm
    // nozzle) just aren't there to get any better

    _dia = 3;  // screw_shaft_diameter
    _length = 25;

    difference() {
        union() {
            screw(
                spec = "M3",
                head = "socket",
                drive = "hex",
                length = shaft_length,
                anchor = "head_bot"
            );

            rotate([180, 0, 0])
            // for diameter:
            //      F is -0.1, G is -0.05 (and too tight), H & J is -0.075,
            //      I (too tight) & K is -0.0625
            cylinder(d = _dia - 0.0625, h = shank_length);
        }

        // for y-translate:
        //          H & K is 0, I & J is +0.1 (too tight at shank)
        translate([
            -_dia / 2,
            -_dia / 2 + odometer_wheel_shaft_d_height + 0 - 0 * pin_clearance,
            -_length - 10,
        ])
        cube([
            _dia ,
            _dia ,
            _length + 10
        ]);
    }
}

module pin_wheel() {
    // to attach the odometer wheel to the bevel transfer gear
    _serial = "0116-06K";

    _shank_length = (
        odometer_wheel_hub_thickness
        + frame_rotating_clearance
        + frame_thickness
        + frame_rotating_clearance
        + transfer_bevel_gear_thickness
    );
    _shaft_length = (
        0
        // + pin_head_height
        + _shank_length
        + frame_rotating_clearance
        + pin_tail_length
    );
    echo("screw length", _shaft_length);

    _pin_shaft(shank_length=_shank_length, shaft_length=_shaft_length);
}

module pin_wheel_only() {
    // to attach the odometer wheel to the bevel transfer gear
    _serial = "0116-10H";

    _shank_length = (
        odometer_wheel_hub_thickness
        + frame_rotating_clearance
        + frame_thickness
    );
    _shaft_length = (
        0
        // + pin_head_height
        + _shank_length
        + frame_rotating_clearance
        + pin_tail_length
    );
    echo("screw length", _shaft_length);

    _pin_shaft(shank_length=_shank_length, shaft_length=_shaft_length);
}

module pin_spur_bevel() {
    // to attach the transfer spur gear to the transfer bevel gear underneath
    _serial = "0116-08A";

    _shank_length = (
        transfer_spur_gear_thickness
        + frame_rotating_clearance
        + frame_thickness
        + frame_rotating_clearance
        + transfer_bevel_gear_thickness
    );
    _shaft_length = (
        0
        // + pin_head_height
        + _shank_length
        + frame_rotating_clearance
        + pin_tail_length
    );
    echo("screw length", _shaft_length);

    _pin_shaft(shank_length=_shank_length, shaft_length=_shaft_length);
}

module pin_spur() {
    // to attach the transfer spur gear to the frame
    _serial = "0116-09A";

    _shank_length = (
        transfer_spur_gear_thickness
        + frame_rotating_clearance
        + frame_thickness
    );
    _shaft_length = (
        0
        // + pin_head_height
        + _shank_length
        + frame_rotating_clearance
        + pin_tail_length
    );
    echo("screw length", _shaft_length);

    _pin_shaft(shank_length=_shank_length, shaft_length=_shaft_length);
}

module _frame_wheel_support(frame_wheel_drop) {
    difference() {
        translate([-frame_thickness / 2, -frame_thickness, -frame_wheel_drop])
        cube([frame_thickness, frame_thickness, frame_wheel_drop]);

        translate([0, -0.01 + -frame_thickness, -frame_wheel_drop / 2])
        rotate([270, 0, 0])
        cylinder(d =  m3_hardware, h = frame_thickness + 0.02);
    }
}

module _motor_box() {
    _sides_extra = motor_box_thickness * 2 + motor_box_clearance;

    translate([
        -(motor_width + _sides_extra) / 2,
        0,
        -(motor_width + _sides_extra) / 2,
    ])
    difference() {
        cube([
            motor_width + _sides_extra,
            motor_length + motor_box_clearance,
            motor_height + _sides_extra
        ]);

        translate([motor_box_thickness, -0.01, motor_box_thickness])
        cube([
            motor_width + motor_box_clearance,
            motor_length + motor_box_clearance + 0.02,
            motor_height + motor_box_clearance
        ]);
    }
}

module _arduino_uno_holes(length, diameter=3.0) {
    // https://cdn-shop.adafruit.com/datasheets/arduino_hole_dimensions.pdf

    translate([0, 0, 0])
    cylinder(d = diameter, h = length);

    translate([1.3, 48.2, 0])
    cylinder(d = diameter, h = length);

    translate([52.1, 33.0, 0])
    cylinder(d = diameter, h = length);

    translate([52.1, 5.1, 0])
    cylinder(d = diameter, h = length);
}

module frame() {
    // TO-DO: cut hole to drop marble??
    // TO-DO: add hook (eye-hook?) for pulling
    // TO-DO: Add Amy's name and date
    _serial = "0116-07A";
    frame_width = _y08 - _y01;
    _frame_wheel_drop = _z11 -_z13;

    // front of frame
    translate([0, _y01, 0]) {
        difference() {
            translate([-frame_thickness / 2, 0, 0])
            cube([frame_thickness, frame_width, frame_thickness]);

            translate([0, _y05 - _y01, -0.01])
            cylinder(d =  m3_hardware, h = frame_thickness + 0.02);

            translate([0, _y04 - _y01, -0.01])
            cylinder(d =  m3_hardware, h = frame_thickness + 0.02);

            translate([0, _y03 - _y01, -0.01])
            cylinder(d =  m3_hardware, h = frame_thickness + 0.02);

            translate([0, _y06 - _y01, -0.01])
            cylinder(d =  m3_hardware, h = frame_thickness + 0.02);

        }

        // front wheel supports
        translate([0, frame_thickness, 0])
        _frame_wheel_support(_frame_wheel_drop);

        translate([0, frame_width, 0])
        _frame_wheel_support(_frame_wheel_drop);
    }

    // rear support for seeding wheel
    translate([_x04, _y01, 0])
    difference() {
        cube([frame_thickness, frame_width, frame_thickness]);

        translate([frame_thickness / 2, frame_thickness * 2, -0.01])
        cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);

        translate([frame_thickness / 2, frame_width - frame_thickness * 2, -0.01])
        cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);
    }

    // front support for seeding wheel
    translate([_x02, _y01, 0])
    difference() {
        cube([frame_thickness, frame_width, frame_thickness]);

        translate([frame_thickness / 2, frame_thickness * 2, -0.01])
        cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);

        translate([frame_thickness / 2, frame_width - frame_thickness * 2, -0.01])
        cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);

        // serial label
        translate([frame_thickness / 2, frame_thickness * 5, frame_thickness - deboss_depth])
        rotate([0, 0, 90])
        linear_extrude(deboss_depth + 0.01)
        text(
            _serial,
            size = font_size,
            font = font_face,
            halign = "left",
            valign = "center",
        );
    }

    // back of frame
    frame_back_length = _x02 - _x07;
    y_back_offsets = [
        _y08 - frame_thickness,
        // _y05 - frame_thickness * 3/2,
        mean([_y08, _y01]),  // centerline
        _y01
    ];

    translate([-frame_back_length + _x02, 0, 0]) {
        // longitudinal support bars (front to back; full length)
        for (i = [0 : len(y_back_offsets) - 1]) {
            translate([frame_thickness / 2 - 0.01, y_back_offsets[i], 0])
            cube([frame_back_length - frame_thickness / 2, frame_thickness, frame_thickness]);
        }

        // back cross bar
        difference() {
            union() {
                translate([-frame_thickness / 2, _y01, 0])
                cube([frame_thickness, frame_width, frame_thickness]);

                // Arduino support bar
                translate([-frame_thickness / 2 + 52.1 - 2, _y01, 0])
                cube([frame_thickness * 1.5, frame_width, frame_thickness]);

            }

            // Arduino screw holes
            rotate([0, 180, 0])
            translate([-52.1, -80, -10])
            _arduino_uno_holes(length = frame_thickness * 2, diameter = 3.0 - 0.1);

            // Arduino label
            translate([0, -35, frame_thickness - deboss_depth])
            rotate([0, 0, 90])
            linear_extrude(deboss_depth + 0.01)
            text(
                "<-- as per client requirements -->",
                size = font_size,
                font = font_face,
                halign = "left",
                valign = "center",
            );
        }

        // wheel supports
        translate([_x06 - _x07, 0, 0]) {
            translate([0, _y08, 0])
            _frame_wheel_support(_frame_wheel_drop);

            translate([0, _y01 + frame_thickness, 0])
            _frame_wheel_support(_frame_wheel_drop);
        }

        // motor box
        translate([0, _y08, 0]) {
            _frame_wheel_support(_frame_wheel_drop);
            translate([0, -frame_thickness - motor_length - motor_box_clearance, -_frame_wheel_drop/2])
            _motor_box();

            translate([
                -frame_thickness / 2,
                -1 * (motor_length + motor_box_clearance + frame_thickness),
                -frame_thickness + 1.8
            ])
            cube([frame_thickness, motor_length + motor_box_clearance, frame_thickness]);

        }
        
        // motor box
        translate([0, _y01 + frame_thickness, 0]) {
            _frame_wheel_support(_frame_wheel_drop);

            translate([0, 0, -_frame_wheel_drop/2])
            _motor_box();

            translate([
                -frame_thickness / 2,
                0,
                -frame_thickness + 1.8
            ])
            cube([frame_thickness, motor_length + motor_box_clearance, frame_thickness]);
        }

        translate([0, motor_length * 2.2 + motor_box_clearance * 2, 0])
        rotate([0, 34, 0])
        cube([frame_thickness * 1.3, motor_length + motor_box_clearance, 1]);

        translate([0, -motor_length * 4.6 - motor_box_clearance * 2, 0])
        rotate([0, 34, 0])
        cube([frame_thickness * 1.3, motor_length + motor_box_clearance, 1]);
    }
}

module arduino_standoffs() {
color("orchid")
    difference() {
    translate([0, 0, 10])
    cylinder(d = m3_hardware + 0.2 + arduino_standoffs_thickness, h = arduino_standoffs_height);

    translate([0, 0, 9.99])
    #cylinder(d = 3.2, h = arduino_standoffs_height + 0.02);

    }
}

module upper_frame() {
    // TO-DO:
    _serial = "0116-11A";
    frame_width = _y08 - _y01;
    frame_height = _z05 - _z08 - frame_thickness * 2;
    
    _support_x = [_x02, _x04];
    _support_y = [_y01, _y08 - frame_thickness];

        // rear support for seeding wheel
    
    translate([_x04, _y01, _z05])
    difference() {
        cube([frame_thickness, frame_width, frame_thickness]);

        // track plate mounting holes
        translate([-_x04, -_y01, 10])
        _track_plate_to_frame_holes();

        // 

        translate([
            frame_thickness * 3 - seeding_wheel_diameter / 8.5,
            frame_thickness * 2,
            -0.01
        ])
        cylinder(d = m3_hardware + 0.2, h = frame_thickness * 2);

        translate([
            frame_thickness * 3 - seeding_wheel_diameter / 8.5,
            -_y01 + _y08 - frame_thickness - frame_thickness * 1,
            -0.01
        ])
        cylinder(d = m3_hardware + 0.2, h = frame_thickness * 2);

//these ones were extra/duplicates
         // connection holes to upper frame 2
            // translate([
            //     _support_x[0] + frame_thickness / 2,
            //     _support_y[0] + frame_thickness * 2,
            //     -frame_height - 0.01 + _z05 - _z08 - frame_thickness * 2
            // ])
            // cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);

            // translate([
            //     _support_x[1] + frame_thickness / 2,
            //     _support_y[1] - frame_thickness * 1,
            //     -frame_height - 0.01 + _z05 - _z08 - frame_thickness * 2
            // ])
            // cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);


            //connection holes to upper frame 2
            // translate([
            //     _support_x[i] + frame_thickness / 2,
            //     _support_y[0] + frame_thickness * 6,
            //     -frame_height - 0.01 + _z05 - _z08 - frame_thickness * 2
            // ])
            // #cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);

            // translate([
            //     _support_x[i] + frame_thickness / 2,
            //     _support_y[1] - frame_thickness * 3,
            //     -frame_height - 0.01 + _z05 - _z08 - frame_thickness * 2
            // ])
            // #cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);
    }

    // front support for seeding wheel
    translate([_x02, _y01, _z05])
    difference() {
        cube([frame_thickness, frame_width, frame_thickness]);

        translate([-0.01, -_y01 - exit_pipe_outer_diameter, -0.01])
        cube([frame_thickness * 1.1, exit_pipe_outer_diameter * 2, frame_thickness*1.1]);

        // serial label
        translate([frame_thickness / 2, frame_thickness * 5, frame_thickness - deboss_depth])
        rotate([0, 0, 90])
        linear_extrude(deboss_depth + 0.01)
        text(
            _serial,
            size = font_size,
            font = font_face,
            halign = "left",
            valign = "center",
        );

        // track plate mounting holes
        translate([-_x02, -_y01, 10])
        _track_plate_to_frame_holes();

        // connection holes to the duplicate frame above
        translate([
            frame_thickness / 2,
            frame_thickness * 2,
            -0.01
        ])
        cylinder(d = m3_hardware + 0.2, h = frame_thickness * 2);

        translate([
            frame_thickness / 2,
            -_y01 + _y08 - frame_thickness - frame_thickness * 1,
            -0.01
        ])
        cylinder(d = m3_hardware + 0.2, h = frame_thickness * 2);


    }


    for (i = [0 : len(_support_x) - 1]) {
        for (j = [0 : len(_support_y) - 1]) {
            translate([_support_x[i], _support_y[j], -frame_height])
            cube([frame_thickness, frame_thickness, frame_height]);

        }
        difference() {
            union() {
                translate([_support_x[i], _support_y[0] + frame_thickness, -frame_height])
                cube([frame_thickness, frame_thickness * 3, frame_thickness]);

                translate([_support_x[i], _support_y[1] - frame_thickness * 3, -frame_height])
                cube([frame_thickness, frame_thickness * 3, frame_thickness]);
            }

            // connection holes to main frame
            translate([
                _support_x[i] + frame_thickness / 2,
                _support_y[0] + frame_thickness * 2,
                -frame_height - 0.01
            ])
            cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);

            translate([
                _support_x[i] + frame_thickness / 2,
                _support_y[1] - frame_thickness * 1,
                -frame_height - 0.01
            ])
            cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);

            
        }
    }

    _cross_y = [
        _y01,
        _y05 - seeding_radius,
        _y05 + seeding_radius,
        _y08 - frame_thickness
    ];
    for (j = [0 : len(_cross_y) - 1]) {
        translate([-_x02, _cross_y[j], 0])
        difference() {
            cube([_x02 -_x04, frame_thickness, frame_thickness]);

            // track plate mounting holes
            translate([_x02, -_cross_y[j], 10])
            _track_plate_to_frame_holes();

        }
    }

    //support plates for ...
    translate([
    _x02,
    _y03 - frame_thickness * 3,
    _z08 + frame_thickness * 2 + 0.1
    ])
    cube([1, frame_thickness * 4, frame_thickness * 3]);

    translate([
    _x02, 
    _y06 - frame_thickness,
    _z08 + frame_thickness * 2 + 0.1
    ])
    cube([1, frame_thickness * 4, frame_thickness * 3]);

    translate([
    _x04 + frame_thickness,
    _y03 - frame_thickness * 3, 
    _z08 + frame_thickness * 2 + 0.1
    ])
    cube([1, frame_thickness * 4, frame_thickness * 3]);

    translate([    
    _x04 + frame_thickness,
    _y06 - frame_thickness,
    _z08 + frame_thickness * 2 + 0.1
    ])
    cube([1, frame_thickness * 4, frame_thickness * 3]);
    
}

module upper_frame_2() {
    //the frame for supporting our seeding marbles
    // translate([0, 0, _z05 - _z08 - frame_thickness * 2])
    // upper_frame();

     // taking out the connection holes to upper frame 2, didn't work, maybe come back later
        // translate([
        //     _support_x[i] + frame_thickness / 2,
        //     _support_y[0] + frame_thickness * 2,
        //     -frame_height - 0.01 + _z05 - _z08 - frame_thickness * 2
        //     ])
        // #cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);

        // translate([
        //     _support_x[i] + frame_thickness / 2,
        //     _support_y[1] - frame_thickness * 1,
        //     -frame_height - 0.01 + _z05 - _z08 - frame_thickness * 2
        //     ])
        // #cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);



            //it was an idea to make the holes work, but i gave up, so ignore
// difference() {
//     upper_frame();


        // translate([
        //     frame_thickness / 2,
        //     frame_thickness * 2,
        //     -0.01
        // ])
        // cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);

        // translate([
        //     frame_thickness / 2,
        //     -_y01 + _y08 - frame_thickness - frame_thickness * 1,
        //     -0.01
        // ])
        // cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);

        // #translate([
        //     -frame_thickness * 2 - seeding_wheel_diameter / 2 - frame_thickness,
        //     frame_thickness * 2,
        //     -0.01
        // ])
        // cylinder(d = m3_hardware - 0.1, h = frame_thickness * 2);

        // #translate([
        //     -frame_thickness * 2 - seeding_wheel_diameter / 2 - frame_thickness,
        //     -_y01 + _y08 - frame_thickness - frame_thickness * 1,
        //     -12
        // ])
        // cylinder(d = m3_hardware - 0.1, h = frame_thickness * 7);
    // }
}

_track_plate_mounting_angles = [38, 52, 128, 142, 219, 245, 295, 322];
module _track_plate_to_frame_holes() {
    // assumed M3 hardware

    module _a_hole() {
        cylinder(d = 3 + 0.2, h = 10*5);

        cylinder(d = m3_wafer_head_diameter + 0.3, h = m3_wafer_head_thickness + 0.2);

        // clear access path
        translate([0, 0, -10])
        cylinder(d = m3_wafer_head_diameter + 0.3, h = 10);
    }

    rotate([180, 0, 0])
    for (i = [0 : len(_track_plate_mounting_angles) - 1]) {
        rotate([0, 0, _track_plate_mounting_angles[i]])
        translate([seeding_radius + 9, 0, 0])
        _a_hole();
    }
}

module marble_tank() {
    //TO-DO : add screw holes
    marble_count = 10;

    translate([
        -marble_diameter * (marble_count + 1),
        -(marble_diameter + marble_tolerance + marble_tank_thickness)/2,
        marble_diameter
    ]) {

        difference(){
            union() {
                rotate([0, 10, 0])
                translate([0, 0, 10])
                // case
                cube([
                    marble_diameter * marble_count + marble_tolerance * marble_count + marble_tank_thickness,
                    marble_diameter + marble_tolerance + marble_tank_thickness,
                    marble_diameter + marble_tolerance + marble_tank_thickness
                ]);

                // chute
                translate([
                    (marble_diameter + marble_tolerance) * (marble_count - 1),
                    0,
                    -marble_diameter - frame_thickness - 1.5
                ])
                cube([
                    marble_diameter + marble_tolerance + marble_tank_thickness,
                    marble_diameter + marble_tolerance + marble_tank_thickness,
                    frame_thickness
                ]);
            }
            
            // hole in case
            rotate([0, 10, 0])
            translate([marble_tank_thickness / 2, marble_tank_thickness / 2, 0.1 + 10])
            cube([
                marble_diameter * 10 + marble_tolerance * 10,
                marble_diameter + marble_tolerance,
                marble_diameter + marble_tolerance + marble_tank_thickness + 0.01
            ]);

            // hole in chute
            translate([
                marble_diameter * 9 + marble_tolerance * 9 + 0.2,
                marble_tank_thickness / 2,
                -marble_diameter * 2.5 - marble_diameter
            ])
            cube([
                marble_diameter + marble_tolerance,
                marble_diameter + marble_tolerance,
                marble_diameter + marble_diameter / 2 + marble_tolerance + 40
            ]);

        }

        // plate with holes for screwing on
        translate([0, 0, -marble_diameter - marble_tolerance])
            cube([
            marble_diameter * 9 + marble_tolerance * 9,
            marble_diameter + marble_tolerance + marble_tank_thickness,
            1
        ]);

        // support for the back of the tank
        difference() {
            translate([5, 0, -16])
            cube([
                marble_diameter + marble_tolerance + marble_tank_thickness,
                marble_diameter + marble_tolerance + marble_tank_thickness,
                26
            ]);

            rotate([0, 10, 0])
            translate([marble_tank_thickness / 2, marble_tank_thickness / 2, 0.1 + 10])
            cube([
                marble_diameter * 10 + marble_tolerance * 10,
                marble_diameter + marble_tolerance,
                marble_diameter + marble_tolerance + marble_tank_thickness + 0.01
            ]);
        }
    }  // master translate
}

module assembly_view(exploded = 0) {
    //TO-DO: add marble tank
    _z_explode = 15 * exploded;

    color("salmon")
    translate([_x03, _y05, _z02 + 3 * _z_explode])
    seeding_wheel();

    color("Yellow")
    // translate([-marble_diameter * 11 + marble_tolerance * 11 - seeding_wheel_diameter / 2, 0, 44])
    translate([_x03, _y05, _z02 + 3 * _z_explode])
    marble_tank();

    color("DarkOrchid")
    translate ([_x03, _y05, _z07 - 1 * _z_explode])
    seeding_gear();

    // _seeding_wheel_mounting_holes();

    color("LightSeaGreen")
    translate([_x03, _y05, _z05 + 2 * _z_explode])
    track_plate();

    color("Gold")
    translate([0, 0, _z08 - 2 * _z_explode])
    frame();

    color("OrangeRed")
    translate([0, 0, -frame_thickness + 1 * _z_explode])
    upper_frame();

    // left side (1 transfer gear)
    color("CornflowerBlue")
    translate([
        _x03,
        _y06 + _z_explode,
        _z07 - _z_explode
    ])
    rotate([0, 0, 16.75])
    transfer_spur_gear();

    color("MediumSeaGreen")
    translate([
        _x03,
        _y06 + _z_explode,
        _z11 - 4 * _z_explode
    ])
    rotate([180, 0 ,0])
    transfer_bevel_gear();

    color("SeaGreen")
    translate([
        _x03,
        _y07 + 2 * _z_explode,
        _z12 - 4 * _z_explode
    ])
    rotate([90, 0 ,0])
    rotate([0, 0, 11.5])
    transfer_bevel_gear();

    color("darkslategray")
    translate([
        _x03,
        _y08 + 3 * _z_explode,
        _z12 - 4 * _z_explode
    ])
    rotate([90, 0 ,0])
    odometer_wheel();


    // right side (2 transfer gears)
    color("CornflowerBlue")
    translate([
        _x03,
        _y04 - _z_explode,
        _z07 - _z_explode
    ])
    rotate([0, 0, 5.5])
    transfer_spur_gear();

    color("CornflowerBlue")
    translate([
        _x03,
        _y03 - 2 * _z_explode,
        _z07 - _z_explode
    ])
    rotate([0, 0, 5.5])
    transfer_spur_gear();

    color("MediumSeaGreen")
    translate([
        _x03,
        _y03 - 2 * _z_explode,
        _z11 - 3 * _z_explode
    ])
    rotate([180, 0 ,0])
    transfer_bevel_gear();

    color("SeaGreen")
    translate([
        _x03,
        _y02 - 2 * _z_explode,
        _z12 - 4 * _z_explode
    ])
    rotate([270, 0 ,0])
    rotate([0, 0, 11.5])
    transfer_bevel_gear();

    color("darkslategray")
    translate([
        _x03,
        _y01 - 3 * _z_explode,
        _z12 - 4 * _z_explode
    ])
    rotate([270, 0 ,0])
    odometer_wheel();

    // color("orchid")
    // translate([0, 0, 0])
    // arduino_standoffs();
}


