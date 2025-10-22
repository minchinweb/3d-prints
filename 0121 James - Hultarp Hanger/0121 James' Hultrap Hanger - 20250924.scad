// For James
// Haltarp (Bin) Hanger

// Time Log
//
// Charging $50/hr for design time
//
// Sept 24 -- ~2:30 to ~3:30pm -- chat at his house -- ~1hr
// Sept 26 -- 14:26-16:37 -- design -- 2h11 hr
// Oct 7   -- 16:23-16:57 -- split design -- 0h34 hr
// Oct 8   -- 11:50-12:55, 13:37-15:23 -- split design, set up for print -- 2h51 hr
//         -- ~3hr printing
// Oct 9   -- 10:15-11:11 -- clean up design based on print A -- 0h56 hr
//         -- ~3hr + ~0h45 printing
//         -- 15:06 - 15:38 -- assembly -- 0h32 hr
// Oct 10  -- dropped off print; he paid me $400 (8 hr)
//         -- got the go-ahead for companion recipe holder (make it come in under $400)
// Oct 16  -- 14:42 - 15:41 -- trying to simply model for better rendering -- 0h59
//         -- 20:51 - 21:24 -- increase drop arm front fillet -- 0h33
//         -- 21:54 - 21:38 -- tighten up nut hole, setup C print -- 0h44
//         -- ~0h45 printing, using rectilinear infill
//         -- 21:38 - 22:18 -- design of book support -- 0h40
// Oct 18  -- 15:00 - 16:07 -- design of upper book support -- 1h07
//         -- 18:24 - 19:30 -- design of wall supports for book support -- 1h06
//         -- 19:30 - -- printing prep and printing
// Oct 21  -- 13:17-1401 -- prep models for printing
//         -- printing 3x1hr
//         -- 19:45-20:20 -- calibration cube for screw and nut holes
//         -- printing 0h20hr


// TODO:
// - add top crossbar?
// - add screws to back of wall supports?
// - pull hardware dimensions out into a separate library
// - current (B print) nut slots are too wide, and so the nuts spin in the slot
// - consider strengthening fillet on hangers

// rod OD is ~19.4mm
//     - add felt to inside of hanging
// bin rim should be ~7" below rod center
// bin to wall is ~105mm
//     - consider if it makes sense to make this adjustable
//     - add felt to wall end
// Consider printing in Black PETG (if I have any)
//
// Want recipe holder to come ~118mm below rim top
// Want recipe holder to clear the top hangers at their angle

// Thickness of rim (5.25mm appears to be the original design, 7.0mm fits a M3 wafer head screw)
x_thickness = 7.0;
// Height of rim
z_thickness = 15;
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
// radius for bottom fillet on arm (for B, was x_thickness or 7mm)
arm_fillet_r = 22;
// shift the arm fillet forward this amount; needed for larger diameters
arm_fillet_plus_y = 3;
// extend arm fillet this amount straight up on the back
arm_fillet_plus_z = 5;
// number of faces to use for fillet
arm_fillet_fn = 48;
// diameter of wall support
wall_support_diameter = arm_x;
// clearance (i.e. felt) on end of wall support
wall_support_wall_clearance = arm_id_clearance;
// distance between the rod center and the wall
wall_offset = 105;  // confirm
// number of faces to use for rim (set here rather than globally)
rim_fn = 90;

// book support width
book_x = 200;
// book support thickness
book_y = 2;
// book support height
book_z = 200;
// book support ledge depth
book_support_y = 15;
// book support ridge spacing
ridge_spacing = 4.1;
// book support ridge height
ridge_height = 2.5;
// book support backing angle (in degrees)
book_theta = 20;
// book support bottom delta
book_support_drop_z = 118;
// book support additional arm length
book_extra_y = 112.53;
// upward extention of book support frame
book_upper_z = 200;


// from Seeding Robot project (reference only)
m3_wafer_head_diameter = 6.9;
m3_wafer_head_thickness = 0.76;

