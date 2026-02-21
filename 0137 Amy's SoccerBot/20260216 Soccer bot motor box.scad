
inch = 25.4;  // inch to mm
serial_number = "Amy 0137-01A";
deboss_depth = 0.4;
// font_face = "B612";
font_face = "Aldo";
font_size = 5;

// [ Base plate ]
base_plate_diameter = 230;
base_plate_thickness = 0.7;
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
    cylinder(d = base_plate_diameter, h = base_plate_thickness, $fn=72);

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


