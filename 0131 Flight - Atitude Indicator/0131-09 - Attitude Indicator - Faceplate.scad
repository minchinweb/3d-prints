// "Back board" for wire connections and mounting controller boards

// TODO: Add "thru holes" to inner cage (currently drilling them)

include <BOSL2/std.scad>
include <BOSL2/screws.scad>

serial = "0131-09B";
// serial_2 = "2026-04-03";

FILE_ROOT = "D:/Code/The-Cessna-172-Project-V3/Section 2 - Component Library and Structure/2-5 Instruments/6-PACK_Attitude Indicator/V2 STLs";

// plate_thickness = 2;
// inner_thru_hole_x = 26 / 2;
// inner_thru_hole_y = 73 / 2;

// base_z = 62.0;
// base_ring_supports_z = 5;

faceplate_hole_x = 37.52 / 2;
faceplate_hole_y = 73.92 / 2;

// m2_z = 1.55;  // nut thickness
faceplate_z = 9.55;  // from the back to the inside top
faceplate_inside_z = 7.75;  // from back to top of inside circle
faceplace_inside_d = 79.6;  // diamter of inside (back) hole
m2_head_z = 1.87 + 0.23 + 0.296;  // for cap head M2x20 screw; based + clearance + enough to match existing holes
m2_head_extra_z = 4;  // height/passageway above the screwhead to keep clear
m2_head_d = 3.60 + 0.3;  // head size (diamter) of M2x20 screw (with clearance)
m2_d = 2.0 + 0.4;  // bolt diameter, clear (with printing tolerances)
wire_d = 2 + 1;  // diameter of single wire

fudge = 0.01;

font_size = 5;
deboss_depth = 0.6;
font_face = "Aldo";
// font_face = "B612";


module faceplate_base() {
    // rotate([0, 0, 90]) 
    translate([-128, -122.7, 0])
    import(str(FILE_ROOT, "/", "Attitude Bezel.stl"));
}

module holes_to_body() {
        module local_hole() {
            translate([0, 0, faceplate_z - fudge])
            cylinder(d = m2_head_d, h = m2_head_extra_z, $fn=24);

            translate([0, 0, faceplate_z - m2_head_z])
            cylinder(d = m2_head_d, h = m2_head_z + 2 * fudge, $fn=24);

            translate([0, 0, 0])
            cylinder(d = m2_d, h = faceplate_z + 2 * fudge, $fn=12);

        }
        // through holes
        /// holes to inner layer
        translate([faceplate_hole_x, faceplate_hole_y, -fudge])
        local_hole();

        translate([faceplate_hole_x, -faceplate_hole_y, -fudge])
        local_hole();

        translate([-faceplate_hole_x, faceplate_hole_y, -fudge])
        local_hole();

        translate([-faceplate_hole_x, -faceplate_hole_y, -fudge])
        local_hole();

        translate([faceplate_hole_y, faceplate_hole_x, -fudge])
        local_hole();

        translate([faceplate_hole_y, -faceplate_hole_x, -fudge])
        local_hole();

        translate([-faceplate_hole_y, faceplate_hole_x, -fudge])
        local_hole();

        translate([-faceplate_hole_y, -faceplate_hole_x, -fudge])
        local_hole();  
}

module holes_for_lighting_wires() {
    module local_hole() {
        translate([-wire_d, -wire_d / 2, 0])
        cube([wire_d, wire_d, faceplate_inside_z + fudge]);

        cylinder(d = wire_d, h = faceplate_inside_z + fudge, $fn = 12);
    }

    my_angle = 37.5;
    _angles = [-my_angle, +my_angle];
    for (i = [0: len(_angles) - 1]) {
        rotate([0, 0, 270 + _angles[i]])
        translate([faceplace_inside_d / 2 + wire_d - 0.15, 0, -fudge])
        local_hole();
    }

}

module clipped_faceplate_base() {
    difference() {
        faceplate_base();

        holes_to_body();
        holes_for_lighting_wires();

        // bottom (side) labels
        translate([29.7 / 2, -faceplate_hole_y - 3.36 - 0.45, faceplate_z / 2])
        rotate([90, 0, 0])
        linear_extrude(height = deboss_depth + fudge) {
            translate([0, 0, 0]) {
                text(
                    serial,
                    size = font_size,
                    font = font_face,
                    halign = "center",
                    valign = "center",
                );
            }
        }

        // top labels
        translate([0, 0, faceplate_z - deboss_depth * 1])
        rotate([0, 0, 0])
        linear_extrude(height = deboss_depth + fudge + 1) {

            // translate([faceplate_hole_x + 4.5, faceplate_hole_y, 0])
            // rect([3, 0.8]);

            translate([faceplate_hole_x + 4, faceplate_hole_y, 0]) {
                text(
                    "M2",
                    size = font_size,
                    font = font_face,
                    halign = "left",
                    valign = "center",
                );
            }
        }
    }
}

// holes_to_body();
// faceplate_base();
// holes_for_lighting_wires();

clipped_faceplate_base();


// // for centering base
// color("red") {
//     centering_r = 35.526;
//     cylinder(r = centering_r, h = 20);

//     // translate([0, 0, 20 / 2]) {
//     //     cube([centering_r * 2, 0.1, 20], center=true);
//     //     cube([0.1, centering_r * 2, 20], center=true);
//     // }
// }