m3_nut_diameter_slip_fit = 6.2;
m3_nut_height_slip_fit = 2.5;


// M3 clear outside diameter (nominal diameter of 3 mm)
m3_od = 3.5;  // at 3.5mm, it could be tighter, but the play isn't excessive
// M3 wafer head diamter
m3_head_od = 5.8 + 0.25;  // was 6.9mm, but had too much play
// M3 water head height
m3_head_z = 0.80;  // was 0.76mm, nominally 0.7mm, set to multiple of layer height
// M3 nut across the "flats"
m3_nut_flats = 5.6;  // nominally 5.35mm and was 5.4mm, but gives no clearance; if 6.2mm the nut can turn freely
// M3 nut width clearance
m3_nut_z = 2.6;  // measured at 2.28mm, was 2.5mm and could be a hair looser
// circle faces for screw shaft (double for head)
screw_fn = 12;

// length of M3 screw joining the drop hangers to the oval
m3_y1 = 21;
// length of M3 screws joining the front of the oval (vertical)
m3_y2 = 12.5;
// length of M3 screws on the wall support side
m3_y3 = 21;
// length of M3 screws in upper book support to drop arms
m3_y4 = 10;  // use M3x8
// nut offset for screw joining drop hangers to the oval (to close side of nut)
m3_nut_offset_1 = 10;
// nut offset for screw joining the rim together (to top of nut)
m3_nut_offset_2 = 10;
// nut offset for screw holding in the wall supports (to "front" of nut, closest to the wall)
m3_nut_offset_3 = 3;
// nut offset for screw holding upper book support to drop arms
m3_nut_offset_4 = book_y * 2 + 3;

// support arm legnth (on rim)
// support_x = z_thickness * 2;
support_x = arm_x;

// how much of the rim support is in the top
support_z_percent = 0.3;

font_face = "Aldo";
font_size = 5;
deboss_depth = 1;  // should be multiple of layer height

// printing layer height
layer_height = 0.2;
// fudge factor for rendering
fudge = 0.1;


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

// distance from centerline of bin to centerline of arm (?)
support_arm_offset = (bin_straight - arm_x) / 2;

// number of book support ridges
ridge_count = floor(book_support_y / (ridge_height + ridge_spacing));
echo("(book support) ridge count", ridge_count);

// upper arm single height length
upper_support_signle_z = book_z - book_support_drop_z;

module m3_screw(length = 10, overhangs = 0) {
    // overhangs: 0 or 1 -- improvements for printing as overhang; gives height
    //                      in layers

    // head
    translate([0, 0, -fudge]) 
    cylinder(d = m3_head_od, h = m3_head_z + fudge, $fn = 2 * screw_fn);

    // shaft
    cylinder(d = m3_od, h = length, $fn = screw_fn);

    if (overhangs != 0) {
        // print overhang helps
        intersection() {
            translate([-m3_od / 2, -m3_head_od / 2, m3_head_z])
            cube([m3_od, m3_head_od, layer_height * overhangs]);

            translate([0, 0, m3_head_z]) 
            cylinder(
                d = m3_head_od,
                h = layer_height * (overhangs),
                $fn = 2 * screw_fn
            );
        }

        intersection() {
            translate([
                -m3_od / 2,
                -m3_od / 2,
                m3_head_z + layer_height * overhangs
            ])
            cube([m3_od, m3_od, layer_height * overhangs]);

            translate([
                -m3_od / 2,
                -m3_head_od / 2,
                m3_head_z + layer_height * overhangs
            ])
            cube([m3_od, m3_head_od, layer_height * overhangs]);

            translate([
                0,
                0,
                m3_head_z + layer_height * overhangs
            ])
            cylinder(
                d = m3_head_od,
                h = layer_height * overhangs,
                $fn = 2 * screw_fn
            );
        }
    }
}

