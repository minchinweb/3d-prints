// Adjustments to Flight Instruments to allow multi-colour printing
// Based on CaptainBobSim's Cessna 172 project
//
// Split into sky and earth parts for two-colour printing
// Update magnet hole size
//
// William Minchin -- 2025-12-29 -- Print 0131C

FILE_ROOT = "D:/Code/The-Cessna-172-Project-V3/Section 2 - Component Library and Structure/2-5 Instruments/6-PACK_Attitude Indicator/V2 STLs";
// Print the text this deep (to avoid back bleed)
text_depth = 1; // in mm
// How wide should the marking lines be?
line_width = 1.5; // A - 1; B - 1.5
// Serial number for this print version
serial = "0131-05A";



OVERSIZE_FUDGE_FACTOR = 2;

// measured
outer_arm_width = 68.24;  // mm
// measured
arm_length = 42;  // mm

magnet_d = 6.2;  // Gridfinity, Print 0061E
magnet_depth = 2.3;

y_back_of_display = 10 + 13 + 4; // mm

font_face = "Aldo";
font_size = 5;
// should be multiple of layer height
deboss_depth = 1;
fudge = 0.01;


m25_head_z = 2.8;  // socket head
m25_head_od = 4.9;  // socket head
m25_nut_flats = 5.3;
m25_nut_z = 2.8;
m25_od = 2.9;
screw_fn = 12;
layer_height = 0.2;


// my_d = altitude_indicator_outer_ring_d + OVERSIZE_FUDGE_FACTOR;
// mid_disk = (altitude_indicator_inner_ring_d + altitude_indicator_outer_ring_d) / 2;
// ring_width = (altitude_indicator_outer_ring_d - altitude_indicator_inner_ring_d) / 2;

module internals_base() {
    rotate([0, 0, 90 * 0]) 
    translate([-110 * 0, -129 * 0, 0])
    import(str(FILE_ROOT, "/", "Structure Part.stl"));
}

module clipped_internals() {
    _serial = serial;

    difference() {

        union() {
            internals_base();

            translate([0, 10+47.464-5/2-0.3, 30.24+3.5/2]) 
            cube([5.5, 5.22, 5.5], center=true);

        }

        // knut trap
        translate([-outer_arm_width / 2 - 2.7, 22.3, 0])
        rotate([0, 90, 0])
        cylinder(d = magnet_d, h = magnet_depth + 5, $fn=24);

        translate([0, 10+16.5+2.8+1, 21.4+1.5])
        rotate([270, 0, 180]) {
            m25_screw(length = 10, overhangs = 1);

            m25_nut_slot(shaft_offset = 6);
        }

        translate([0, 10+16.5+2.8+1, -21.4-1.5])
        rotate([270, 0, 180]) {
            m25_screw(length = 10, overhangs = 1);

            m25_nut_slot(shaft_offset = 6);
        }

        // magnet hole
        pin_hole_od = 2;
        layer_height = 0.2;
        overhangs = 2;
        pin_head_z = magnet_depth+0.4;

        translate([0, 10+47.464-0.1, 30.24+3.5/2])
        rotate([90, 0, 0]) {
            cylinder (d=magnet_d, h=pin_head_z, $fn=24);
            cylinder (d=pin_hole_od, h=8, $fn=24);

            // overhands
            intersection() {
                translate([-pin_hole_od / 2, -magnet_d / 2, pin_head_z])
                cube([pin_hole_od, magnet_d, layer_height * overhangs]);

                translate([0, 0, pin_head_z])
                cylinder(
                    d = magnet_d,
                    h = layer_height * (overhangs),
                    $fn = 2 * screw_fn
                );
            }

            intersection() {
                translate([
                    -pin_hole_od / 2,
                    -pin_hole_od / 2,
                    pin_head_z + layer_height * overhangs
                ])
                cube([pin_hole_od, pin_hole_od, layer_height * overhangs]);

                translate([
                    -pin_hole_od / 2,
                    -magnet_d / 2,
                    pin_head_z + layer_height * overhangs
                ])
                cube([m25_od, magnet_d, layer_height * overhangs]);

                translate([
                    0,
                    0,
                    pin_head_z + layer_height * overhangs
                ])
                cylinder(
                    d = magnet_d,
                    h = layer_height * overhangs,
                    $fn = 2 * screw_fn
                );
            }

        }

        // part label
        translate([23.25 + 3 - deboss_depth, 45, -17.5 - 6])
        rotate([90, 0, 90])
        linear_extrude(deboss_depth + fudge)
        text(
            _serial,
            size = font_size,
            font = font_face,
            halign = "center",
            valign = "center"
        );
    }
}




