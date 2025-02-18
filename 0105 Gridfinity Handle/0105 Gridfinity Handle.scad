// Gridfinity Handle
//
// Designed to screw in to the side of my (in-development) stackable gridfinity
// baseplates
//
// A -- 2025-02-16
// - first (three) passes. Eventually settled on a mostly "direct build"
//   approach, manually tweaked.
//
// B -- 2025-02-17
// - add cross printing supports for screwhead
// - add stabilizer bar to handle rim
// - add upright support from inside end of base
// - increase height from 4 to 5 (need to count the height of the base)
//
// C -- 2025-02-17
// - completely rework geometry
// - lower top of handle, to allow stacking (as it currently reaches the top of
//   the stacking lip of bins)
// - remove lip profile from handle bottom (again, to allow stacking)
// - make base come up higher, so it matches the baseplate it's sitting next to


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
text_2 = "0105C";

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
// additional height added by the stacking lip
gf_z_lip = 4.4;
// height of center of screw hole, in baseplate
screw_hole_z = 5.975;

angle_length = 50;

// height of the bottom "foot" on each side of the handle
base_height = gf_z_base + gf_z_lip - screw_hole_z + 1/2 * gf_z_base;
handle_depth = (gf_xy_base - 0.5) / 4;
interior_handle_height = height_gh * gf_z_base - base_height - gf_z_lip;
handle_angle_length = interior_handle_height / sin(handle_angle);
handle_angle_x = handle_angle_length * cos(handle_angle);
handle_top_length = (width_gf - 1) * gf_xy_base + base_width - 2 * handle_angle_x;
_interior_support_height = (base_width - handle_cross_section * 1.5) * tan(handle_angle);
interior_support_height = min(_interior_support_height, interior_handle_height);

echo("interior_handle_height", interior_handle_height);
echo("handle_angle_x", handle_angle_x);
echo("handle_angle_length", handle_angle_length);
echo("handle_top_length", handle_top_length);
echo("interior_support_height", interior_support_height);
echo("base_height", base_height);

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
        translate(v = [0, 0, 0]) 
        cube(size = [base_width, handle_depth, base_height]);

        translate(v = [
            0,
            handle_depth * narrow_handle_depth_fraction,
            base_height
        ])
        rotate(a = [180, -1 * handle_angle, 0])
        cube(size = [
            handle_angle_length + 0 * 0.825,
            handle_depth * narrow_handle_depth_fraction,
            handle_cross_section
        ]);

        translate(v = [
            ((width_gf - 1) * gf_xy_base + base_width) / 2,
            1/2 * handle_depth * narrow_handle_depth_fraction,
            base_height + interior_handle_height - 1/2 * handle_cross_section
        ])
        cube(
            size = [
                handle_top_length - 0 * 1.05,
                handle_depth * narrow_handle_depth_fraction,
                handle_cross_section
            ],
            center = true
        );

        translate(v = [
            (width_gf - 1) * gf_xy_base + base_width,
            0,
            base_height
        ])
        rotate(a = [0, 180 + handle_angle, 0])
        cube(size = [
            handle_angle_length + 0 * 0.69,
            handle_depth * narrow_handle_depth_fraction,
            handle_cross_section
        ]);

        translate(v = [
            (width_gf - 1) * gf_xy_base,
            0,
            0
        ])
        cube(size = [base_width, handle_depth, base_height]);

        // vertical extra supports
        translate(v = [base_width - handle_cross_section, 0, 0])
        cube(size = [
            handle_cross_section,
            handle_depth * narrow_handle_depth_fraction,
            interior_support_height + base_height
        ]);

        translate(v = [
            (width_gf - 1) * gf_xy_base,
            0,
            0,
        ])
        cube(size = [
            handle_cross_section,
            handle_depth * narrow_handle_depth_fraction,
            interior_support_height + base_height
        ]);

        // stabilizer rim
        translate(v = [
            0,
            handle_cross_section,
            base_height
        ])
        rotate(a = [180, -1 * handle_angle, 0])
        cube(size = [
            handle_angle_length,
            handle_cross_section,
            handle_cross_section * 2
        ]);

        translate(v = [
            ((width_gf - 1) * gf_xy_base + base_width) / 2,
            1/2 * handle_cross_section,
            base_height + interior_handle_height - 1/2 * handle_cross_section * 2
        ])
        cube(
            size = [
                handle_top_length - 1.05,
                handle_cross_section,
                handle_cross_section * 2
            ],
            center = true
        );

        translate(v = [
            // 2 * handle_angle_x + handle_top_length,
            (width_gf - 1) * gf_xy_base + base_width,
            0,
            base_height
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

module gridfinity_lip_profile(length) {
    translate(v = [2.15, length / 2, 0])
    rotate(a = [0, 45, 0])
    cube(size = [0.8 / sin(45), length, 0.8 / sin(45)], center = true);

    cube(size = [2.15, length, 0.8 + 1.8]);

    translate(v = [0, length / 2, 0.8 + 1.8])
    rotate(a = [0, 45, 0])
    cube(size = [2.15 / sin(45), length, 2.15 / sin(45)], center = true);

}

difference() {
    handle_3();

    translate(v = [base_width / 2, -0.01, gf_z_base / 2])
    rotate(a = [270, 0, 0]) 
    screw_hole();

    translate(v = [base_width / 2 + (width_gf - 1) * gf_xy_base, -0.01, gf_z_base / 2])
    rotate(a = [270, 0, 0])
    screw_hole();

    // gridfinity stacking profile
    translate(v = [
        -1 * gf_xy_base / 4,
        handle_depth,
        -1 * (gf_z_base + gf_z_lip - base_height)
    ])
    rotate(a= [0, 0, 270])
    gridfinity_lip_profile(length = width_gf * gf_xy_base); 


    // text label
    translate(v = [
        handle_angle_x + text_size ,
        handle_cross_section + 0.5,
        base_height + interior_handle_height - handle_cross_section - text_depth
    ]) 
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