module m3_nut() {
    // assuming slip fit

    // distance across flats / cos(30) = distance across corners (aka "diameter")

    cylinder(d = m3_nut_flats / cos(30), h = m3_nut_z, $fn=6);
}

module m3_nut_slot(shaft_offset = 0) {
    translate([0, 0, shaft_offset]) {
        rotate([0, 0, 30])
        m3_nut();

        translate([m3_nut_flats / 2, 0, 0])
        rotate([0, 0, 180])
        cube([m3_nut_flats, 20, m3_nut_z]);
    }
}

module screw_holes(
    wall = 0,
    back_rim = 0,
    front_rim = 0,
    book_support_upper_screws = 0,
    book_support_lower_screws = 0,
) {
    // screws used to hold this together. Designed to be used as a void.

    // rim into drop arms
    if (back_rim != 0) {
        // far right
        translate([support_arm_offset, -x_thickness - fudge, -z_thickness/2])
        rotate([-90, 0, 0]) {
            m3_screw(length = m3_y1);
            m3_nut_slot(shaft_offset = m3_nut_offset_1);
        }

        // centered
        translate([0, -x_thickness - fudge, -z_thickness/2])
        rotate([-90, 0, 0]) {
            m3_screw(length = m3_y1);
            m3_nut_slot(shaft_offset = m3_nut_offset_1);
        }

        // far left
        translate([-support_arm_offset, -x_thickness - fudge, -z_thickness/2])
        rotate([-90, 0, 0]) {
            m3_screw(length = m3_y1);
            m3_nut_slot(shaft_offset = m3_nut_offset_1);
        }
    }

    // back (wall side) of drop arms
    if (wall != 0) {
        translate([support_arm_offset, wall_support_length, -z_thickness/2 - 2 * fudge])
        rotate([-90, 0, 180]) {
            m3_screw(length = m3_y3);
            m3_nut_slot(shaft_offset = m3_nut_offset_3);
        }

        translate([-support_arm_offset, wall_support_length, -z_thickness/2 - 2 * fudge])
        rotate([-90, 0, 180]) {
            m3_screw(length = m3_y3);
            m3_nut_slot(shaft_offset = m3_nut_offset_3);
        }
    }

    // back rim
    if (back_rim != 0) {
        // far left
        translate([
            -support_arm_offset + arm_x / 2 + support_x / 2,
            -x_thickness / 2,
            fudge
        ])
        rotate([180, 0, 180]) {
            m3_screw(length = m3_y2, overhangs = 1);
            m3_nut_slot(shaft_offset = m3_nut_offset_2);
        }

        // far right
        translate([
            support_arm_offset - arm_x / 2 - support_x / 2,
            -x_thickness / 2,
            fudge
        ])
        rotate([180, 0, 180]) {
            m3_screw(length = m3_y2, overhangs = 1);
            m3_nut_slot(shaft_offset = m3_nut_offset_2);
        }
    }

    // front rim
    if (front_rim != 0) {
        translate([
            -support_arm_offset + arm_x / 2 + support_x / 2,
            -x_thickness / 2 - bin_inside_diameter - x_thickness,
            fudge
        ])
        rotate([180, 0, 0]) {
            m3_screw(length = m3_y2, overhangs = 1);
            m3_nut_slot(shaft_offset = m3_nut_offset_2);
        }

        translate([
            support_arm_offset - arm_x / 2 - support_x / 2,
            -x_thickness / 2 - bin_inside_diameter - x_thickness,
            fudge
        ])
        rotate([180, 0, 0]) {
            m3_screw(length = m3_y2, overhangs = 1);
            m3_nut_slot(shaft_offset = m3_nut_offset_2);
        }
    }

    // upper support arms for book support
    if (book_support_upper_screws != 0){
        translate([support_arm_offset, upper_outside_diameter / 2, arm_length - arm_y])
        rotate([-book_theta, 0, 0])
        translate([0, -upper_outside_diameter / 2, -24])
        rotate([-90, 90, 0]) {
            m3_screw(length = m3_y4, overhangs = 0);
            m3_nut_slot(shaft_offset = m3_nut_offset_4);
        }

        translate([-support_arm_offset, upper_outside_diameter / 2, arm_length - arm_y])
        rotate([-book_theta, 0, 0])
        translate([0, -upper_outside_diameter / 2, -24])
        rotate([-90, 90, 0]) {
            m3_screw(length = m3_y4, overhangs = 0);
            m3_nut_slot(shaft_offset = m3_nut_offset_4);
        }
    }

    // lower support arms for book support
    if (book_support_lower_screws != 0){
        // upper screws
        translate([support_arm_offset, upper_outside_diameter / 2, arm_length - arm_y])
        rotate([-book_theta, 0, 0])
        translate([0, -upper_outside_diameter / 2, -159])
        rotate([-90, 90, 0]) {
            m3_screw(length = m3_y4, overhangs = 0);
            m3_nut_slot(shaft_offset = m3_nut_offset_4);
        }

        translate([-support_arm_offset, upper_outside_diameter / 2, arm_length - arm_y])
        rotate([-book_theta, 0, 0])
        translate([0, -upper_outside_diameter / 2, -159])
        rotate([-90, 90, 0]) {
            m3_screw(length = m3_y4, overhangs = 0);
            m3_nut_slot(shaft_offset = m3_nut_offset_4);
        }

        // mid screws
        translate([support_arm_offset, upper_outside_diameter / 2, arm_length - arm_y])
        rotate([-book_theta, 0, 0])
        translate([0, -upper_outside_diameter / 2, -195])
        rotate([-90, 90, 0]) {
            m3_screw(length = m3_y4, overhangs = 0);
            m3_nut_slot(shaft_offset = m3_nut_offset_4);
        }

        translate([-support_arm_offset, upper_outside_diameter / 2, arm_length - arm_y])
        rotate([-book_theta, 0, 0])
        translate([0, -upper_outside_diameter / 2, -195])
        rotate([-90, 90, 0]) {
            m3_screw(length = m3_y4, overhangs = 0);
            m3_nut_slot(shaft_offset = m3_nut_offset_4);
        }

        // lower screws
        translate([support_arm_offset, upper_outside_diameter / 2, arm_length - arm_y])
        rotate([-book_theta, 0, 0])
        translate([0, -upper_outside_diameter / 2, -231])
        rotate([-90, 90, 0]) {
            m3_screw(length = m3_y4, overhangs = 0);
            m3_nut_slot(shaft_offset = m3_nut_offset_4);
        }

        translate([-support_arm_offset, upper_outside_diameter / 2, arm_length - arm_y])
        rotate([-book_theta, 0, 0])
        translate([0, -upper_outside_diameter / 2, -231])
        rotate([-90, 90, 0]) {
            m3_screw(length = m3_y4, overhangs = 0);
            m3_nut_slot(shaft_offset = m3_nut_offset_4);
        }
    }
}


