// Christmas Table Name Tags
//
// W&M logo -- W is heavy serif, M is high script
// the name -- is gold, script-lite
// garnish across the top, holly and berries in green and red?

// next steps:
//  - find (or create) vector of bow and leaves
//  - put everything together as a tag

use <..\libs\roundedcube.scad>

/* [Card Size] */
// Standard business card is 3 1/2 x 2" (88.9 x 50.8 mm)
height = 50.8; // 0.1
width = 88.9; // 0.1
// default of 1.0 mm
depth = 0.5; // 0.1
// default is 3.0 mm
corner_radius = 3; // 0.1
// likely want to set this as a multiple of your layer depth
embossed_text_depth = 0.40; // 0.01


/* [Logo] */
text_w = "W";
text_w_font = "Prata";  // [Amita, Alice, Prata, "Sorts Mill Goudy", Lora, Cambo, "Rozha One", "Yeseva One", "Linden Hill", Alegreya, Sanchez, Poppins, Cormorant, Eczar, "PT Serif", Cardo, Lora, "Playfair Display", "Libre Baskerville"]

text_ampersand = "&";
text_ampersand_font = "Quicksand:style=Bold";  // [Parisienne, Quicksand:style=Bold, "Great Vibes", Arizonia, "Rouge Script", "Alex Brush", Rochester, "Croissant One", Sofia, Allura, Amita, "Euphoria Script", Tangerine, Pacifico, "Shadows Into Light", Zeyada, "Great Vibes", Sacramento, "Marcellus SC", Quattrocento, "Oleo Script Swash Caps", Alegreya, Sanchez, Cormorant, "PT Serif", Cardo, Lora, "Libre Baskerville"]

text_m = "M";
text_m_font = "Rouge Script";  // ["Monsieur La Doulaise", Sacramento, Parisienne, "Rouge Script", Sail, Rochester, "Meie Script", Tangerine, "Dancing Script", "Great Vibes", Allura]
text_logo_size = 10;  // 0.1

/* [Bottom] */
text_bottom = "CHRISTMAS AT THE SMITH'S";
text_bottom_font = "Alice"; // [Cinzel, Kinta, "Alice", "Sanchez", "Yeseva One", "Poppins"]
text_bottom_size = 6;  // 0.1

/* [Names] */
text_name = "Test";
text_name_font = "Alex Brush";  // [Parisienne, "Great Vibes", Arizonia, "Alex Brush", "Monsieur La Doulaise", Rochester, Yesteryear, Sofia, Allura, Tangerine, "Dancing Script", Pacifico, "Great Vibes", Sacramento, "Oleo Script Swash Caps", "Playfair Display"]
// 1 pt = 0.3528 mm
text_name_size = 8.5;  // 0.1
name_line_width = 1.0; // 0.1

/* [Graphics] */
ribbon_svg = "./elements/ribbon only.svg";
leaves_svg = "./elements/leaves only.svg";
graphic_width = 261;
graphic_height = 85.5;
width_percent = 50;



module test_w(delta_y = 0, height = 0.5) {
    w_fonts = [
        // "Amita",  // *
        // "Alice",
        "Prata",  // *
        // "Sorts Mill Goudy",  // *
        // "Lora",
        // "Cambo",  // *
        // "Rozha One",
        // "Yeseva One",
        // "Linden Hill",
        // "Alegreya",
        // "Sanchez",
        // "Poppins",
        // "Cormorant",
        // "Eczar",  // *
        // "PT Serif",
        // "Cardo",
        // "Lora",
        // "Playfair Display",
        // "Libre Baskerville"
    ];
    w_delta_x = 10;

    echo("** W Font Test **")

    for (i = [0:len(w_fonts) - 1]) {
        translate(v = [i * w_delta_x, delta_y, 0])
        linear_extrude(height = height)
        text(
            text = text_w,
            size = text_w_size,
            font = w_fonts[i],
            halign = "center",
            valign = "center"
        );

        echo(str(str(i * w_delta_x), " ", w_fonts[i]));
    }
}

