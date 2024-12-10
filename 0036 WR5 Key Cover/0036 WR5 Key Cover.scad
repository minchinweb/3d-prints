// Key cover or key "sock" for a WR5 / KW1 square block key
//
// Commonly used for American house keys
// particularly Weiser and Kwickset
// Sample blank: https://discountdoorhardware.ca/product/weiser-wr5-keyway-5-pin-key-blank-brass/
//
// All dimensions in mm

// Label on key
key_label = "House";

font = "Aldo";
font_size = 5;

/// Generate key sock!

// thickness "front to back", laying flat on the table
key_thickness = 2.00;
// laying flat, the "left to right" of the main body
key_box_width = 21.77;
// laying flat, the "up to down" of the main body
key_box_height = 17.00;
// ??
key_top_base_width = 13.00;
// measured along the "top edge" of the key, how wide are the shoulders that stick up?
key_top_shoulder_width = 12.7;
// at the top of the "key hole bump", how wide is the top edge? The bottom of the keyhole is assumed to be this wide as well.
key_top_top_width = 10.5;
// how much does the "key hole bump" sick "up" above the main body of the key?
key_top_extra_height = 4.41;
// on the "key hole bump", how tall is the band between the top edge and the keyhole?
key_top_thickness = 2.21;
// the "up to down" of the top keyhole
key_hole_height = 4.92;

// how thick do you want the cover? Tip: set this to a multiple of your print line width.
sock_thickness = 0.42 * 2;

// additional clearance (c.f. tolerance) to width of the key
clearance_width = 0.70;
// additional clearance (c.f. tolerance) to thickness of the key
clearance_depth = 0.30;
//text_delta_y = 0;

// how far outside the "box" to show removals
overcut_distance = 5;

key_top_shoulder = (key_box_width - key_top_shoulder_width) / 2;
full_thickness = key_thickness + sock_thickness * 2;
inside_bottom = sock_thickness;
inside_top = key_thickness + sock_thickness;
inside_low_x = sock_thickness;
inside_high_x = key_box_width - sock_thickness;
inside_box_high_y = key_box_height - sock_thickness;

// the contours of the key head
module _sock(x_1, x_2, x_3, x_4, x_5, x_6, y_1, y_2, y_3, z_1, z_2) {
    polyhedron(
        points = [
            [x_1, y_1, z_1],  // 0
            [x_6, y_1, z_1],
            [x_6, y_2, z_1],
            [x_5, y_2, z_1],
            [x_4, y_3, z_1],
            [x_3, y_3, z_1],
            [x_2, y_2, z_1],
            [x_1, y_2, z_1],  // 7

            [x_1, y_1, z_2],  // 8
            [x_6, y_1, z_2],
            [x_6, y_2, z_2],
            [x_5, y_2, z_2],
            [x_4, y_3, z_2],
            [x_3, y_3, z_2],
            [x_2, y_2, z_2],
            [x_1, y_2, z_2]  // 15
        ],
        faces = [
            [0, 1, 2, 3, 4, 5, 6, 7],
            [15, 14, 13, 12, 11, 10, 9, 8],
            [ 8,  9, 1, 0],
            [ 9, 10, 2, 1],
            [10, 11, 3, 2],
            [11, 12, 4, 3],
            [12, 13, 5, 4],
            [13, 14, 6, 5],
            [14, 15, 7, 6],
            [15,  8, 0, 7]
        ],
        convexity = 10
    );
}

// the contours of the keyhole
module _keyhole(x_1, x_2, x_3, x_4, y_1, y_2, z_1, z_2) {
    polyhedron(
        points = [
            [x_1, y_1, z_1],  // 0
            [x_4, y_1, z_1],
            [x_3, y_2, z_1],
            [x_2, y_2, z_1],  // 3

            [x_1, y_1, z_2],  // 4
            [x_4, y_1, z_2],
            [x_3, y_2, z_2],
            [x_2, y_2, z_2]   // 7
        ],
        faces = [
            [0, 1, 2, 3],
            [7, 6, 5, 4],
            [4, 5, 1, 0],
            [5, 6, 2, 1],
            [6, 7, 3, 2],
            [7, 4, 0, 3],
        ],
        convexity = 10
    );
}


