// Gridfinity Handle
//
// Designed to screw in to the side of my (in-development) stackable gridfinity
// baseplates

use <../libs/roundedcube.scad>

// handle width, in Gridfinity units
width_gf = 3;
// handle height, in Gridfinity units
height_gh = 4;
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

corner_radius = 1.5;

font = "Aldo";
text_size = 5;
text_depth = 0.4;
text_2 = "0105A";

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

echo("interior_handle_height", interior_handle_height);
echo("handle_angle_x", handle_angle_x);
echo("handle_angle_length", handle_angle_length);
echo("handle_top_length", handle_top_length);

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

// for (i = [-1 : 2 : 1]) {
//     difference() {
//         // handle bottoms
//         translate(v = [i * (width_gf - 0.5) * gf_xy_base - base_width / 2, 0, 0])
//         roundedcube(size = [base_width, handle_depth, gf_z_base], radius=corner_radius);

//         // basic screw hole
//         translate(v = [i * (width_gf - 0.5) * gf_xy_base, -0.01, gf_z_base / 2])
//         rotate(a = [270, 0, 0])
//         cylinder(
//             d = screw_hole_diameter,
//             h = handle_depth + 0.02
//         );

//         // screw socket head
//         translate(v = [i * (width_gf - 0.5) * gf_xy_base, -0.01, gf_z_base / 2])
//         rotate(a = [270, 0, 0])
//         cylinder(
//             d = screw_socket_head_diameter,
//             h = screw_socket_head_height + 0.01
//         );
//     }

//     translate(v = [i * (width_gf - 0.5) * gf_xy_base + base_width / 2 - corner_radius, 0, 0]) 
//     rotate(a = [0, i * handle_angle, 0])
//     roundedcube(size = [angle_length, handle_depth, gf_z_base], radius=corner_radius);
// }

// points = [
//     [corner_radius, 0],
//     [base_width - corner_radius, 0],
//     [corner_radius, 0],
// ];

// linear_extrude(height = 5)
// chamber(r = 2)
// // square(size = 10);
// polygon(points);

// union() {
//     cube(size = [base_width, nz, nz]);

//     translate(v = [base_width, 0, 0])
//     cube(size = [nz, base_width, nz]);
// }

// cube(size = [base_width, nz, nz]);

// translate(v = [base_width, 0, 0])
// cube(size = [nz, nz, base_width]);

// translate(v = [base_width, 0, base_width])
// cube(size = [base_width, nz, nz]);

// translate(v = [base_width * 2 - nz, 0, 0])
// cube(size = [nz, nz, base_width]);

// translate(v = [base_width * 2 - nz, 0, 0])
// cube(size = [base_width, nz, nz]);

// minkowski() {
//     union() {
//         cube(size = [base_width, nz, nz]);

//         translate(v = [base_width, 0, 0])
//         cube(size = [nz, nz, base_width]);

//         translate(v = [base_width, 0, base_width])
//         cube(size = [base_width, nz, nz]);

//         translate(v = [base_width * 2 - nz, 0, 0])
//         cube(size = [nz, nz, base_width]);

//         translate(v = [base_width * 2 - nz, 0, 0])
//         cube(size = [base_width, nz, nz]);
//     }

//     rotate(a = [90, 0, 0]) 
//     cylinder(
//         r = 2,
//         h = nz
//     );
// }

module handle(nz) {
    union() {
        translate(v = [0, 0, -nz/2]) 
        cube(size = [base_width, nz, nz]);

        translate(v = [base_width, 0, -nz/2])
        rotate(a = [0, -1 * handle_angle, 0])
        cube(size = [handle_angle_length, nz, nz]);

        translate(v = [
            base_width + handle_angle_x - nz * sin(handle_angle),
            0,
            interior_handle_height - nz/2 - 0.27 * nz * tan(handle_angle)
        ])
        cube(size = [handle_top_length, nz, nz]);

        translate(v = [
            // base_width + 1 * handle_angle_x + handle_top_length - 0 * nz * sin(handle_angle),
            base_width + 2 * handle_angle_x + handle_top_length - 2 * nz * sin(handle_angle),
            nz,
            -nz/2
        ])
        rotate(a = [0, -1 * handle_angle, 180])
        #cube(size = [handle_angle_length, nz, nz]);

        translate(v = [
            base_width + 2 * handle_angle_x + handle_top_length - 2 * nz * sin(handle_angle),
            0,
            -nz/2
        ])
        cube(size = [base_width, nz, nz]);
    }
}

module handle_2(nz) {
    union() {
        translate(v = [0, 0, -nz/2]) 
        cube(size = [base_width, nz, nz]);

        translate(v = [0, 0, -nz/2])
        rotate(a = [0, -1 * handle_angle, 0])
        cube(size = [handle_angle_length, nz, nz]);

        translate(v = [
            handle_angle_x - nz * sin(handle_angle),
            0,
            interior_handle_height - nz/2 - 0.27 * nz * tan(handle_angle)
        ])
        cube(size = [handle_top_length + 2 * base_width, nz, nz]);

        translate(v = [
            // base_width + 1 * handle_angle_x + handle_top_length - 0 * nz * sin(handle_angle),
            2 * base_width + 2 * handle_angle_x + handle_top_length - 2 * nz * sin(handle_angle),
            nz,
            -nz/2
        ])
        rotate(a = [0, -1 * handle_angle, 180])
        cube(size = [handle_angle_length, nz, nz]);

        translate(v = [
            base_width + 2 * handle_angle_x + handle_top_length - 2 * nz * sin(handle_angle),
            0,
            -nz/2
        ])
        cube(size = [base_width, nz, nz]);
    }
}

// minkowski() {
//     handle();

//     rotate(a = [90, 0, 0]) 
//     cylinder(
//         r = 2,
//         h = nz
//     );
// }

// linear_extrude(height = handle_depth)
// offset(r = corner_radius)
// offset(delta = (gf_z_base - 2 * corner_radius) / 2)
// projection()
//     rotate(a = [90, 0, 0])
//     handle();

// handle_2(nz=1);

// linear_extrude(height = handle_depth)
// offset(r = corner_radius)
// offset(delta = (gf_z_base - 2 * corner_radius) / 2)
// projection()
//     rotate(a = [90, 0, 0])
//     handle_2(nz = 0.01);

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
            // 2 * base_width + 2 * handle_angle_x + handle_top_length - 2 * nz * sin(handle_angle),
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
            // base_width + 2 * handle_angle_x + handle_top_length - 2 * nz * sin(handle_angle),
            (width_gf - 1) * gf_xy_base,
            0,
            -nz/2
        ])
        cube(size = [base_width, handle_depth, gf_z_base]);
    }
}

difference() {
    handle_3();

    translate(v = [base_width / 2, -0.01, gf_z_base / 2])
    rotate(a = [270, 0, 0]) {
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
    }

    translate(v = [base_width / 2 + (width_gf - 1) * gf_xy_base, -0.01, gf_z_base / 2])
    rotate(a = [270, 0, 0]) {
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
    }

    #translate(v = [handle_angle_x + text_size , 1, height_gh * gf_z_base - handle_cross_section - text_depth]) 
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
