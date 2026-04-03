// "Back board" for wire connections and mounting controller boards

include <BOSL2/std.scad>
include <BOSL2/screws.scad>

serial = "WM 0131-06A";
serial_2 = "2026-04-03";

between_posts = 62.862;
insert_hole_diameter = 2.159*2;
insert_holes_xy = 62.862;  // distance between insert pins
driver_board_x = 29.6;
driver_board_y = 26.6;
driver_board_z_offset = 5;
driver_board_hole_diameter = 3;  // M3 hardware
// wire count:
//  - 2x4 for stepper motors
//  - 2x1 for hall switch data
//  - 2 (+/-) for 5V for stepper motors, hall switches
//  - 2 (+/-) for lighting (on dimmer)
//  --> 14 total
header_x_pins = 2;
header_y_pins = 7;
header_pitch = 2.54;
header_z = 14;
header_z_clearance = 14;  // beyond the back of the header
stepper_motor_z = 19;
plate_thickness = 2;

fudge = 0.01;

font_size = 5;
deboss_depth = 0.6;
font_face = "Aldo";
// font_face = "B612";

insert_hole_extra_z = 7.5;
insert_pin_fn = 24;

header_hole_x = 37;
header_hole_y = 22;

header_x = header_x_pins * header_pitch;
header_y = header_y_pins * header_pitch;

clear_z = max(header_z + header_z_clearance, stepper_motor_z);

module main() {
    difference() {
        // main backer plate
        linear_extrude(height = plate_thickness)
        rect([80, 80], chamfer=10);

        // through holes
        translate([-header_hole_x, header_hole_y, -fudge])
        cube([header_y, header_x, plate_thickness + 2 * fudge]);

        translate([insert_holes_xy/2, insert_holes_xy/2 - 8, -fudge])
        cylinder(d = 3.5, h = plate_thickness + 2 * fudge, $fn=12);

        translate([insert_holes_xy/2, -insert_holes_xy/2 + 8, -fudge])
        cylinder(d = 3.5, h = plate_thickness + 2 * fudge, $fn=12);

        translate([-insert_holes_xy/2 + 8, insert_holes_xy/2, -fudge])
        cylinder(d = 3.5, h = plate_thickness + 2 * fudge, $fn=12);

        translate([-insert_holes_xy/2, -insert_holes_xy/2 + 8, -fudge])
        cylinder(d = 3.5, h = plate_thickness + 2 * fudge, $fn=12);

        translate([-insert_holes_xy/2 + 8, -insert_holes_xy/2, -fudge])
        cylinder(d = 3.5, h = plate_thickness + 2 * fudge, $fn=12);

        // labels
        translate([0, 0, deboss_depth])
        rotate([180, 0, 180])
        linear_extrude(height = deboss_depth + fudge) {
            translate([-28, -34, 0]) {
                text(
                    serial,
                    size = font_size,
                    font = font_face,
                    halign = "left",
                    valign = "center",
                );

                translate([0, font_size * 1.3, 0])
                text(
                    serial_2,
                    size = font_size,
                    font = font_face,
                    halign = "left",
                    valign = "center",
                );
            }

            // pin 1 triangle
            translate([
                header_hole_x - (header_y_pins - 0.5) * header_pitch,
                header_hole_y + (header_x_pins + 1) * header_pitch,
                0
            ])
            regular_ngon(n = 3, r = font_size / 3, spin = 30);

            // translate([header_hole_x - 2.5 * header_pitch, 20, 0])
            // text(
            //     "steppers",
            //     size = font_size,
            //     font = font_face,
            //     halign = "right",
            //     valign = "top",
            // );

            translate([header_hole_x - 1.5 * header_pitch, 21 - font_size * 1.3 * 0.5, 0])
            rect([0.8, font_size * 1.3]);

            translate([header_hole_x - 1.5 * header_pitch + 1, 20 - font_size * 1.3, 0])
            text(
                "5V",
                size = font_size,
                font = font_face,
                halign = "right",
                valign = "top",
            );

            translate([header_hole_x - 0.5 * header_pitch, 21 - 2 * font_size * 1.3 * 0.5, 0])
            rect([0.8, 2 * font_size * 1.3]);

            translate([header_hole_x - 0.5 * header_pitch + 1, 20 - 2 * font_size * 1.3, 0])
            text(
                "light",
                size = font_size,
                font = font_face,
                halign = "right",
                valign = "top",
            );
        }

        translate([9, 22, plate_thickness - deboss_depth])
        linear_extrude(height = deboss_depth + fudge)
        text(
            "ULN2003",
            size = font_size,
            font = font_face,
            halign = "center",
            valign = "center",
        );

        translate([9, -22, plate_thickness - deboss_depth])
        linear_extrude(height = deboss_depth + fudge)
        text(
            "ULN2003",
            size = font_size,
            font = font_face,
            halign = "center",
            valign = "center",
        );

    }

