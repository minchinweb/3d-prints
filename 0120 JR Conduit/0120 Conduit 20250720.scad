/*

Time Log

July 20:
    - 1937-2327 -- install OpenSCAD, first pass
July 21:
    - 1009-1020 -- update B-2 ID

TODO:
    - ask for payment (at $50/hr)
    - add serial number to parts

August 22:
    - If doing again, use a union for the top parts to avoid the "wings" from
      crossing cylinders.
    - time spent: 2h50 + 0h12 = 3h02
    - 3.25 * $50 = $162.50 --> asked for $165
*/

z_adj = 0.01;

A_1_ID = 34;  // inside diameter, in mm 
A_2_ID = 34;
A_3_ID = 21.2;
A_1_length = 60;  // branch length, in mm
A_2_length = 60;
A_3_length = 40;
A_thickness = 2;  // shell thickness, in mm
A_1_rotation = 120;  // rotation of part A, in degrees
A_2_rotation = -120;  // rotation of part A, in degrees
A_3_rotation = 0;  // rotation of part A, in degrees
A_1_extra_legnth = 10.9;  // extension to allow upstream meeting
A_2_extra_legnth = 10.9;  // extension to allow upstream meeting
A_bottom_plate_height = 10;
A_wing_width = 25;  // wing width on each side
A_wing_length = 100;
A_wing_delta_z = -15;  // reposition of wing
A_wing_thickness = 3;

B_1_ID = 34;  // inside diameter, in mm 
B_2_ID = 33.42;
B_3_ID = 21.2;
B_1_length = 60;  // branch length, in mm
B_2_length = 60;
B_3_length = 40;
B_thickness = 2;  // shell thickness, in mm
B_1_rotation = 120;  // rotation of part A, in degrees
B_2_rotation = -180;  // rotation of part A, in degrees
B_3_rotation = 0;  // rotation of part A, in degrees
B_1_extra_legnth = 10.9;  // extension to allow upstream meeting
B_2_extra_legnth = 10.9;  // extension to allow upstream meeting
B_2_offset = -B_2_ID + B_3_ID * 3/2;
B_bottom_plate_height = 10;
B_wing_width = 25;  // wing width on each side
B_wing_length = 70;
B_wing_delta_y = 20;
B_wing_delta_z = -15;  // reposition of wing
B_wing_thickness = 3;


C_1_ID = 34;  // inside diameter, in mm 
C_2_ID = 21.2;
C_1_length = 60;  // branch length, in mm
C_2_length = 40;
C_thickness = 2;  // shell thickness, in mm
C_1_rotation = 90;  // rotation of part A, in degrees
C_2_rotation = 0;  // rotation of part A, in degrees
C_1_extra_legnth = C_2_ID / 2 + C_thickness;  // extension to allow upstream meeting
C_2_extra_legnth = 0;  // extension to allow upstream meeting
C_2_offset = 0;
C_bottom_plate_height = 10;
C_wing_width = 25;  // wing width on each side
C_wing_length = 72.6;
C_wing_delta_y = 23.7;
C_wing_delta_z = 0;  // reposition of wing
C_wing_thickness = 3;
C_ramp_length_adjustment = 20;
C_ramp_length_angle = 137;

module part_a() {
    difference() {
        union() {
            rotate([A_1_rotation, 0, 0])
                translate([0, 0, -A_1_extra_legnth])
                cylinder(d = A_1_ID + A_thickness * 2, h = A_1_length + A_1_extra_legnth);

            rotate([A_2_rotation, 0, 0])
                translate([0, 0, -A_2_extra_legnth])
                cylinder(d = A_2_ID + A_thickness * 2, h = A_2_length + A_2_extra_legnth);

            rotate([A_3_rotation, 0, 0])
                cylinder(d = A_3_ID + A_thickness * 2, h = A_3_length);

            // wing
            translate([-A_1_ID / 2 - A_thickness - A_wing_width, -A_wing_length/2, A_wing_delta_z]) 
            cube([A_1_ID + A_thickness * 2 + A_wing_width * 2, A_wing_length, A_wing_thickness]);
        }

        rotate([A_1_rotation, 0, 0])
            translate([0, 0, -z_adj])
            cylinder(d = A_1_ID, h = A_1_length + z_adj * 2);

        rotate([A_2_rotation, 0, 0])
            translate([0, 0, -z_adj])
            cylinder(d = A_2_ID, h = A_2_length + z_adj * 2);

        rotate([A_3_rotation, 0, 0])
            translate([0, 0, -z_adj])
            cylinder(d = A_3_ID, h = A_3_length + z_adj * 2);
    }

