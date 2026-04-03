
include <BOSL2/std.scad>
include <BOSL2/gears.scad>

inch = 25.4;  // inch to mm
serial_number = "Amy 0137-02B";
deboss_depth = 0.4;
// font_face = "B612";
font_face = "Aldo";
font_size = 5;

// [ Base plate ]
base_plate_diameter = 230;
base_plate_thickness = 5;
base_plate_center_hole_diameter = 6.25;  // about 1/4"
tube_base_inset_side = 180;
tube_base_inset_ridge_height = 10;
tube_base_inset_ridge_width = 3;
wheel_shaft_height = 33/2;


// [ Motor ]
// including the front plate, but not the back contracts
motor_length = 24.0;
motor_width = 12.0;
motor_height = 10.0;
motor_box_clearance = 0.5;
motor_box_thickness = 1.0;

// [ Seeding Gears ]
// tooth width. circular pitch = PI*d/teeth
circular_pitch = 1/4 * inch;
// circular_pitch = 1/16 * inch;
seeding_radius = base_plate_diameter / 2;
seeding_gear_diameter = seeding_radius * 2;
seeding_gear_thickness = base_plate_thickness;
// inside clear diameter
seeding_gear_shaft_diameter = base_plate_center_hole_diameter;
// industry standard is 20 degrees
pressure_angle = 20;

seeding_gear_teeth = floor(PI * seeding_gear_diameter / circular_pitch);

drive_gear_diameter = 45;
drive_gear_teeth = floor(PI * drive_gear_diameter / circular_pitch);
// drive_gear_teeth = 22;

drive_gear_shaft_diameter = 12.7;

echo("drive_gear_teeth", drive_gear_teeth);

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

module _base_plate() {
    // cylinder(d = base_plate_diameter, h = base_plate_thickness, $fn=72);

    insert_outside = tube_base_inset_side + tube_base_inset_ridge_width * 2;

    translate ([-insert_outside/2, -insert_outside/2, 0]) {
        difference() {
            cube([insert_outside, insert_outside, tube_base_inset_ridge_height]);

            translate([tube_base_inset_ridge_width, tube_base_inset_ridge_width, base_plate_thickness])
            cube([tube_base_inset_side, tube_base_inset_side, tube_base_inset_ridge_height + 0.2]);
        }
    }
    // translate ([-base_plate_diameter/2, -base_plate_diameter/2, 0])
    // cube([base_plate_diameter, base_plate_diameter, base_plate_thickness]);


}

module _motor_box_support() {
    cube([motor_length, motor_width, 10]);
}

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
        //_seeding_wheel_mounting_holes();

        // // serial
        // translate([
        //     seeding_radius - 9,
        //     0,
        //     seeding_gear_thickness / 2 - deboss_depth
        // ])
        // rotate([0, 0 ,90])
        // linear_extrude(deboss_depth + 0.01)
        // text(
        //     _serial,
        //     size = font_size,
        //     font = font_face,
        //     halign = "center",
        //     valign = "baseline"
        // );
    }
}

module drive_gear() {
    _serial = "0137-03B";

    difference() {
        // union() {
            color("pink")
            spur_gear(
                circular_pitch,
                drive_gear_teeth,
                seeding_gear_thickness,
                pressure_angle = pressure_angle,
                // shaft_diam = seeding_gear_shaft_diameter
            );
            
            // serial
            // translate([10, 0, base_plate_thickness / 2])
            // rotate([0, 0 ,90])
            // linear_extrude(deboss_depth + 0.01)
            // text(
            //     _serial,
            //     size = font_size,
            //     font = font_face,
            //     halign = "center",
            //     valign = "baseline"
            // );


        // translate([0, 0, base_plate_thickness * 2])
        // rotate([0, 180, 0])
        // #cylinder(d = 5, h = 15);

        translate([0, 0,  - base_plate_thickness / 2])
        rotate([0, 0, 0])
        cube([base_plate_thickness, 2, 28], center=true);

        translate([0, 0,  - base_plate_thickness / 2])
        rotate([0, 0, 90])
        cube([base_plate_thickness, 2, 28], center=true);

    }

    color("cornflowerblue")
    translate([0, 0, 0])
    cylinder(d = base_plate_center_hole_diameter, h = drive_gear_shaft_diameter, $fn=36);

}

module v1() {
    translate([0, -base_plate_diameter/2 - 3, 0]) {
        translate([0, 0, wheel_shaft_height])
        color("pink")
        _motor_box();

        translate([-motor_width/2 - motor_box_thickness * 2, 0, 0])
        color("cornflowerblue")
        cube([motor_width + motor_box_thickness * 4, motor_length + 2, 9 + 0.5]);
    }

    difference() {
        _base_plate();

        translate([0, 0, -0.1])
        cylinder(d = base_plate_center_hole_diameter, h = 10);

        #translate([0, tube_base_inset_side/2 + font_size, base_plate_thickness - deboss_depth])
        rotate([0,0,0])
        linear_extrude(deboss_depth + 0.01)
        text(
            serial_number,
            size = font_size,
            font = font_face,
            halign = "center",
            valign = "baseline"
        );
    }
}

module v2() {
    translate([0, -base_plate_diameter/2 - 3, 0]) {
        translate([0, 0, wheel_shaft_height])
        color("pink")
        _motor_box();

        translate([-motor_width/2 - motor_box_thickness * 2, 0, 0])
        color("cornflowerblue")
        cube([motor_width + motor_box_thickness * 4, motor_length + 2, 9 + 0.5]);
    }

    difference() {
        intersection() {
            _base_plate();

            cylinder(d = seeding_gear_diameter - 10, h = tube_base_inset_ridge_height * 2);

        }

        translate([0, 0, -0.1])
        cylinder(d = base_plate_center_hole_diameter, h = 10);

        #translate([0, tube_base_inset_side/2 + font_size, base_plate_thickness - deboss_depth])
        rotate([0,0,0])
        linear_extrude(deboss_depth + 0.01)
        text(
            serial_number,
            size = font_size,
            font = font_face,
            halign = "center",
            valign = "baseline"
        );
    }
}

module v3() {

    _serial = "0137-02C";
    seeding_gear();

    difference() {
        union() {
            intersection() {
                _base_plate();

                cylinder(d = seeding_gear_diameter - 10, h = tube_base_inset_ridge_height * 2);
            }

            translate([0, tube_base_inset_side/2 + font_size, base_plate_thickness / 2 - deboss_depth * 0])
            rotate([0,0,0])
            linear_extrude(deboss_depth+ 0.01)
            text(
                _serial,
                size = font_size,
                font = font_face,
                halign = "center",
                valign = "baseline"
            );
        }

        translate([0, 0, -0.1])
        cylinder(d = base_plate_center_hole_diameter, h = 10);

    }

}

// v2();
// seeding_gear();
// translate([base_plate_diameter / 2 + drive_gear_diameter / 2, 0, 0])
// drive_gear();

// translate([-base_plate_diameter / 2 - drive_gear_diameter / 2, 0, 0])
drive_gear();

// v3();