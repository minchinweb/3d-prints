// Gridfinity Handle
//
// Designed to screw in to the side of my (in-development) stackable gridfinity
// baseplates
//
// A -- 2025-02-16
//
// - first (three) passes. Eventually settled on a mostly "direct build"
//   approach, manually tweaked.
//
// B -- 2025-02-17
//
// - add cross printing supports for screwhead
// - add stabilizer bar to handle rim
// - add upright support from inside end of base
// - increase height from 4 to 5 (need to count the height of the base)

use <../libs/roundedcube.scad>

// handle width, in Gridfinity units
width_gf = 3;
// handle height, in Gridfinity units
height_gh = 5;
// how wide to make the handle bottom
base_width = 21;
// minimum width for handle top
min_top_width = 31.5;
handle_angle = 45;
handle_cross_section = 2;
narrow_handle_depth_fraction = 0.7; // [0.0, 1.0]

// handle_depth = 10.375;

// for M2.5, use 2.8mm.
screw_hole_diameter = 2.8;

screw_socket_head_diameter = 4.5;
screw_socket_head_height = 2.5;

// corner_radius = 1.5;
layer_thickness = 0.2;

font = "Aldo";
text_size = 4;
text_depth = 0.4;
text_2 = "0105B";

// minimum angle for a fragment (fragments = 360/fa).  Low is more fragments 
fa = 6; 
// minimum size of a fragment.  Low is more fragments
fs = 0.4; 
// number of fragments, overrides $fa and $fs
fn = 0; 

/* [Hidden] */
module end_of_customizer_opts() {}
/*<!!end gridfinity_basic_cup!!>*/

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa; 
$fs = fs; 
$fn = fn;  

// My Math...
gf_xy_base = 42;
gf_z_base = 7;

angle_length = 50;

handle_depth = (gf_xy_base - 0.5) / 4;
interior_handle_height = (height_gh - 1) * gf_z_base;
handle_angle_length = interior_handle_height / sin(handle_angle);
handle_angle_x = handle_angle_length * cos(handle_angle);
handle_top_length = (width_gf - 1) * gf_xy_base + base_width - 2 * handle_angle_x;
interior_support_height = (base_width - handle_cross_section * 1.5) * tan(handle_angle);

echo("interior_handle_height", interior_handle_height);
echo("handle_angle_x", handle_angle_x);
echo("handle_angle_length", handle_angle_length);
echo("handle_top_length", handle_top_length);
echo("interior_support_height", interior_support_height);

text_1 = str(
    str(width_gf),
    " x ",
    str(height_gh),
    " M2.5"
);

// "near zero"
// nz = 0.01;
nz = 1;

module chamber(r) {
    // from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Transformations#offset
    offset(r = r) {
        offset(delta = -r) {
            children();
        }
    }
}


module handle_3() {
    union() {
        translate(v = [0, 0, -nz/2]) 
        cube(size = [base_width, handle_depth, gf_z_base]);

        translate(v = [
            handle_cross_section * sin(handle_angle),
            0,
            gf_z_base - handle_cross_section
        ])
        rotate(a = [0, -1 * handle_angle, 0])
        cube(size = [
            handle_angle_length + 0.825,
            handle_depth * narrow_handle_depth_fraction,
            handle_cross_section
        ]);

        translate(v = [
            handle_angle_x - 0 * handle_cross_section * sin(handle_angle) + 0.585,
            0,
            height_gh * gf_z_base - handle_cross_section
        ])
        cube(size = [
            handle_top_length - 1.05,
            handle_depth * narrow_handle_depth_fraction,
            handle_cross_section
        ]);

        translate(v = [
            2 * handle_angle_x + handle_top_length - 1.4,
            handle_depth * narrow_handle_depth_fraction,
            gf_z_base - handle_cross_section + 0.1
        ])
        rotate(a = [0, -1 * handle_angle, 180])
        cube(size = [
            handle_angle_length + 0.69,
            handle_depth * narrow_handle_depth_fraction,
            handle_cross_section
        ]);

        translate(v = [
            (width_gf - 1) * gf_xy_base,
            0,
            -nz/2
        ])
        cube(size = [base_width, handle_depth, gf_z_base]);

        // vertical extra supports
        translate(v = [base_width - handle_cross_section, 0, 0])
        cube(size = [
            handle_cross_section,
            handle_depth * narrow_handle_depth_fraction,
            interior_support_height + gf_z_base
        ]);

        translate(v = [
            (width_gf - 1) * gf_xy_base,
            0,
            0,
        ])
        cube(size = [
            handle_cross_section,
            handle_depth * narrow_handle_depth_fraction,
            interior_support_height + gf_z_base
        ]);

        // stabilizer rim
        translate(v = [
            handle_cross_section * sin(handle_angle) + 2.8,
            0,
            gf_z_base - handle_cross_section
        ])
        rotate(a = [0, -1 * handle_angle, 0])
        cube(size = [
            handle_angle_length - 2.0,
            handle_cross_section,
            handle_cross_section * 2
        ]);

        translate(v = [
            handle_angle_x - 0 * handle_cross_section * sin(handle_angle) + 0.585,
            0,
            height_gh * gf_z_base - handle_cross_section * 2
        ])
        cube(size = [
            handle_top_length - 1.05,
            handle_cross_section,
            handle_cross_section * 2
        ]);

        translate(v = [
            2 * handle_angle_x + handle_top_length,
            0,
            gf_z_base - nz/2
        ])
        rotate(a = [0, 180 + handle_angle, 0])
        cube(size = [
            handle_angle_length,
            handle_cross_section,
            handle_cross_section * 2
        ]);
    }
}

module screw_hole() {
    // main screw holes
    cylinder(
        d = screw_hole_diameter,
        h = handle_depth + 0.02
    );

    // screw socket head
    cylinder(
        d = screw_socket_head_diameter,
        h = screw_socket_head_height + 0.01
    );

    // cross supports for printing socket head indent
    translate(v = [0, 0, screw_socket_head_height])
    intersection() {
        cylinder(
            d = screw_socket_head_diameter,
            h = 2 * layer_thickness
        );
        cube(
            size = [
                screw_socket_head_diameter,
                screw_hole_diameter,
                4 * layer_thickness,  // double thickness needed for center
            ],
            center = true
        );
    }

    translate(v = [
        0,
        0,
        screw_socket_head_height + 2 * layer_thickness
    ]) 
    intersection() {
        cylinder(
            d = screw_socket_head_diameter,
            h = 2 * layer_thickness
        );
        cube(
            size = [
                screw_socket_head_diameter,
                screw_hole_diameter,
                4 * layer_thickness,  // double thickness needed for center
            ],
            center = true
        );
        cube(
            size = [
                screw_hole_diameter,
                screw_socket_head_diameter,
                4 * layer_thickness,  // double thickness needed for center
            ],
            center = true
        );
    }
}

difference() {
    handle_3();

    translate(v = [base_width / 2, -0.01, gf_z_base / 2])
    rotate(a = [270, 0, 0]) 
    screw_hole();

    translate(v = [base_width / 2 + (width_gf - 1) * gf_xy_base, -0.01, gf_z_base / 2])
    rotate(a = [270, 0, 0])
    screw_hole();

    translate(v = [
        handle_angle_x + text_size ,
        handle_cross_section + 0.5,
        height_gh * gf_z_base - handle_cross_section - text_depth]) 
    linear_extrude(height = text_depth * 2) {
        rotate(a = [0, 180, 180])
        text(
            text = str(
                text_1,
                " // ",
                text_2
            ),
            size = text_size,
            font = font,
            halign = "left",
            valign = "top"
        );
    }
}
