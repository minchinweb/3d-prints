// Adjustments to Flight Instruments to allow multi-colour printing
// Based on CaptainBobSim's Cessna 172 project
//
// Swaps the top point from being across the ring to pointing at the ring
//
// William Minchin -- 2025-12-27 -- Print 0131D

FILE_ROOT = "D:/Code/The-Cessna-172-Project-V3/Section 2 - Component Library and Structure/2-5 Instruments/6-PACK_Attitude Indicator/V2 STLs";
// Print the text this deep (to avoid back bleed)
text_depth = 1; // in mm
pointer_depth = 2; // in mm
// How wide should the marking lines be?
line_width = 1.5;
// Serial number for this print version
serial = "0131-02B";

OVERSIZE_FUDGE_FACTOR = 2;

// measured
altitude_indicator_outer_ring_d = 74.5;  // mm
// measured
altitude_indicator_inner_ring_d = 55.344;  // mm

frame_thickness = 4.75;
frame_inside_r = 36.65;
pointer_delta_z = -0.8145;

font_face = "Aldo";
font_size = 5;
// should be multiple of layer height
deboss_depth = 1;
fudge = 0.01;


my_d = altitude_indicator_outer_ring_d + OVERSIZE_FUDGE_FACTOR;
mid_disk = (altitude_indicator_inner_ring_d + altitude_indicator_outer_ring_d) / 2;
ring_width = (altitude_indicator_outer_ring_d - altitude_indicator_inner_ring_d) / 2;

module ring_base() {
    rotate([0, 0, 0]) 
    translate([-154.5, 0, 0])
    import(str(FILE_ROOT, "/", "Lil Attitude Guppy.stl"));
}

module clipped_ring() {
    _serial = serial;

    difference() {
        ring_base();

        // trim "old" nibs
        translate([0.8, 2 * frame_inside_r - 8.3, -frame_thickness / 2 - fudge])
        cube([2.8, 10, frame_thickness + 2 * fudge]);

        translate([-3.65, 2 * frame_inside_r - 8.3, -frame_thickness / 2 - fudge])
        cube([2.8, 10, frame_thickness + 2 * fudge]);
        
        // translate([0, 0, -fudge]) 
        // cylinder(d = my_d, h = text_depth + fudge);

        // part label
        translate([0, 10, -fudge])
        rotate([0, 180, 0])
        linear_extrude(deboss_depth + fudge)
        text(
            serial,
            size = font_size,
            font = font_face,
            halign = "center",
            valign = "center"
        );
    }
}


module mark_lines() {
    short_line_length = (
        altitude_indicator_inner_ring_d / 2
        + ring_width * 2/3
    );
    minor_line_width = line_width * 2 / 3;
    button_cutout_y = 10;

    color("gold") {
    
    translate([0, altitude_indicator_outer_ring_d - ring_width, pointer_delta_z]) 
    difference() {
        union() {
            translate([0, 0, 0])
            for (rot = [
                165,
                170,
                175,
                180,
                185,
                190,
                195,
            ]) {
                rotate([0, 0, rot])
                translate([-line_width/2, -OVERSIZE_FUDGE_FACTOR, 0])
                cube([
                    line_width,
                    ring_width + OVERSIZE_FUDGE_FACTOR * 2,
                    pointer_depth
                ]);
            }
        }  // union()

        translate([-5, 0, -fudge])
        cube([10, 5, pointer_depth + 2 * fudge]);

        translate([-5, -ring_width - button_cutout_y - fudge, -fudge])
        cube([10, button_cutout_y, pointer_depth + 2 * fudge]);
    }

}}

module mark_supports() {
    support_width = 26;
    drop_support_legnth = 18;
    support_angle = 37.5;  // ideally, this should be straight across the ring

    color("skyblue") {

    translate([0, altitude_indicator_outer_ring_d - 2 * ring_width, pointer_delta_z-fudge]) {
        translate([-support_width / 2, 0, 0]) 
        cube([support_width, line_width, pointer_depth - fudge]);

        translate([-support_width / 2, 0, 0])
        rotate([0, 0, support_angle])
        cube([line_width, drop_support_legnth, pointer_depth - fudge]);

        translate([support_width / 2, 0, 0])
        rotate([0, 0, 90 + ( 90 - support_angle)])
        translate([0, -drop_support_legnth, 0]) 
        cube([line_width, drop_support_legnth, pointer_depth - fudge]);

    }
}}


module clipped_mark_supports() {
    difference() {
        mark_supports();

        mark_lines();
        ring_base();
    }
}

// ring_base();
clipped_ring();

mark_lines();
clipped_mark_supports();
