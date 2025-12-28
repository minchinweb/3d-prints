// Adjustments to Flight Instruments to allow multi-colour printing
// Based on CaptainBobSim's Cessna 172 project
//
// William Minchin -- 2025-12-21 -- Print 0131C

FILE_ROOT = "D:/Code/The-Cessna-172-Project-V3/Section 2 - Component Library and Structure/2-5 Instruments/6-PACK_Attitude Indicator/V2 STLs";
// Print the text this deep (to avoid back bleed)
text_depth = 1; // in mm
// How wide should the marking lines be?
line_width = 1.5; // A - 1; B - 1.5
// Serial number for this print version
serial = "0131-01B";

OVERSIZE_FUDGE_FACTOR = 2;

// measured
altitude_indicator_outer_ring_d = 74.5;  // mm
// measured
altitude_indicator_inner_ring_d = 55.344;  // mm

font_face = "Aldo";
font_size = 5;
// should be multiple of layer height
deboss_depth = 1;
fudge = 0.01;

dispaly_font_face = "B612:style=Regular";
display_font_size = 3;  // in mm


my_d = altitude_indicator_outer_ring_d + OVERSIZE_FUDGE_FACTOR;
mid_disk = (altitude_indicator_inner_ring_d + altitude_indicator_outer_ring_d) / 2;
ring_width = (altitude_indicator_outer_ring_d - altitude_indicator_inner_ring_d) / 2;

module atitude_indicator_base() {
    rotate([0, 0, 90]) 
    translate([-110, -129, 0])
    import(str(FILE_ROOT, "/", "Roll Cover.stl"));
}

module clipped_base() {
    _serial = serial;

    difference() {
        atitude_indicator_base();
        
        translate([0, 0, -fudge]) 
        cylinder(d = my_d, h = text_depth + fudge);

        // part label
        translate([altitude_indicator_outer_ring_d / 2 - deboss_depth, 0, 5])
        rotate([0, 90, 0])
        linear_extrude(deboss_depth + fudge)
        text(
            _serial,
            size = font_size,
            font = font_face,
            halign = "right",
            valign = "center"
        );
    }
}

module sky_disk() {
    my_d = altitude_indicator_outer_ring_d + OVERSIZE_FUDGE_FACTOR;
    
    color("skyblue")
    difference() {
        intersection() {
            atitude_indicator_base();
            
            cylinder(d = my_d, h = text_depth);
            
            translate([0, -my_d/2, 0])
            cube([my_d, my_d, text_depth]);
        }
    
    mark_lines();
    }
}

module earth_disk() {  
    color("SaddleBrown")
    difference() {
        intersection() {
            atitude_indicator_base();
            
            cylinder(d = my_d, h = text_depth);
            
            translate([-my_d, -my_d/2, 0])
            cube([my_d, my_d, text_depth]);
        }
    
    mark_lines();
    }
}

module mark_lines() {
    color("snow") {
    
    short_line_length = (
        altitude_indicator_inner_ring_d / 2
        + ring_width * 2/3
    );
    dot_d = line_width * 2;
    minor_line_width = line_width * 2 / 3;

    translate([altitude_indicator_inner_ring_d/2, 0, 0])
    for (rot = [
        -75,
        -80,
        -85,
        -90,
        -95,
        -100,
        -105
    ]) {
        rotate([0, 0, rot])
        translate([-line_width/2, -OVERSIZE_FUDGE_FACTOR, 0])
        cube([
            line_width,
            ring_width + OVERSIZE_FUDGE_FACTOR * 2,
            text_depth
        ]);
    }
    
    
    for (rot = [0, -30, -60, -120, -150, 180]) {
        rotate([0, 0, rot])
        translate([-line_width/2, 0, 0])
        cube([line_width, my_d/2, text_depth]);
    }
    
    for (rot = [-70, -80, -100, -110]) {
        rotate([0, 0, rot])
        translate([-minor_line_width/2, 0, 0])
        cube([minor_line_width, short_line_length, text_depth]);
    }
    
    // dots at 45 degress
    for (rot = [-45, -135]) {
        rotate([0, 0, rot])
        translate([0, mid_disk / 2, 0])
        cylinder(d = dot_d, h = text_depth, $fn=12);
    }    
}}

module clipped_mark_lines() {
    // the mark lines, but for printing, so only where they fall on the disk
    
    intersection() {
        mark_lines();
        
        difference() {
            cylinder(d = altitude_indicator_outer_ring_d, h = text_depth);

            cylinder(d = altitude_indicator_inner_ring_d, h = text_depth);
        }
    }
}


//atitude_indicator_base();

clipped_base();
sky_disk();
earth_disk();
clipped_mark_lines();



