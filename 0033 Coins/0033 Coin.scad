/* [General] */
// coin diamter, in mm. Design at this size
diameter = 21;
// thickness of wall around the edge of the coin, in mm
edge_wall_thickness = 0.35;
// printer's layer height, in mm
layer_height = 0.06;

// bas releif depth, in layers
profile_depth_layers = 12;
// center thickness, in layers
base_thickness_layers = 4;

/* [Coin Elements - Bust] */
// (relative) path to bust image. Assumed to be square dimensions.
bust_image = "0033B Daniel Sou Noir/Profile A - 300px - 20241027.png";
// size, in pixels, of bust image
bust_pixels = 300;
bust_rotate = 0;
bust_delta_x = 0;
bust_delta_y = 0;

/* [Coin Elements - Name] */
name_image = "0033B Daniel Sou Noir/Name A - Daniel - 20241027.png";
name_pixels = 300;
name_rotate = 335;
name_delta_x = +0.6;
name_delta_y = 0;

/* [Coin Elements - Year] */
year_image = "0033B Daniel Sou Noir/Year A - 2024 - 20241027.png";
year_pixels = 300;
year_rotate = 315;
year_delta_x = 0;
year_delta_y = 0;

/* [Coin Elements - Value] */
value_image = "0033B Daniel Sou Noir/Value A - sou noir - 20241027.png";
value_pixels = 300;
value_rotate = 0;
value_delta_x = 0;
value_delta_y = 0;


/* [Coin Elements - Reverse] */
reverse_image = "0033B Daniel Sou Noir/Reverse A - Pegasus - 20241027.png";
reverse_pixels = 300;
reverse_rotate = 0;
reverse_delta_x = 0;
reverse_delta_y = 0;


/* [Rendering] */
cylinder_faces = 60;

/* [Testing] */
test_sizes = [16, 17, 18, 19, 21, 23, 24, 25, 27, 28, 31, 32, 38, 40];
tests = "no";  // ["yes", "no"]
// offset tests my this, should be greater than largest test size, in mm
test_offset = 42;


//  Create coin

// convert from layers to mm
profile_depth = profile_depth_layers * layer_height;
base_thickness = base_thickness_layers * layer_height;

module face_side(
    coin_diameter,
    delta_x = 0,
    delta_y = 0,
    base_thickness = 0.1,
    add_base = false,
    add_rim = false,
    add_face = true,
    add_name = true
) {
    master_scale = coin_diameter / diameter;
    bust_xy_scale = coin_diameter / bust_pixels;
    name_xy_scale = coin_diameter / name_pixels;
    z_scale = profile_depth / 100;
    
    // face "base"
    if (add_base) {
        color("red")
        translate(v = [
            coin_diameter / 2 + delta_x,
            coin_diameter / 2 + delta_y,
            -1 * base_thickness
        ])
        cylinder(h = base_thickness, r = coin_diameter / 2);
    }

    if (add_face) {
        // bust profile
        translate(v = [
            coin_diameter / 2 + bust_delta_x * master_scale + delta_x,
            coin_diameter / 2 + bust_delta_y * master_scale + delta_y,
            base_thickness
        ]) 
        scale(v = [bust_xy_scale, bust_xy_scale, z_scale])
            surface(file=bust_image, center=true);
    }

    if (add_name) {
        // name profile
        translate(v = [
            coin_diameter / 2 + name_delta_x * master_scale + delta_x,
            coin_diameter / 2 + name_delta_y * master_scale + delta_y,
            base_thickness
        ])
        rotate(a = name_rotate)
        scale(v = [name_xy_scale, name_xy_scale, z_scale])
            surface(file=name_image, center=true);
    }

    if (add_rim) {
        // edge wall
        color("blue")
        // translate(v = [coin_diameter / 2 + x, coin_diameter / 2 + y, base_thickness])
        difference(convexity=3) {
            translate(v = [
                coin_diameter / 2 + delta_x,
                coin_diameter / 2 + delta_y,
                base_thickness
            ])
            cylinder(
                h = profile_depth,
                r = coin_diameter / 2,
                $fn=cylinder_faces
            );

            translate(v = [
                coin_diameter / 2 + delta_x,
                coin_diameter / 2 + delta_y,
                base_thickness - 1
            ])
            cylinder(
                h = profile_depth + 2,
                r = coin_diameter / 2 - edge_wall_thickness,
                $fn=cylinder_faces
            );
        }
    }
}