    // guide pins
    translate([insert_holes_xy/2, insert_holes_xy/2, 0]) 
    pin();

    translate([insert_holes_xy/2, -insert_holes_xy/2, 0]) 
    pin();

    translate([-insert_holes_xy/2, insert_holes_xy/2, 0]) 
    pin();

    translate([-insert_holes_xy/2, -insert_holes_xy/2, 0]) 
    pin();

    // driver board supports
    translate([9, -22, plate_thickness])
    driver_board_support();

    translate([9, 22, plate_thickness])
    driver_board_support();

    // header support
    translate([-header_hole_x - plate_thickness / 2, header_hole_y - plate_thickness / 2, plate_thickness]) {
        difference() {
            cube([header_y + plate_thickness, header_x + plate_thickness, header_z]);

            translate([plate_thickness / 2, plate_thickness / 2, -fudge])
            cube([header_y, header_x, header_z + 2 * fudge]);
        }

        translate([0, 0, header_z])
        difference() {
            cube([header_y + plate_thickness, header_x + plate_thickness, plate_thickness / 2]);

            translate([plate_thickness / 2, plate_thickness / 2 + 0.5, -fudge])
            cube([header_y, header_x - 1, plate_thickness + 2 * fudge]);
        }
    }

    // header to alighnment pin
    translate([-(insert_holes_xy + insert_hole_diameter + plate_thickness)/2, insert_holes_xy/2 - 4, plate_thickness])
    cube([insert_hole_diameter + plate_thickness, 4, header_z + plate_thickness / 2]);


}

module pin() {
    cylinder(d = insert_hole_diameter + plate_thickness, h = clear_z + plate_thickness, $fn = insert_pin_fn);
    cylinder(d = insert_hole_diameter - 0.1, h = insert_hole_extra_z + clear_z + plate_thickness, $fn = insert_pin_fn);

    translate([0, 0, insert_hole_extra_z + clear_z + plate_thickness]) 
    cylinder(d1 = insert_hole_diameter - 0.1, d2 = 0, h = insert_hole_extra_z / 2, $fn = insert_pin_fn);
}

module driver_board_offset_pin() {
    difference() {
        cylinder(d = driver_board_hole_diameter + plate_thickness * 1.25, h = driver_board_z_offset);
    
        translate([0, 0, driver_board_z_offset])
        screw_hole("M3,10", thread=true, bevel=true, anchor=TOP);
    }
}

module driver_board_support() {
    translate([driver_board_x/2, driver_board_y/2, 0]) 
    driver_board_offset_pin();

    translate([driver_board_x/2, -driver_board_y/2, 0]) 
    driver_board_offset_pin();

    translate([-driver_board_x/2, driver_board_y/2, 0]) 
    driver_board_offset_pin();

    translate([-driver_board_x/2, -driver_board_y/2, 0]) 
    driver_board_offset_pin();
}

main();
// driver_board_support();