module sky_internals_front() {
    color("skyblue")

    intersection() {
        clipped_internals();

        translate([-50, y_back_of_display - 100, 0]) 
        cube([100, 100, 100]);
    }
}

module earth_internals_front() {
    color("SaddleBrown")

    intersection() {
        clipped_internals();

        translate([-50, y_back_of_display - 100, -100]) 
        cube([100, 100, 100]);
    }
}

module internals_back() {
    color("green")
    intersection() {
        clipped_internals();

        translate([-50, y_back_of_display, -50])  
        cube([100, 100, 100]);
    }
}




module m25_screw(length = 10, overhangs = 0) {
    // overhangs: 0 or 1 -- improvements for printing as overhang; gives height
    //                      in layers

    // head
    translate([0, 0, -fudge]) 
    cylinder(d = m25_head_od, h = m25_head_z + fudge, $fn = 2 * screw_fn);

    // shaft
    cylinder(d = m25_od, h = length, $fn = screw_fn);

    if (overhangs != 0) {
        // print overhang helps
        intersection() {
            translate([-m25_od / 2, -m25_head_od / 2, m25_head_z])
            cube([m25_od, m25_head_od, layer_height * overhangs]);

            translate([0, 0, m25_head_z]) 
            cylinder(
                d = m25_head_od,
                h = layer_height * (overhangs),
                $fn = 2 * screw_fn
            );
        }

        intersection() {
            translate([
                -m25_od / 2,
                -m25_od / 2,
                m25_head_z + layer_height * overhangs
            ])
            cube([m25_od, m25_od, layer_height * overhangs]);

            translate([
                -m25_od / 2,
                -m25_head_od / 2,
                m25_head_z + layer_height * overhangs
            ])
            cube([m25_od, m25_head_od, layer_height * overhangs]);

            translate([
                0,
                0,
                m25_head_z + layer_height * overhangs
            ])
            cylinder(
                d = m25_head_od,
                h = layer_height * overhangs,
                $fn = 2 * screw_fn
            );
        }
    }
}

module m25_nut() {
    // assuming slip fit

    // distance across flats / cos(30) = distance across corners (aka "diameter")

    cylinder(d = m25_nut_flats / cos(30), h = m25_nut_z, $fn=6);
}

module m25_nut_slot(shaft_offset = 0) {
    translate([0, 0, shaft_offset]) {
        rotate([0, 0, 30])
        m25_nut();

        translate([m25_nut_flats / 2, 0, 0])
        rotate([0, 0, 180])
        cube([m25_nut_flats, 20, m25_nut_z]);
    }
}


module clearance_test() {
    // creates a small cube with a recessed screw hole and nut slot, to confirm
    // clearances
    
    _serial = "0131-5D";
    _countersunk_depth = m25_head_z;
    _countersink_diameter = m25_head_od;
    _nut_flats = m25_nut_flats;
    _nut_z = m25_nut_z;

    // _text_str = str(_serial) + " / CS " + str(_countersunk) + " / nut " + str(_nut_flats) + "x" + str(_nut_z);

    cube_x = 10;
    cube_y = 30;
    cube_z = 15;

    difference() {
        cube([cube_x, cube_y, cube_z]);

        translate([cube_x / 2, 0, cube_z / 2])
        rotate([270, 0, 0]) {
            m25_screw(length = cube_y * 1.1, overhangs = 1);

            m25_nut_slot(shaft_offset = max(_nut_z, _countersunk_depth * 2));
        }

        translate([cube_x / 2, cube_y - 1, cube_z - 1])
        rotate([0, 0, 270])
        linear_extrude(deboss_depth + fudge)
        text(
            _serial,
            size = font_size,
            font = font_face,
            halign = "left",
            valign = "center"
        );

        translate([deboss_depth, cube_y - 1, cube_z - 2 - 0 * font_size * 1.1])
        rotate([90, 0, 270])
        linear_extrude(deboss_depth + fudge)
        text(
            str("CS ", str(_countersink_diameter), "x", str(_countersunk_depth)),
            size = font_size,
            font = font_face,
            halign = "left",
            valign = "top"
        );

        translate([deboss_depth, cube_y - 1, cube_z - 3 - 1 * font_size * 1.1])
        rotate([90, 0, 270])
        linear_extrude(deboss_depth + fudge)
        text(
            str("nut ", str(_nut_flats), "x", str(_nut_z)),
            size = font_size,
            font = font_face,
            halign = "left",
            valign = "top"
        );
    }
}


// clearance_test();

// internals_base();
// clipped_internals();

sky_internals_front();
earth_internals_front();
internals_back();
