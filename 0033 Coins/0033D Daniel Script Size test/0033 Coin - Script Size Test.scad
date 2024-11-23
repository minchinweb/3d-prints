/* [General] */
// printer's layer height, in mm
layer_height = 0.06;

// bas releif depth, in layers
profile_depth_layers = 12;
// center thickness, in layers
base_thickness_layers = 4;

edge_wall_thickness = 0.22 * 3;


/* [Coin Elements - Name] */
name_image = "../0033B Daniel Sou Noir/Name A - Daniel - 20241027.png";
name_pixels = 300;
name_rotate = 335;
name_delta_x = 11;
name_delta_y = 0;
name_scale = 1.905;  // 40/21

/* [Coin Elements - Year] */
year_image = "../0033B Daniel Sou Noir/Year A - 2024 - 20241027.png";
year_pixels = 300;
year_rotate = 305;
year_delta_x = 0;
year_delta_y = -7.2;
year_scale = 1.619;  // 34/21

/* [Coin Elements - Value] */
value_image = "../0033B Daniel Sou Noir/Value A - sou noir - 20241027.png";
value_pixels = 300;
value_rotate = 345;
value_delta_x = -5;
value_delta_y = 2.3;
value_scale = 1.333;  // 28/21

/* [Coin Elements - Scale] */
scale_font_size = 5;
scale_delta_x = 0;
scale_delta_y = 0;


/* [Rendering] */
cylinder_faces = 60;

/* [Testing] */
// coin diamter, for single test
diameter = 21;
//test_sizes = [16, 17, 18, 19, 21, 23, 24, 25, 27, 28, 31, 32, 38, 40];
test_sizes = [16, 18, 21, 23, 25, 28, 31, 34, 38, 40];
tests = "no";  // ["yes", "no"]
// offset tests my this, should be greater than largest test size, in mm
test_offset = 42;
test_coins_per_row = 5;


//  Create coin

// convert from layers to mm
profile_depth = profile_depth_layers * layer_height;
base_thickness = base_thickness_layers * layer_height;

module test_side(
    coin_diameter,
    delta_x = 0,
    delta_y = 0,
    base_thickness = 0.1,
    add_base = true,
    add_rim = true,
    add_name = true,
    add_year = true,
    add_value = true,
    add_scale = true
) {
    master_scale = coin_diameter / diameter;
    name_xy_scale = coin_diameter / name_pixels * name_scale;
    year_xy_scale = coin_diameter / year_pixels * year_scale;
    value_xy_scale = coin_diameter / value_pixels * value_scale;
    z_scale = profile_depth / 100;
    
    // face "base"
    if (add_base) {
        color("red")
        translate(v = [
            coin_diameter / 2 + delta_x,
            coin_diameter / 2 + delta_y,
            0
        ])
        cylinder(h = base_thickness, d = coin_diameter);
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

    if (add_year) {
        translate(v = [
            coin_diameter / 2 + year_delta_x * master_scale + delta_x,
            coin_diameter / 2 + year_delta_y * master_scale + delta_y,
            base_thickness
        ])
        rotate(a = year_rotate)
        scale(v = [year_xy_scale, year_xy_scale, z_scale])
            surface(file=year_image, center=true);
    }

    if (add_value) {
        translate(v = [
            coin_diameter / 2 + value_delta_x * master_scale + delta_x,
            coin_diameter / 2 + value_delta_y * master_scale + delta_y,
            base_thickness
        ])
        rotate(a = value_rotate)
        scale(v = [value_xy_scale, value_xy_scale, z_scale])
            surface(file=value_image, center=true);
    }

    if (add_scale) {
        translate(v = [
            coin_diameter / 2 + scale_delta_x * master_scale + delta_x,
            coin_diameter / 2 + scale_delta_y * master_scale + delta_y,
            base_thickness
        ])
        linear_extrude(height = profile_depth)
        text(
            str(coin_diameter),
            font = "Aldo",
            size = scale_font_size,
            halign = "center",
            valign = "center"
        );
    }

    if (add_rim) {
        // edge wall
        color("blue")
        // translate(v = [coin_diameter / 2 + x, coin_diameter / 2 + y, base_thickness])
        difference() {
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


if (tests == "yes") {
    echo("** Running tests! **");

    test_count = len(test_sizes) - 1;
    for (i = [0:test_count]) {
        test_size = test_sizes[i];
        test_intro_str = str(str(i), " : ", str(test_size));
        size_str = str(str(test_size), " mm");

        echo(test_intro_str);

        test_side(
            coin_diameter = test_size,
            delta_x = test_offset * (i % 5),
            delta_y = test_offset * floor(i / 5)
        );
    }

} else {
    test_side(coin_diameter = diameter);
}