module sock_outside() {
    _sock(
        // "left" edge
        x_1 = -sock_thickness,
        // x edges of top box on key
        x_2 = key_top_shoulder - sock_thickness / sqrt(2),
        x_3 = (key_box_width - key_top_top_width) / 2 - sock_thickness / sqrt(2),
        x_4 = (key_box_width + key_top_top_width) / 2 + sock_thickness / sqrt(2) + clearance_width,
        x_5 = key_box_width - (key_top_shoulder - sock_thickness / sqrt(2)) + clearance_width,
        // "right" edge
        x_6 = key_box_width + sock_thickness + clearance_width,

        y_1 = 0,
        y_2 = key_box_height + sock_thickness,
        y_3 = key_box_height + key_top_extra_height + sock_thickness,

        z_1 = -sock_thickness,
        z_2 = key_thickness + sock_thickness + clearance_depth
    );
}

module sock_inside() {
    _sock(
        // "left" edge
        x_1 = 0,
        // x edges of top box on key
        x_2 = key_top_shoulder,
        x_3 = (key_box_width - key_top_top_width) / 2,
        x_4 = (key_box_width + key_top_top_width) / 2 + clearance_width,
        x_5 = key_box_width - key_top_shoulder + clearance_width,
        // "right" edge
        x_6 = key_box_width + clearance_width,

        y_1 = -overcut_distance,
        y_2 = key_box_height,
        y_3 = key_box_height + key_top_extra_height,

        z_1 = 0,
        z_2 = key_thickness + clearance_depth
    );
}

module my_keyhole() {
    _keyhole(
        x_1 = (key_box_width - key_top_shoulder_width) / 2 + key_top_thickness / sqrt(2),
        x_2 = (key_box_width - key_top_top_width) / 2 + key_top_thickness / sqrt(2),
        x_3 = (key_box_width + key_top_top_width) / 2 - key_top_thickness / sqrt(2),
        x_4 = (key_box_width + key_top_shoulder_width) / 2 - key_top_thickness / sqrt(2),
        y_1 = key_box_height + key_top_extra_height - key_hole_height - key_top_thickness,
        y_2 = key_box_height + key_top_extra_height - key_top_thickness,
        z_1 = -overcut_distance,
        z_2 = key_thickness + sock_thickness + overcut_distance);
}

module key_labels(extra_depth = 0) {
    translate(v = [
        key_box_width / 2,
        (key_box_height - font_size) / 2,
        key_thickness + clearance_depth - extra_depth
    ])
    linear_extrude(height = sock_thickness + extra_depth * 2)
    text(
        key_label,
        size = font_size,
        font = font,
        halign = "center",
        valign = "baseline"
    );

    translate(v = [
        key_box_width / 2,
        (key_box_height - font_size) / 2,
        0 - extra_depth
    ])
    rotate([0, 180, 0])
    linear_extrude(height = sock_thickness + extra_depth * 2)
    text(
        key_label,
        size = font_size,
        font = font,
        halign = "center",
        valign = "baseline"
    );
}

module key_sock() {
    // put vertical on build plate
    rotate(a = [90, 0, 0]) 
    difference() {
        sock_outside();

        sock_inside();
        my_keyhole();

        key_labels(extra_depth = 0.5);
    }
}


module shapes_test() {
    sock_outside();

    translate(v = [0, 0, key_thickness + sock_thickness])
        color("red")
        sock_inside();

    translate(v = [0, 0, key_thickness + sock_thickness])
        color("green")
        my_keyhole();
}

color("green")
key_sock();

color("snow")
rotate(a = [90, 0, 0])
key_labels(extra_depth = 0);