module rim_straight_only() {
    // this is just the front and back edge of the rim. Used to simplify
    // rendering

    translate([-bin_straight / 2, -rim_y / 2, -z_thickness])
    difference() {
        translate([0, -rim_y / 2, 0])
        cube([bin_straight, rim_y, z_thickness]);

        translate([-fudge, 0, -fudge]) {
            translate([0, -bin_inside_diameter / 2, 0])
            cube([bin_straight + 2 * fudge, bin_inside_diameter, z_thickness + 2 * fudge]);
        }

        translate([bin_straight / 2, rim_y / 2, z_thickness])
        screw_holes(back_rim = 1, front_rim = 1);
    }
}

module rim() {
    // rim as a single piece (too big to fit on my printer)
    // root is top of center of back, outside edge

    // wrap in `render()` to cache the results ?

    // render() {
    translate([-bin_straight / 2, -rim_y / 2, -z_thickness])
    difference() {
        union() {
            cylinder(h = z_thickness, d = rim_y, $fn=rim_fn);

            translate([bin_straight, 0, 0])
            cylinder(h = z_thickness, d = rim_y, $fn=rim_fn);

            translate([0, -rim_y / 2, 0])
            cube([bin_straight, rim_y, z_thickness]);
        }

        translate([0, 0, -fudge]) {
            cylinder(h = z_thickness + 2 * fudge, d = bin_inside_diameter, $fn=rim_fn);

            translate([bin_straight, 0, 0])
            cylinder(h = z_thickness + 2 * fudge, d = bin_inside_diameter, $fn=rim_fn);

            translate([0, -bin_inside_diameter / 2, 0])
            cube([bin_straight, bin_inside_diameter, z_thickness + 2 * fudge]);
        }

        translate([bin_straight / 2, rim_y / 2, z_thickness])
        screw_holes(back_rim = 1, front_rim = 1);
    }
    // }  // render()
}