module test_ampersand(delta_y = 0, height = 0.5) {
    ampersand_fonts = [
        // "Parisienne",
        "Quicksand",  // *
        // "Great Vibes",
        // "Arizonia",
        // "Rouge Script",
        // "Alex Brush",
        // "Rochester",
        // "Croissant One",
        // "Sofia",  // *
        // "Allura",
        // "Amita",
        // "Euphoria Script",
        // "Tangerine",
        // "Pacifico",  // *
        // "Shadows Into Light",  // *
        // "Zeyada",
        // "Great Vibes",
        // "Sacramento", 
        // "Marcellus SC",  // *
        // "Quattrocento",
        // "Oleo Script Swash Caps",
        // "Alegreya",
        // "Sanchez",  // *
        // "Cormorant",
        // "PT Serif",
        // "Cardo",
        // "Lora",
        // "Libre Baskerville"
    ];
    ampersand_delta_x = 10;

    echo("** & Font Test **")

    for (i = [0:len(ampersand_fonts) - 1]) {
        translate(v = [i * ampersand_delta_x, delta_y, 0])
        linear_extrude(height = height)
        text(
            text = text_ampersand,
            size = text_ampersand_size,
            font = ampersand_fonts[i],
            halign = "center",
            valign = "center"
        );

        echo(str(str(i * ampersand_delta_x), " ", ampersand_fonts[i]));
    }
}

module test_m(delta_y = 0, height = 0.5) {
    m_fonts = [
        // "Monsieur La Doulaise",
        // "Sacramento",  // *
        // "Parisienne",
        "Rouge Script",  // *
        // "Sail",  // *
        // "Rochester",
        // "Meie Script",
        // "Tangerine",
        // "Dancing Script",
        // "Great Vibes",  // *
        // "Allura"
    ];
    m_delta_x = 10;

    echo("** M Font Test **")

    for (i = [0:len(m_fonts) - 1]) {
        translate(v = [i * m_delta_x, delta_y, 0])
        linear_extrude(height = height)
        text(
            text = text_m,
            size = text_m_size,
            font = m_fonts[i],
            halign = "center",
            valign = "center"
        );

        echo(str(str(i * m_delta_x), " ", m_fonts[i]));
    }
}

module test_bottom(delta_y = 0, height = 0.5) {
    bottom_fonts = [
        // "Cinzel",  // *
        // "Kinta",

        // "Amita",
        "Alice",  // *
        // "Prata",
        // "Sorts Mill Goudy",
        // "Lora",
        // "Cambo",
        // "Rozha One",
        // "Yeseva One",  // *
        // "Linden Hill",
        // "Alegreya",
        // "Sanchez",  // *
        // "Poppins",  // *
        // "Cormorant",
        // "Eczar",
        // "PT Serif",
        // "Cardo",
        // "Lora",
        // "Playfair Display",
        // "Libre Baskerville"
    ];
    bottom_delta_y = -10;

    echo("** Bottom Font Test **")

    for (i = [0:len(bottom_fonts) - 1]) {
        translate(v = [10, i * bottom_delta_y + delta_y, 0])
        linear_extrude(height = height)
        text(
            text = text_bottom,
            size = text_bottom_size,
            font = bottom_fonts[i],
            halign = "left",
            valign = "center"
        );

        echo(str(str(i * bottom_delta_y + delta_y), " ", bottom_fonts[i]));
    }
}

module test_names(delta_y = 0, height = 0.5) {
    names = [
        "William",
        "Marcy",
        "Amy",
        "Daniel",
        "Lily",
        "Vivian",
        "Sabela",
        "Grandpa",
        "Grandma",
        "Sarah",
        "Jade",
        "Alex",
        "Heather",
        "Kayandra",
        "Aryis",
        "Coral",
        "Campbell",
        "Kaitlyn"
    ];

