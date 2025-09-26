// For James
// Haltarp (Bin) Hanger

// Time Log
//
// Charging $50/hr for design time
//
// Sept 24 -- ~2:30 to ~3:30pm -- chat at his house -- ~1hr
// Sept 26 -- 14:26-16:37 -- design -- 2h11 hr

// TODO:
// - how to split so it fits in my print volume of 256x256x256

// rod OD is ~19.4mm
//     - add felt to inside of hanging
// bin rim should be ~7" below rod center
// bin to wall is ~105mm
//     - consider if it makes sense to make this adjustable
//     - add felt to wall end
// Consider printing in Black PETG (if I have any)

// Thickness of rim
x_thickness = 5.25;
// Height of rim
z_thickness = x_thickness * 3;
// Inside diameter of circular part of the bin
bin_inside_diameter = 125;
// Inside straight section of bin
bin_straight = 180;  // approx
// Clearance around bin
bin_clearance = 0.5;
// drop arm length; 7" = 178mm
arm_length = 180;  // 7" = 178mm
// drop arm width
arm_x = z_thickness;
// drop arm thickness
arm_y = x_thickness;
// Inside diameter of rod drop arm goes over; 19mm = 3/4"
arm_id = 19.4;
// clearance around rod (for felt, etc)
arm_id_clearance = 2.1;
// radius for bottom fillet on arm
arm_fillet_r = x_thickness;
// diameter of wall support
wall_support_diameter = arm_x;
// clearance (i.e. felt) on end of wall support
wall_support_wall_clearance = arm_id_clearance;
// distance between the rod center and the wall
wall_offset = 105;  // confirm

// fudge factor for rendering
fudge = 0.1;
// circle faces
$fn=90;


// Calculated
rim_y = bin_inside_diameter + 2 * x_thickness;

upper_inside_diameter = arm_id + 2 * arm_id_clearance;
upper_outside_diameter = upper_inside_diameter + 2 * arm_y;

connecting_bar_length_z = arm_length - upper_inside_diameter - arm_y;
connecting_bar_length_y = upper_outside_diameter;
connecting_bar_length = sqrt(
    connecting_bar_length_z ^ 2
    + connecting_bar_length_y ^ 2
);

wall_support_length = wall_offset - wall_support_wall_clearance;

echo("bar z", connecting_bar_length_z, "bar y", connecting_bar_length_y, "bar c", connecting_bar_length);

support_arm_offset = (bin_straight - arm_x) / 2;


module rim() {
    // root is top of center of back, outside edge

    translate([-bin_straight / 2, -rim_y / 2, -z_thickness]) 
    difference() {
        union() {
            cylinder(h = z_thickness, d = rim_y);

            translate([bin_straight, 0, 0])
            cylinder(h = z_thickness, d = rim_y);

            translate([0, -rim_y / 2, 0])
            cube([bin_straight, rim_y, z_thickness]);
        }

        translate([0, 0, -fudge]) {
            cylinder(h = z_thickness + 2 * fudge, d = bin_inside_diameter);

            translate([bin_straight, 0, 0])
            cylinder(h = z_thickness + 2 * fudge, d = bin_inside_diameter);

            translate([0, -bin_inside_diameter / 2, 0])
            cube([bin_straight, bin_inside_diameter, z_thickness + 2 * fudge]);
        }

    }
}

module support_arm() {
    // single support arm

    translate([-arm_x / 2, upper_outside_diameter / 2, arm_length - arm_y]) { 
        // top over-rod portion
        rotate([270, 0, -90]) 
        difference() {
            cylinder(h = arm_x, d = upper_outside_diameter);

            translate([0, 0, -fudge]) 
            cylinder(h = arm_x + 2 * fudge, d = upper_inside_diameter);

            translate([-upper_outside_diameter - fudge, 0, -fudge])
            cube([
                2 * upper_outside_diameter + 2 * fudge,
                upper_outside_diameter,
                arm_x + 2 * fudge
            ]);
        }

        // straight coming off top
        translate([0, -upper_inside_diameter / 2 - arm_y, -upper_inside_diameter / 2]) 
        cube([arm_x, arm_y, upper_inside_diameter / 2]);

        // straight coming too bottom
        translate([0, upper_inside_diameter / 2, -arm_length]) 
        cube([arm_x, arm_y, upper_inside_diameter / 2 + arm_y]);

        // bar connected top and bottom
        translate([
            arm_x,
            upper_inside_diameter / 2 + arm_y,
            -upper_inside_diameter / 2 - connecting_bar_length_z
        ])
        rotate([0, 180, 0])
        rotate([169.229, 0, 0])  // ideally, calculate this angle!
        cube([arm_x, arm_y, connecting_bar_length]);

        // support "foot" (to bin)
        translate([0, -upper_outside_diameter / 2, -arm_length]) 
        cube([arm_x, upper_outside_diameter, arm_y]);

        // fillet for inside corner
        translate([0, upper_outside_diameter / 2 - 2 * arm_y, -arm_length + arm_y]) 
        difference() {
            cube([arm_x, arm_fillet_r, arm_fillet_r]);

            translate([-fudge, 0, arm_fillet_r]) 
            rotate([0, 90, 0])
            cylinder(r = arm_fillet_r, h = arm_x + 2 * fudge);
        }
    }
}

module wall_support() {
    translate([-wall_support_diameter / 2, 0, -wall_support_diameter]) {
        cube([wall_support_diameter, upper_outside_diameter, wall_support_diameter]);

        translate([wall_support_diameter / 2, 0, wall_support_diameter / 2]) 
        rotate([270, 0, 0])
        cylinder(h = wall_support_length, d = wall_support_diameter);
    }
}


module assembly() {
    rim();

    translate([support_arm_offset, 0, 0]) {
        support_arm();
        wall_support();
    }
    translate([-support_arm_offset, 0, 0]) {
        support_arm();
        wall_support();
    }

    // bar between the two drop rods
    translate([-support_arm_offset, 0, arm_length - upper_inside_diameter / 2 - arm_y]) 
    cube([support_arm_offset * 2, arm_y, upper_inside_diameter / 2]);
}

assembly();