module tails_side(    coin_diameter,
    delta_x = 0,
    delta_y = 0,
    base_thickness = 0.1,
    add_base = false,
    add_rim = false,
    add_reverse = true,
    add_year = true,
    add_value = true
) {
    master_scale = coin_diameter / diameter;
    reverse_xy_scale = coin_diameter / reverse_pixels;
    year_xy_scale = coin_diameter / year_pixels;
    value_xy_scale = coin_diameter / value_pixels;
    z_scale = profile_depth / 100;

    // face "base"
    if (add_base) {
        color("red")
        translate(v = [
            coin_diameter / 2 + delta_x,
            coin_diameter / 2 + delta_y,
            profile_depth
        ])
        cylinder(h = base_thickness, r = coin_diameter / 2);
    }

    if (add_reverse) {
        translate(v = [
            coin_diameter / 2 + reverse_delta_x * master_scale + delta_x,
            coin_diameter / 2 + reverse_delta_y * master_scale + delta_y,
            profile_depth
        ])
        rotate(a = reverse_rotate)
        rotate([0, 180, 0])
        scale(v = [reverse_xy_scale, reverse_xy_scale, z_scale])
            surface(file=reverse_image, center=true);
    }

    if (add_year) {
        translate(v = [
            coin_diameter / 2 + year_delta_x * master_scale + delta_x,
            coin_diameter / 2 + year_delta_y * master_scale + delta_y,
            profile_depth
        ])
        rotate(a = year_rotate)
        rotate([0, 180, 0])
        scale(v = [year_xy_scale, year_xy_scale, z_scale])
            surface(file=year_image, center=true);
    }

    if (add_value) {
        translate(v = [
            coin_diameter / 2 + value_delta_x * master_scale + delta_x,
            coin_diameter / 2 + value_delta_y * master_scale + delta_y,
            profile_depth
        ])
        rotate(a = value_rotate)
        rotate([0, 180, 0])
        scale(v = [value_xy_scale, value_xy_scale, z_scale])
            surface(file=value_image, center=true);
    }


    if (add_rim) {
        // edge wall
        color("blue")
        // translate(v = [coin_diameter / 2 + x, coin_diameter / 2 + y, base_thickness])
        difference(convexity=3) {
            translate(v = [
                coin_diameter / 2 + delta_x,
                coin_diameter / 2 + delta_y,
                0
            ])
            cylinder(
                h = profile_depth,
                r = coin_diameter / 2,
                $fn=cylinder_faces
            );

            translate(v = [
                coin_diameter / 2 + delta_x,
                coin_diameter / 2 + delta_y,
                base_thickness - 1
            ])
            cylinder(
                h = profile_depth + 2,
                r = coin_diameter / 2 - edge_wall_thickness,
                $fn=cylinder_faces
            );
        }
    }
}


module rim_side (
    coin_diameter,
    delta_x = 0,
    delta_y = 0,
    add_rim = true
) {
    if (add_rim) {
        rim_height = profile_depth * 2 + base_thickness;

        // edge wall
        color("blue")
        difference() {
            translate(v = [
                coin_diameter / 2 + delta_x,
                coin_diameter / 2 + delta_y,
                0
            ])
            cylinder(
                h = rim_height,
                r = coin_diameter / 2,
                $fn=cylinder_faces
            );

            translate(v = [
                coin_diameter / 2 + delta_x,
                coin_diameter / 2 + delta_y,
                -1
            ])
            cylinder(
                h = rim_height + 2,
                r = coin_diameter / 2 - edge_wall_thickness,
                $fn=cylinder_faces
            );
        }
    }
}


if (tests == "yes") {
    echo("** Running tests! **");

    test_count = len(test_sizes) - 1;
    for (i = [0:test_count]) {
        test_size = test_sizes[i];
        test_intro_str = str(str(i), " : ", str(test_size));
        size_str = str(str(test_size), " mm");

        echo(test_intro_str);

        face_side(coin_diameter = test_size, delta_x = test_offset * i);
    }

} else {
    tails_side(coin_diameter = diameter);

    color("red")
    translate(v = [diameter/2, diameter/2, profile_depth - 0.025]) 
    cylinder(h = base_thickness + 0.025 * 2, r = diameter/2);

    translate(v = [0, 0, profile_depth + base_thickness]) 
    face_side(coin_diameter = diameter);

    rim_side(coin_diameter = diameter);
}
