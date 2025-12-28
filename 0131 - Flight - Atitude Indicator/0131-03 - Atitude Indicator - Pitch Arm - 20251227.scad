// Adjustments to Flight Instruments to allow multi-colour printing
// Based on CaptainBobSim's Cessna 172 project
//
// Add markings to be printed directly
//
// William Minchin -- 2025-12-21 -- Print 0131C

FILE_ROOT = "D:/Code/The-Cessna-172-Project-V3/Section 2 - Component Library and Structure/2-5 Instruments/6-PACK_Attitude Indicator/V2 STLs";
// Print the text this deep (to avoid back bleed)
text_depth = 1; // in mm
// How wide should the marking lines be?
line_width = 1.5; // A - 1; B - 1.5
// Serial number for this print version
serial = "0131-03A";

OVERSIZE_FUDGE_FACTOR = 2;

// measured
outer_arm_width = 68.24;  // mm
// measured
arm_length = 42;  // mm

magnet_d = 6.2;  // Gridfinity, Print 0061E
magnet_depth = 2.3;

y_back_of_display = 13; // mm

font_face = "Aldo";
font_size = 5;
// should be multiple of layer height
deboss_depth = 1;
fudge = 0.01;


// my_d = altitude_indicator_outer_ring_d + OVERSIZE_FUDGE_FACTOR;
// mid_disk = (altitude_indicator_inner_ring_d + altitude_indicator_outer_ring_d) / 2;
// ring_width = (altitude_indicator_outer_ring_d - altitude_indicator_inner_ring_d) / 2;

module pitch_arm_base() {
    rotate([0, 0, 90 * 0]) 
    translate([-110 * 0, -129 * 0, 0])
    import(str(FILE_ROOT, "/", "Pitch Arm (Doohicky).stl"));
}

module clipped_base() {
    _serial = serial;