module support_arm(for_book_support = 0) {
    // single support arm
    _serial =  (for_book_support == 0) ? "WM 0121-01D" : "WM 0121-08D";
    //                                   ^ bin arm       ^ book arm   

    difference() {
        union() {
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
                rotate([
                    168.478,  // TODO: ideally, calculate this angle!
                    0,
                    0
                ])
                cube([arm_x, arm_y, connecting_bar_length]);

                // support "foot" (to bin)
                translate([0, -upper_outside_diameter / 2, -arm_length]) 
                cube([arm_x, upper_outside_diameter, arm_y]);

                // fillet for inside corner
                translate([
                    0,
                    upper_outside_diameter / 2 - arm_y - arm_fillet_r - arm_fillet_plus_y,
                    -arm_length + arm_y
                ]) {
                    difference() {
                        cube([
                            arm_x,
                            arm_fillet_r + arm_fillet_plus_y,
                            arm_fillet_r
                        ]);

                        translate([-fudge, 0, arm_fillet_r]) 
                        rotate([0, 90, 0])
                        cylinder(
                            r = arm_fillet_r,
                            h = arm_x + 2 * fudge,
                            $fn = arm_fillet_fn
                        );
                    }

                    if (arm_fillet_plus_z != 0) {
                        translate([0, arm_fillet_r, arm_fillet_r]) 
                        cube([
                            arm_x,
                            arm_fillet_plus_y,
                            arm_fillet_plus_z
                        ]);
                    }
                }
            }

            // wall support
            translate([-wall_support_diameter / 2, 0, -wall_support_diameter]) {
                cube([wall_support_diameter, upper_outside_diameter, wall_support_diameter]);

                translate([wall_support_diameter / 2, 0, wall_support_diameter / 2]) 
                rotate([270, 0, 0])
                cylinder(h = wall_support_length, d = wall_support_diameter);

                // turn the wall support into a cube for easier printing
                cube([wall_support_diameter, wall_support_length, wall_support_diameter]);
            }

            if (for_book_support == 1) {
                // book support main support
                translate([-wall_support_diameter / 2, -book_extra_y / 2, -wall_support_diameter])
                cube([wall_support_diameter, book_extra_y / 2, wall_support_diameter]);

                // book support back plate
                translate([
                    -wall_support_diameter / 2,
                    -book_extra_y,
                    -wall_support_diameter - book_support_drop_z
                ])
                rotate([-book_theta, 0, 0])
                translate([0, book_y * 2, book_z / 2 - 5]) {
                    cube([
                        wall_support_diameter,
                        wall_support_diameter,
                        2 * arm_fillet_r + 3 * wall_support_diameter - 3.9
                    ]);

                    // bottom "catch"
                    translate([0, -book_y, 0]) 
                    cube([
                        wall_support_diameter,
                        book_y,
                        22.8  // leave a 0.2mm gap here for fit
                    ]);

                    // fillet for book support (upper only)
                    translate([0, wall_support_diameter, 62.8])
                    difference() {
                        _increated_z = 10;
                        translate([0, 0, -_increated_z])
                        cube([
                            wall_support_diameter,
                            arm_fillet_r + 8,
                            arm_fillet_r + _increated_z
                        ]);

                        translate([-fudge, arm_fillet_r, arm_fillet_r]) 
                        rotate([0, 90, 0])
                        cylinder(
                            r = arm_fillet_r,
                            h = wall_support_diameter + 2 * fudge,
                            $fn = arm_fillet_fn
                        );
                    }
                }

                // book support top support
                translate([-arm_x / 2, upper_outside_diameter / 2, arm_length - arm_y])
                rotate([-book_theta, 0, 0])
                translate([0, -upper_outside_diameter / 2 + 2 * book_y, -30]) {
                    cube([arm_x, arm_y, 15]);

                    translate([0, arm_y / 2, 0])
                    cube([arm_x, arm_y, 7.5]);
                }
            }  // for_book_support
        }  // union

