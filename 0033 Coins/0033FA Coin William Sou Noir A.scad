include <base_coin.scad>

// William's Sou Noir
// Updated 2026-09-07
// print in black

/* [General] */
// coin diamter, in mm. Design at this size
diameter = 21;
// thickness of wall around the edge of the coin, in mm
edge_wall_thickness = 0.66;
// printer's layer height, in mm
layer_height = 0.06;

// bas releif depth, in layers
head_profile_depth_layers = 24;  // ~1.44mm, in layers
tail_profile_depth_layers = 12;
// center thickness, in layers
base_thickness_layers = 1.83333;  // ~2, to match first prints

/* [Coin Elements - Bust] */
// (relative) path to bust image. Assumed to be square dimensions.
// bust_image = "";
// size, in pixels, of bust image
bust_pixels = 0;
bust_stl = "0033F William Sou Noir/MakerLabs/reliefSculpture - William-1836 2024 84mm.stl";
bust_mm = 84;
bust_height = 3.276; // bust height in mm at full size
bust_rotate = 0;
bust_delta_x = 0;                                                              
bust_delta_y = 0;
bust_delta_z = 0.06 * (6 + 4); // multiple of layers
bust_mode = 1;

/* [Coin Elements - Name] */
name_image = "0033F William Sou Noir/William Elements/name A - 20260906.png";
name_pixels = 600;
name_rotate = 100;
name_delta_x = 0;
name_delta_y = 0;

/* [Coin Elements - Year] */
year_image = "0033F William Sou Noir/William Elements/year A - 2026 - 20260906.png";
year_pixels = 600;
year_rotate = 180;
year_delta_x = 0;
year_delta_y = +0.5;

/* [Coin Elements - Value] */
value_image = "0033F William Sou Noir/William Elements/value A - sou noir - 20260906.png";
value_pixels = 600;
value_rotate = 0;
value_delta_x = 0;
value_delta_y = 0;

/* [Coin Elements - Value 2] */
value_2_image = "0033F William Sou Noir/William Elements/value B - 1-4d - 20260906.png";
value_2_pixels = 600;
value_2_rotate = 20;
value_2_delta_x = -7.5;
value_2_delta_y = 14.5;


/* [Coin Elements - Reverse] */
reverse_image = "0033F William Sou Noir/William Elements/reverse C - cube - 20260906.png";
reverse_pixels = 350;  // nominal 600
reverse_rotate = 0;
reverse_delta_x = -1;
reverse_delta_y = -1.8;


/* [Rendering] */
cylinder_faces = 60;


base_coin(
    diameter = diameter,
    edge_wall_thickness = edge_wall_thickness,
    layer_height = layer_height,
    head_profile_depth_layers = head_profile_depth_layers,
    tail_profile_depth_layers = tail_profile_depth_layers,
    base_thickness_layers = base_thickness_layers,

    bust_mode = 1,  // STL
    // bust_image = bust_image,
    // bust_pixels = bust_pixels,
    bust_stl = bust_stl,
    bust_mm = bust_mm,
    bust_height = bust_height,
    bust_rotate = bust_rotate,
    bust_delta_x = bust_delta_x,
    bust_delta_y = bust_delta_y,
    bust_delta_z = bust_delta_z,

    name_image = name_image,
    name_pixels = name_pixels,
    name_rotate = name_rotate,
    name_delta_x = name_delta_x,
    name_delta_y = name_delta_y,

    year_image = year_image,
    year_pixels = year_pixels,
    year_rotate = year_rotate,
    year_delta_x = year_delta_x,
    year_delta_y = year_delta_y,

    value_image = value_image,
    value_pixels = value_pixels,
    value_rotate = value_rotate,
    value_delta_x = value_delta_x,
    value_delta_y = value_delta_y,

    value_2_image = value_2_image,
    value_2_pixels = value_2_pixels,
    value_2_rotate = value_2_rotate,
    value_2_delta_x = value_2_delta_x,
    value_2_delta_y = value_2_delta_y,

    reverse_image = reverse_image,
    reverse_pixels = reverse_pixels,
    reverse_rotate = reverse_rotate,
    reverse_delta_x = reverse_delta_x,
    reverse_delta_y = reverse_delta_y,

    cylinder_faces = cylinder_faces
);