    difference() {
        pitch_arm_base();

        // magnet hole
        translate([-outer_arm_width / 2 - 2.7, 22.3, 0])
        rotate([0, 90, 0])
        cylinder(d = magnet_d, h = magnet_depth + 5, $fn=24);

        intersection() {
            // not clipped, or you hit recursion
            mark_lines();

            // clip to front of display
            translate([-50, y_back_of_display - 30, -50])
            cube([100, 30, 100]); 
        }

        // part label
        translate([outer_arm_width / 2 - deboss_depth, 27, 0])
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


module mark_lines() {
    y_center = 6.25;
    face_font_size = 3;  // in mm
    // face_font_face = "B612:style=Regular";
    face_font_face = "B612:style=Bold";

    small_line_width = line_width * 2/3;

    color("snow") {

    // horizon line
    translate([-outer_arm_width / 2, y_center, -line_width / 2])
    cube([outer_arm_width, line_width, text_depth + fudge]);

    // ground forward lines
    translate([0, y_center, 0])
    for (rot = [
        -70,
        -35,
        35,
        70,
    ]) {
        rotate([0, rot, 0])
        translate([-small_line_width/2, 0, -30 + 1.2 - 0.039 * abs(rot)])
        cube([
            small_line_width,
            // text_depth,
            7,
            30
        ]);
    }


    // pitch up lines
    center_width_plus = 8;
    edge_width_plus = outer_arm_width - center_width_plus - 2 * 6;
    text_width_plus = 7;
    translate([0, arm_length + 2, 0])
    for (rot = [
        10,
        20,
    ]) {
        rotate([180 - rot, 0, 0]) {
            // translate([-center_width_plus / 2 - edge_width_plus - text_width_plus, 0, -line_width/2])
            // cube([edge_width_10, arm_length, line_width]);

            translate([-center_width_plus / 2 - text_width_plus / 2, arm_length - 10, 0])
            rotate([270, 0, 0])
            linear_extrude(10)
            text(
                str(rot),
                size = face_font_size,
                font = face_font_face,
                halign = "center",
                valign = "center"
            );

            translate([-center_width_plus / 2, 0, -line_width/2])
            cube([center_width_plus, arm_length, line_width]);

            translate([center_width_plus / 2 + text_width_plus / 2, arm_length - 10, 0])
            rotate([270, 0, 0])
            linear_extrude(10)
            text(
                str(rot),
                size = face_font_size,
                font = face_font_face,
                halign = "center",
                valign = "center"
            );

            // translate([center_width_plus / 2 + text_width_plus, 0, -line_width/2])
            // cube([edge_width_plus, arm_length, line_width]);
        }
    }

    // 10 degrees pitch down
    center_width_10 = 12;
    edge_width_10 = outer_arm_width - center_width_10 - 2 * 6;
    text_width_10 = 7;
    translate([0, arm_length + 2, 0])
    rotate([180 + 10, 0, 0]) {
        translate([-center_width_10 / 2 - edge_width_10 - text_width_10, 0, -line_width/2])
        cube([edge_width_10, arm_length, line_width]);

        translate([-center_width_10 / 2 - text_width_10 / 2, arm_length - 10, 0])
        rotate([270, 0, 0])
        linear_extrude(10)
        text(
            "10",
            size = face_font_size,
            font = face_font_face,
            halign = "center",
            valign = "center"
        );

        translate([-center_width_10 / 2, 0, -line_width/2])
        cube([center_width_10, arm_length, line_width]);

        translate([center_width_10 / 2 + text_width_10 / 2, arm_length - 10, 0])
        rotate([270, 0, 0])
        linear_extrude(10)
        text(
            "10",
            size = face_font_size,
            font = face_font_face,
            halign = "center",
            valign = "center"
        );

        translate([center_width_10 / 2 + text_width_10, 0, -line_width/2])
        cube([edge_width_10, arm_length, line_width]);
    }

    // 20 degrees pitch down
    center_width_20 = 21;
    edge_width_20 = outer_arm_width - center_width_20 - 2 * 6;
    text_width_20 = 7;
    translate([0, arm_length + 2, 0])
    rotate([180 + 20, 0, 0]) {
        translate([-center_width_20 / 2 - edge_width_20 - text_width_20, 0, -line_width/2])
        cube([edge_width_20, arm_length, line_width]);

        translate([-center_width_20 / 2 - text_width_20 / 2, arm_length - 10, 0])
        rotate([270, 0, 0])
        linear_extrude(10)
        text(
            "20",
            size = face_font_size,
            font = face_font_face,
            halign = "center",
            valign = "center"
        );

        translate([-center_width_20 / 2, 0, -line_width/2])
        cube([center_width_20, arm_length, line_width]);

        translate([center_width_20 / 2 + text_width_20 / 2, arm_length - 10, 0])
        rotate([270, 0, 0])
        linear_extrude(10)
        text(
            "20",
            size = face_font_size,
            font = face_font_face,
            halign = "center",
            valign = "center"
        );

        translate([center_width_20 / 2 + text_width_20, 0, -line_width/2])
        cube([edge_width_20, arm_length, line_width]);
    }


    // small lines at inbetween pitches
    center_width_small = 4;
    translate([0, arm_length + 2, 0])
    for (rot = [
        25,
        15,
        5,
        -5,
        -15,
        -25,
    ]) {
        rotate([180 - rot, 0, 0]) {
            translate([-center_width_small / 2, 0, -small_line_width/2])
            cube([center_width_small, arm_length, small_line_width]);
        }
    }
}
}

module clipped_mark_lines() {
    color("snow")
    difference() {
        intersection() {
            mark_lines();
            pitch_arm_base();
        }

        translate([-50, y_back_of_display, -50])
        cube([100, 100, 100]); 
    }       
}


module sky_base_front() {
    color("skyblue")
    difference() {
        intersection() {
            clipped_base();

            translate([-50, 0, 0]) 
            cube([100, 100, 100]);
        }

        translate([-50, y_back_of_display, -50])
        cube([100, 100, 100]); 
    }
}

module earth_base_front() {
    color("SaddleBrown")
    difference() {
        intersection() {
            clipped_base();

            translate([-50, 0, -100]) 
            cube([100, 100, 100]);
        }

        translate([-50, y_back_of_display, -50])
        cube([100, 100, 100]); 
    }
}

module sky_base_arm() {
    color("green")
    intersection() {
        intersection() {
            clipped_base();

            translate([-50, 0, 0]) 
            cube([100, 100, 100]);
        }

        translate([-50, y_back_of_display, -50])
        cube([100, 100, 100]); 
    }
}

module earth_base_arm() {
    color("orange")
    intersection() {
        intersection() {
            clipped_base();
            // pitch_arm_base();

            translate([-50, 0, -100]) 
            cube([100, 100, 100]);
        }

        translate([-50, y_back_of_display, -50])
        cube([100, 100, 100]); 
    }
}

// clipped_base();
// mark_lines();

// color("yellow")
clipped_mark_lines();

sky_base_front();
earth_base_front();
sky_base_arm();
earth_base_arm();