        translate([support_arm_offset, 0, 0])
        if (for_book_support == 0) {
            screw_holes(wall = 1, back_rim = 1);
        } else if (for_book_support == 1) {
            screw_holes(
                wall = 1,
                book_support_upper_screws = 1,
                book_support_lower_screws = 1,
            );
        }

        // part label
        translate([0, wall_support_diameter, -wall_support_diameter + deboss_depth - fudge])
        rotate([180, 0, 90])
        linear_extrude(deboss_depth + fudge)
        text(
            _serial,
            size = font_size,
            font = font_face,
            halign = "left",
            valign = "center"
        );
    }
}

// module wall_support() {
//     translate([-wall_support_diameter / 2, 0, -wall_support_diameter]) {
//         cube([wall_support_diameter, upper_outside_diameter, wall_support_diameter]);

//         translate([wall_support_diameter / 2, 0, wall_support_diameter / 2]) 
//         rotate([270, 0, 0])
//         cylinder(h = wall_support_length, d = wall_support_diameter);
//     }
// }

module rim_ends() {
    difference() {
        rim();

        // interface with centre beam
        translate([
            -support_arm_offset + arm_x / 2,
            -1 * (bin_inside_diameter + 2 * x_thickness) - fudge,
            -support_z_percent * (z_thickness + fudge)
        ])
        cube([
            2 * support_arm_offset - arm_x,
            bin_inside_diameter + 2 * x_thickness + 2 * fudge,
            z_thickness + 2 * fudge
        ]);

        // chop center out
        translate([
            -1 * (support_arm_offset - arm_x / 2 - support_x),
            -1 * (bin_inside_diameter + 2 * x_thickness) - fudge,
            -1 * (z_thickness + fudge)
        ])
        cube([
            2 * support_arm_offset - arm_x - 2 * support_x,
            bin_inside_diameter + 2 * x_thickness + 2 * fudge,
            z_thickness + 2 * fudge
        ]);
    }
}

module rim_end_left() {
    _serial = "WM 0121-02D";
    
    render() {
    difference() {
        rim_ends();

        translate([
            0,
            -1 * (bin_inside_diameter + 2 * x_thickness) - fudge,
            -1 * (z_thickness + fudge)
        ])
        cube([
            bin_straight / 2 + bin_inside_diameter + x_thickness + fudge,
            bin_inside_diameter + 2 * x_thickness + 2 * fudge,
            z_thickness + 2 * fudge
        ]);

        // part label
        translate([-bin_straight / 2 - 6, -x_thickness / 2, -z_thickness + deboss_depth])
        rotate([180, 0, 0])
        linear_extrude(deboss_depth + fudge)
        text(
            _serial,
            size = font_size,
            font = font_face,
            halign = "left",
            valign = "center"
        );
    }
    }  // render()
}