    names_fonts = [
        // "Parisienne",  // *
        // "Great Vibes",
        // "Arizonia",  // *
        "Alex Brush",  // *
        // "Monsieur La Doulaise",
        // "Rochester",
        // "Yesteryear",
        // "Sofia",
        // "Allura",
        // "Tangerine",
        // "Dancing Script",
        // "Pacifico",
        // "Great Vibes",  // *
        // "Sacramento",  // *
        // "Oleo Script Swash Caps",
        // "Playfair Display"
    ];
    names_delta_y = -1.5 * text_name_size;
    names_delta_x = 125;

    echo("** Names Font Test **")
    echo(str(len(names)))

    for (
        i = [0:len(names_fonts) - 1],
        j = [0:len(names) - 1]
    ) {
        translate(v = [
            40 + j * names_delta_x,
            i * names_delta_y + delta_y,
            0
        ])
        linear_extrude(height = height)
        text(
            text = names[j],
            size = text_name_size,
            font = names_fonts[i],
            halign = "left",
            valign = "center"
        );

        if (i == 0) {
            echo(str(str(j), " ", names[j]));
        }

        // if (j == 0) {
        //     echo(str(str(i * names_delta_y + delta_y), " ", names_fonts[i]));
        // }
    }
}

module test_graphics(delta_x = 0, delta_y = 0) {
    // graphics show to the positive x and positive y of the "root" point

    color("red")
    translate(v = [delta_x, delta_y])
    linear_extrude(height = 0.5)
    import(file=ribbon_svg);

    color("ForestGreen")
    translate(v = [delta_x, delta_y])
    linear_extrude(height = 0.5)
    import(file=leaves_svg); 
}


module gen_text_wm(delta_x=0, delta_y=0, height=0.5) {

    // compression_2 = 0.85;
    // compression_3 = 0.85;
    // compression_2_y = 0.45;
    // compression_3_y = 0.55;

    text_w_size = text_logo_size;
    text_ampersand_size = text_logo_size * 0.5;
    text_m_size = text_logo_size * 1.125;

    compression_2 = 1.3;
    compression_3 = 0.9;
    compression_2_y = -0.30;
    compression_3_y = -1 * compression_2 * compression_2_y;

    delta_x_1 = delta_x;
    delta_y_1 = delta_y;
    delta_x_2 = delta_x_1 + (text_w_size + text_ampersand_size) / 2 * compression_2;
    delta_y_2 = delta_y_1 + -1 * (text_w_size + text_ampersand_size) / 2 * compression_2 * compression_2_y;
    delta_x_3 = delta_x_2 + (text_ampersand_size + text_m_size) / 2 * compression_3;
    delta_y_3 = delta_y_2 + -1 * (text_ampersand_size + text_m_size) / 2 * compression_3 * compression_3_y;

    color("gold")
    translate(v = [delta_x_1, delta_y_1, 0])
    linear_extrude(height = height)
    text(
        text = text_w,
        size = text_w_size,
        font = text_w_font,
        halign = "center",
        valign = "center"
    );

    color("darkblue")
    translate(v = [delta_x_2, delta_y_2, 0])
    linear_extrude(height = height)
    text(
        text = text_ampersand,
        size = text_ampersand_size,
        font = text_ampersand_font,
        halign = "center",
        valign = "center"
    );

    color("gold")
    translate(v = [delta_x_3, delta_y_3, 0])
    linear_extrude(height = height)
    text(
        text = text_m,
        size = text_m_size,
        font = text_m_font,
        halign = "center",
        valign = "center"
    );
}

module gen_text_house(delta_x=0, delta_y=0, height=0.5) {
    color("ForestGreen")
    translate(v = [delta_x, delta_y, 0])
    linear_extrude(height = height) 
    text(
        text = text_bottom,
        size = text_bottom_size,
        font = text_bottom_font,
        halign = "left",
        valign = "center"
    );
}

