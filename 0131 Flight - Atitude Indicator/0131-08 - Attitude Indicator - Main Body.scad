// "Back board" for wire connections and mounting controller boards

// TODO: Add "thru holes" to inner cage (currently drilling them)

include <BOSL2/std.scad>
include <BOSL2/screws.scad>

serial = "0131-08A";
// serial_2 = "2026-04-03";

FILE_ROOT = "D:/Code/The-Cessna-172-Project-V3/Section 2 - Component Library and Structure/2-5 Instruments/6-PACK_Attitude Indicator/V2 STLs";

plate_thickness = 2;
inner_thru_hole_x = 26 / 2;
inner_thru_hole_y = 73 / 2;

base_z = 62.0;
base_ring_supports_z = 5;

faceplate_hole_x = 37.52 / 2;
faceplate_hole_y = 73.92 / 2;

m2_z = 1.55;  // nut thickness

fudge = 0.01;

font_size = 5;
deboss_depth = 0.6;
font_face = "Aldo";
// font_face = "B612";


module body_base() {
    // rotate([0, 0, 90]) 
    translate([-128, -160.9, 0])
    import(str(FILE_ROOT, "/", "Backing plate.stl"));
}

module holes_to_electronics_cage() {
        module local_hole() {
            cylinder(d = 3.5, h = plate_thickness + 2 * fudge, $fn=12);

            translate([0, 0, plate_thickness - 0.8])
            nut_trap_inline(1, "M3");
        }

        // through holes
        /// holes to inner layer
        translate([inner_thru_hole_x, inner_thru_hole_y, -fudge])
        local_hole();

        translate([inner_thru_hole_x, -inner_thru_hole_y, -fudge])
        local_hole();

        translate([-inner_thru_hole_x, inner_thru_hole_y, -fudge])
        local_hole();

        translate([-inner_thru_hole_x, -inner_thru_hole_y, -fudge])
        local_hole();

        translate([inner_thru_hole_y, inner_thru_hole_x, -fudge])
        local_hole();

        translate([inner_thru_hole_y, -inner_thru_hole_x, -fudge])
        local_hole();

        translate([-inner_thru_hole_y, inner_thru_hole_x, -fudge])
        local_hole();

        translate([-inner_thru_hole_y, -inner_thru_hole_x, -fudge])
        local_hole();
}

module holes_to_faceplate() {
        module local_hole() {
            // cylinder(d = 2, h = 22 + 2 * fudge, $fn=12);
            translate([0, 0, base_z])
            screw_hole(str("M2,", base_z), thread=true, bevel=true, anchor=TOP);

            translate([0, 0, plate_thickness + 0.11])
            nut_trap_inline(m2_z * 1.25, "M2");

            translate([0, 0, base_z - base_ring_supports_z - m2_z * 1.25 - 1])
            nut_trap_inline(m2_z * 1.25, "M2");
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

module clipped_body_base() {
    difference() {
        body_base();

        holes_to_electronics_cage();
        holes_to_faceplate();

        // labels
        translate([0, 0, deboss_depth])
        rotate([180, 0, 180])
        linear_extrude(height = deboss_depth + fudge) {
            translate([-27, -30, 0]) {
                text(
                    serial,
                    size = font_size,
                    font = font_face,
                    halign = "left",
                    valign = "center",
                );
            }

            translate([-32.75, -19, 0])
            rect([3.5, 0.8]);

            translate([-29, -20, 0]) {
                text(
                    "M2",
                    size = font_size,
                    font = font_face,
                    halign = "left",
                    valign = "center",
                );
            }

            translate([-32, -13, 0])
            rect([3, 0.8]);

            translate([-29, -13, 0]) {
                text(
                    "M3",
                    size = font_size,
                    font = font_face,
                    halign = "left",
                    valign = "center",
                );
            }

            translate([-7.25, 0, 0])
            rect([0.8, 29]);
        }
    }
}

// holes_to_electronics_cage();
// holes_to_faceplate();
// body_base();

clipped_body_base();


// // for centering base
// color("red") {
//     cylinder(d = 10, h = 1);

//     // translate([0, 0, 2 / 2]) {
//     //     cube([10, 0.1, 2], center=true);
//     //     cube([0.1, 10, 2], center=true);
//     // }
// }