module rim_end_right(){
    _serial = "WM 0121-03D";

    render() {
    difference() {
        rim_ends();

        translate([
            -1 * (bin_straight / 2 + bin_inside_diameter + x_thickness + fudge),
            -1 * (bin_inside_diameter + 2 * x_thickness) - fudge,
            -1 * (z_thickness + fudge)
        ])
        cube([
            bin_straight / 2 + bin_inside_diameter + x_thickness + 2 * fudge,
            bin_inside_diameter + 2 * x_thickness + 2 * fudge,
            z_thickness + 2 * fudge
        ]);

        // part label
        translate([bin_straight / 2 + 6, -x_thickness / 2, -z_thickness + deboss_depth])
        rotate([180, 0, 0])
        linear_extrude(deboss_depth + fudge)
        text(
            _serial,
            size = font_size,
            font = font_face,
            halign = "right",
            valign = "center"
        );
    }  // difference()
    }  // render()
}

module rim_crossbars() {
    // quick render doesn't show what the actual part; full render works
    difference() {
        rim();

        rim_end_left();
        rim_end_right();
    }
}

module rim_crossbar_front() {
    _serial = "WM 0121-04D";

    difference() {
        rim_crossbars();

        translate([
            -2 * bin_straight,
            -bin_inside_diameter / 2,
            -z_thickness - fudge
        ])
        cube([
            4 * bin_straight,
            bin_inside_diameter,
            z_thickness + 2 * fudge
        ]);

        // part label
        translate([0, -x_thickness * 3 / 2 - bin_inside_diameter, -z_thickness + deboss_depth])
        rotate([180, 0, 0])
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

module rim_crossbar_back() {
    // for some reason, this includes the text from the rim ends
    // can just use a second x04 part
    _serial = "WM 0121-05D";

    difference() {
        rim_crossbars();

        translate([
            -2 * bin_straight,
            -bin_inside_diameter * 3 / 2,
            -z_thickness - fudge
        ])
        cube([
            4 * bin_straight,
            bin_inside_diameter,
            z_thickness + 2 * fudge
        ]);

        // part label
        translate([0, -x_thickness / 2, -z_thickness + deboss_depth])
        rotate([180, 0, 0])
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

module book_support() {
    _serial = "WM 0121-06D";

    difference() {
        translate([-book_x / 2, -book_extra_y, -wall_support_diameter - book_support_drop_z])
        rotate([-book_theta, 0, 0]) {
            difference() {
                cube([book_x, book_y, book_z]);

                // part label
                translate([book_x - 7, deboss_depth, 5])
                rotate([90, 0, 180])
                linear_extrude(deboss_depth + fudge)
                text(
                    _serial,
                    size = font_size,
                    font = font_face,
                    halign = "left",
                    valign = "baseline"
                );

            }

            translate([0, -book_support_y, 0])
            cube([book_x, book_support_y, book_y]);

            for(i = [0 : ridge_count]) {
                translate([
                    0,
                    - i * (ridge_height + ridge_spacing),
                    0.2
                ])
                rotate([45, 0, 0])
                cube([book_x, ridge_height, ridge_height]);
            }
        }

        screw_holes(book_support_lower_screws = 1);
    }
}

module book_support_upper() {
    _serial = "WM 0121-07D";

    difference() {
        // setup the same the the (lower) book support
        translate([-book_x / 2, -book_extra_y, -wall_support_diameter - book_support_drop_z])
        rotate([-book_theta, 0, 0])
        // now move relative to the (lower) book support
        translate([book_x / 2, book_y, book_support_drop_z]) {
            // right arm
            translate([support_arm_offset - arm_x / 2, 0, 0])
            cube([arm_x, book_y, book_upper_z]);

            translate([support_arm_offset - arm_x / 2, -book_y, upper_support_signle_z])
            cube([arm_x, book_y, book_upper_z - upper_support_signle_z]);

            // left arm
            translate([-support_arm_offset - arm_x / 2, 0, 0])
            difference() {
                cube([arm_x, book_y, book_upper_z]);

                // part label
                translate([arm_x / 2, 0 + deboss_depth, upper_support_signle_z + 5])
                rotate([90, 270, 180])
                linear_extrude(deboss_depth + fudge)
                text(
                    _serial,
                    size = font_size,
                    font = font_face,
                    halign = "left",
                    valign = "center"
                );
            }

            translate([-support_arm_offset - arm_x / 2, -book_y, upper_support_signle_z])
            cube([arm_x, book_y, book_upper_z - upper_support_signle_z]);

            // tranverse
            translate([-support_arm_offset - arm_x / 2, -book_y, book_upper_z - arm_x])
            cube([support_arm_offset * 2 + arm_x, book_y * 2, arm_x]);
        }

        screw_holes(book_support_upper_screws = 1, book_support_lower_screws = 1);
    }
}


module clearance_test() {
    // creates a small cube with a recessed screw hole and nut slot, to confirm
    // clearances
    
    _serial = "0121-D";
    _countersunk_depth = m3_head_z;
    _countersink_diameter = m3_head_od;
    _nut_flats = m3_nut_flats;
    _nut_z = m3_nut_z;

    // _text_str = str(_serial) + " / CS " + str(_countersunk) + " / nut " + str(_nut_flats) + "x" + str(_nut_z);

    cube_x = 10;
    cube_y = 30;
    cube_z = 15;

    difference() {
        cube([cube_x, cube_y, cube_z]);

        translate([cube_x / 2, 0, cube_z / 2])
        rotate([270, 0, 0]) {
            m3_screw(length = cube_y * 1.1, overhangs = 0);

            m3_nut_slot(shaft_offset = _nut_z);
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


module assembly_bin(exploded = 0) {
    translate([0, -exploded * 25, 0]) {
        rim_end_left();
        rim_end_right();

        translate([0, 0, exploded * 25]) {
            rim_crossbar_front();
            rim_crossbar_back();
        }
    }

    translate([support_arm_offset, 0, 0]) {
        support_arm(for_book_support = 0);
        // wall_support();
    }
    support_arm();
    translate([-support_arm_offset, 0, 0]) {
        support_arm(for_book_support = 0);
        // wall_support();
    }

    // // bar between the two drop rods
    // translate([-support_arm_offset, 0, arm_length - upper_inside_diameter / 2 - arm_y]) 
    // cube([support_arm_offset * 2, arm_y, upper_inside_diameter / 2]);
}


module assembly_book(exploded = 0) {
    color("darkviolet")
    translate([0, -exploded * 2 * 25, 0])
    book_support();

    color("gold")
    translate([0, -exploded * 25, 0])
    book_support_upper();

    color("lightseagreen")
    translate([support_arm_offset, 0, 0]) {
        support_arm(for_book_support = 1);
        // wall_support();
    }
    color("lightseagreen")
    translate([-support_arm_offset, 0, 0]) {
        support_arm(for_book_support = 1);
        // wall_support();
    }
}


// ---------------------------------------------------------------------------


// assembly_bin(exploded = 1);
// assembly_book(exploded = 1);

clearance_test();

// by parts
// support_arm(for_book_support = 0);  // 0121-01
// rim_end_left();  // 0121-02
// rim_end_right();  // 0121-03
// rim_crossbar_front();  // 0121-04
// rim_crossbar_back();  // 0121-05

// rim_straight_only();

// book_support();  // 0121-06
// book_support_upper();  // 0121-07
// support_arm(for_book_support = 1);  // 0121-08


// m3_screw(length = 10, overhangs = 1);

// screw_holes(
//     // wall = 1,
//     back_rim = 1,
//     // front_rim = 1,
//     book_support_upper_screws = 1,
// );

// book_support_upper();
// book_support();
