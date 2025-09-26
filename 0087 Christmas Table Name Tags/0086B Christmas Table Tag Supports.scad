
// use <./0086 Christmas Table Name Tags.scad>
use <..\libs\roundedcube.scad>

/* [Support] */
// Pass 1: 6.34
height = 3.175;  // 0.1
depth = 25.4;  // 0.1
// Pass 1: 0.2
card_play = 0.4;  // 0.01

corner_radius = 3;  // 0.1

slot_bottom_clearance = 1.25; // 0.1

// slope of card support, in degrees
card_slope = 20;

/* [Card Size] */
// Standard business card is 3 1/2 x 2" (88.9 x 50.8 mm)
card_height = 50.8; // 0.1
card_width = 88.9; // 0.1
// default of 1.0 mm
card_depth = 0.5; // 0.1

embossed_text_depth = 0.40; // 0.01

/* [Bottom] */
// text_bottom = "CHRISTMAS AT THE MINCHIN'S";
text_bottom = "Christmas at the Minchin's";
// text_bottom = "CHRISTMAS AT THE SMITH'S";
text_bottom_font = "Alice"; // [Cinzel, Kinta, "Alice", "Sanchez", "Yeseva One", "Poppins"]
text_bottom_size = 5;  // 0.1

/* [More] */
$fn = 120;

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


module gen_bottom_text(
    delta_x = 0,
    delta_y = 0,
    delta_z = 0,
    embossed_height = 0.5,
    width = 200,
    my_text = "Test"
) {
    color("ForestGreen")
    translate(v = [delta_x + width / 2, delta_y, delta_z])
    linear_extrude(height = embossed_height) 
    text(
        text = my_text,
        size = text_bottom_size,
        font = text_bottom_font,
        halign = "center",
        valign = "center"
    );
}

// Create block

color("white")
difference() {
    roundedcube(
        [card_width, depth, height],
        center = false,
        radius = corner_radius,
        apply_to = "z"
    );

    translate(v = [0, depth * 1/2 * 0.6, slot_bottom_clearance])
    rotate(a = [-1 * card_slope, 0, 0]) 
    cube([card_width, card_depth + card_play, height * 2]);

    gen_bottom_text(
        // delta_z = height - embossed_text_depth,
        delta_z = height,
        embossed_height = 100,
        width = card_width,
        my_text = text_bottom
    );
}

// color("red")
// translate(v = [0, depth * 1/2 * 0.6, slot_bottom_clearance])
// rotate(a = [-1 * card_slope, 0, 0]) 
// cube([card_width, card_depth + card_play, height * 2]);

gen_bottom_text(
    delta_y = text_bottom_size * 1,
    delta_z = height - embossed_text_depth,
    // delta_z = height,
    embossed_height = embossed_text_depth,
    // embossed_height = 100,
    width = card_width,
    my_text = text_bottom
);