    // internal divider plate
    translate(v = [0, 0, -5]) 
    difference() {
        rotate([90, 0, 0])
        cylinder(d = A_1_ID, h = A_thickness);

        translate([
            -A_1_ID / 2 - z_adj,
            -A_thickness - z_adj,
            0
        ]) 
        cube([A_1_ID + z_adj * 2, A_thickness + z_adj * 2, A_1_ID]);
    }
}

module part_b() {
    difference() {
        union() {
            rotate([B_1_rotation, 0, 0])
                translate([0, 0, -B_1_extra_legnth])
                cylinder(d = B_1_ID + B_thickness * 2, h = B_1_length + B_1_extra_legnth);

            rotate([B_2_rotation, 0, 0])
                translate([0, B_2_offset, -B_2_extra_legnth])
                cylinder(d = B_2_ID + B_thickness * 2, h = B_2_length + B_2_extra_legnth);

            rotate([B_3_rotation, 0, 0])
                cylinder(d = B_3_ID + B_thickness * 2, h = B_3_length);

            // wing
            translate([
                -B_1_ID / 2 - B_thickness - B_wing_width,
                -B_wing_length/2 - B_wing_delta_y,
                B_wing_delta_z
            ]) 
            cube([B_1_ID + B_thickness * 2 + B_wing_width * 2, B_wing_length, B_wing_thickness]);
        }

        rotate([B_1_rotation, 0, 0])
            translate([0, 0, -z_adj])
            cylinder(d = B_1_ID, h = B_1_length + z_adj * 2);

        rotate([B_2_rotation, 0, 0])
            translate([0, B_2_offset, -z_adj])
            cylinder(d = B_2_ID, h = B_2_length + z_adj * 2);

        rotate([B_3_rotation, 0, 0])
            translate([0, 0, -z_adj])
            cylinder(d = B_3_ID, h = B_3_length + z_adj * 2);
    }
}


module part_c() {
    difference() {
        union() {
            rotate([C_1_rotation, 0, 0])
                translate([0, 0, -C_1_extra_legnth])
                cylinder(d = C_1_ID + C_thickness * 2, h = C_1_length + C_1_extra_legnth);

            rotate([C_2_rotation, 0, 0])
                translate([0, 0, -C_2_extra_legnth])
                cylinder(d = C_2_ID + C_thickness * 2, h = C_2_length + C_2_extra_legnth);

            // wing
            translate([
                -C_1_ID / 2 - C_thickness - C_wing_width,
                -C_wing_length/2 - C_wing_delta_y,
                C_wing_delta_z
            ]) 
            cube([C_1_ID + C_thickness * 2 + C_wing_width * 2, C_wing_length, C_wing_thickness]);
        }

        rotate([C_1_rotation, 0, 0])
            translate([0, 0, -z_adj])
            cylinder(d = C_1_ID, h = C_1_length + z_adj * 2);

        rotate([C_2_rotation, 0, 0])
            translate([0, C_2_offset, -z_adj])
            cylinder(d = C_2_ID, h = C_2_length + z_adj * 2);

        // ramp between the two sections
        intersection() {
            rotate([C_1_rotation, 0, 0])
                translate([0, 0, -C_2_ID / 2])
                cylinder(d = C_1_ID, h = C_2_ID / 2);

            rotate([C_2_rotation, 0, 0])
                translate([0, C_2_offset, -z_adj*0 - C_1_ID / 2 * 1])
                cylinder(d = C_2_ID, h = C_1_ID / 2);

            rotate([C_ramp_length_angle, 0, 0])
                translate([0, -1, -C_ramp_length_adjustment / 2])
                cylinder(d = C_2_ID, h = C_1_ID / 2 + C_ramp_length_adjustment);
        }

        // // cut in half (to see insides)
        // translate([-50, -100, -50]) 
        // cube([50, 150, 100]);
    }
}

part_b();
