include <base_coin.scad>

// Test size blanks
// Updated 2026-09-07

diameter = 21;
edge_wall_thickness = 0.66;
layer_height = 0.06;

// bas releif depth, in layers
head_profile_depth_layers = 6;  // ~1.44mm, in layers
tail_profile_depth_layers = 0;
// center thickness, in layers
base_thickness_layers = 2;

bust_pixels = 0;
bust_image = "";
bust_stl = "";
bust_mm = 84;
bust_height = 3.276; // bust height in mm at full size
bust_rotate = 0;
bust_delta_x = 0;                                                              
bust_delta_y = 0;
bust_delta_z = 0.06 * (6 + 4); // multiple of layers
bust_mode = 2;

name_image = "";
name_pixels = 300;
name_rotate = 335;
name_delta_x = 0;
name_delta_y = 0;

year_image = "";
year_pixels = 300;
year_rotate = 315;
year_delta_x = 0;
year_delta_y = 0;

value_image = "";
value_pixels = 300;
value_rotate = 0;
value_delta_x = 0;
value_delta_y = 0;

value_2_image = "";
value_2_pixels = 300;
value_2_rotate = 0;
value_2_delta_x = 0;
value_2_delta_y = 0;

reverse_image = "";
reverse_pixels = 300;
reverse_rotate = 0;
reverse_delta_x = 0;
reverse_delta_y = 0;

cylinder_faces = 60;



module test_sizes(
    sizes = [21, ],
    offset = 42,
) {
    echo("** Running tests! **");

    test_count = len(sizes) - 1;
    for (i = [0:test_count]) {
        test_size = sizes[i];
        test_intro_str = str(str(i), " : ", str(test_size));
        size_str = str(str(test_size), " mm");

        echo(test_intro_str);

        translate([offset * i, 0, 0])
        base_coin(
            diameter = test_size,
            head_profile_depth_layers = head_profile_depth_layers,
            tail_profile_depth_layers = tail_profile_depth_layers,
            bust_mode = bust_mode,
            bust_str = size_str,
        );
    }
}

test_sizes(
    // sizes = [14, ],
    sizes = [14, 14.5, 15, 16, 17, 18, 18.5, 19, 19.7, 21],
    offset = 22,
);

translate([0, 24, 0])
test_sizes(
    sizes = [23, 24, 25, 26, 27, 28, 29],
    offset = 31,
);

translate([0, 24+31, 0])
test_sizes(
    sizes = [31, 32, 37.5, 38, 40],
    offset = 42,
);

translate([0, 24+31+42, 0])
test_sizes(
    sizes = [41],
    offset = 42,
);