module gen_text_name(
    delta_x = 0,
    delta_y = 0,
    delta_z = 0,
    embossed_height = 0.5,
    width = 200,
    line_width = 0.5,
    my_name = "Test"
) {
    color("Gold")
    translate(v = [delta_x + width / 2, delta_y, delta_z])
    linear_extrude(height = embossed_height) 
    text(
        text = my_name,
        size = text_name_size,
        font = text_name_font,
        halign = "center",
        valign = "center"
    );

    text_length = textmetrics(
        text = my_name,
        size = text_name_size,
        font = text_name_font
    )["size"][0];

    x_length = textmetrics(
        text = "x",
        size = text_name_size,
        font = text_name_font
    )["size"][0];

    line_length = (width - text_length - 2 * x_length) / 2;

    echo("**");
    echo(text_length);
    echo(x_length);

    color("Gold")
    translate(v = [x_length / 2, delta_y, delta_z]) 
    cube(size=[line_length, line_width, embossed_height]);

    color("Gold")
    translate(v = [width - line_length - x_length / 2, delta_y, delta_z]) 
    cube(size=[line_length, line_width, embossed_height]);
}

// Gives a multiplier to get the graphics to be the expected size
function _graphics_scale(scale_percent=100, graphic_width=100, width=200)  = (
    (width / graphic_width * scale_percent) / 100
);

module gen_ribbon(delta_y = 0, delta_z = 0, embossed_height = 0.5, width = 200, scale_percent = 50) {
    // need to translate to the bottom left corner
    my_scale = _graphics_scale(
        scale_percent=scale_percent, graphic_width=graphic_width, width=width
    );

    color("red")
    translate(v = [width * (100 - scale_percent) / 100 / 2, delta_y, delta_z])
    scale(v = [my_scale, my_scale, 1])
    linear_extrude(height = embossed_height)
    import(file=ribbon_svg);
}

module gen_leaves(delta_y = 0, delta_z = 0, embossed_height = 0.5, width = 200, scale_percent = 50) {
    // need to translate to the bottom left corner
    my_scale = _graphics_scale(
        scale_percent=scale_percent, graphic_width=graphic_width, width=width
    );

    color("ForestGreen")
    translate(v = [width * (100 - scale_percent) / 100 / 2, delta_y, delta_z])
    linear_extrude(height = embossed_height)
    scale(v = [my_scale, my_scale, 1])
    import(file=leaves_svg);
}

// test_w();
// test_ampersand(delta_y = -10);
// test_m(delta_y = -20);
// test_bottom(delta_y = -20);
// test_names(delta_y = -40);
// test_graphics(delta_x = -261, delta_y = -85.5);

// echo("**")
// echo(_graphics_scale(scale_percent=100, graphic_width=graphic_width, width=200));

module test_layout() {
    gen_text_wm(delta_x=8+5, delta_y=-6+17);
    gen_text_house(delta_x=50, delta_y=10);
    gen_text_name(delta_x = 0, delta_y=35, width=190);
    gen_ribbon(delta_y = 50, width=190);
    gen_leaves(delta_y = 50, width=190);
}


ribbon_height = 0.60;
name_height = 0.4;

color("white")
difference() {
    roundedcube([width, height, depth], center = false, radius = corner_radius, apply_to = "z");

    gen_text_name(
        delta_x = 0,
        delta_y = height * name_height,
        delta_z = depth - embossed_text_depth,
        embossed_height = embossed_text_depth,
        width = width,
        line_width = name_line_width,
        my_name=text_name
    );
    gen_ribbon(
        delta_y = height * ribbon_height,
        delta_z = depth - embossed_text_depth,
        embossed_height = embossed_text_depth,
        width=width
    );
    gen_leaves(
        delta_y = height * ribbon_height,
        delta_z = depth - embossed_text_depth,
        embossed_height = embossed_text_depth,
        width=width
    );
}

gen_text_name(
    delta_x = 0,
    delta_y = height * name_height,
    delta_z = depth - embossed_text_depth,
    embossed_height = embossed_text_depth,
    width = width,
    line_width = name_line_width,
    my_name=text_name
);
gen_ribbon(
    delta_y = height * ribbon_height,
    delta_z = depth - embossed_text_depth,
    embossed_height = embossed_text_depth,
    width=width
);
gen_leaves(
    delta_y = height * ribbon_height,
    delta_z = depth - embossed_text_depth,
    embossed_height = embossed_text_depth,
    width=width
);
