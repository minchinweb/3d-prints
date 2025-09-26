// WM 0100 -- 4 Colour HueForge Swatch

base_depth = 0.96;
step_width = 3;
step_length = 10;

step_depth = 0.08;
step_count = 12;

base_color = "black";
color_1 = "red";
color_2 = "gold";
color_3 = "cyan";

text_depth = 0.64;
text_size = 7;
font = "Aldo";

layer_height = step_depth * step_count;
length = step_length * 3;
width = text_size * 1.8 + step_width * step_count + length;


module layer_1() {
    difference() {
        cube(size = [width, length, base_depth]);

        translate(v = [text_size * 1.4, text_size * 0.4, base_depth - text_depth]) 
        rotate(a = [0, 0, 90])
        linear_extrude(height = text_depth + 0.01) 
        text(
            base_color,
            size = text_size,
            font = font,
            valign = "baseline"
        );
    }
}

module layer_2() {
    for (i = [1:1:step_count]) {
        translate(v = [text_size * 1.8 + step_width * (i - 1), step_length * 2, base_depth]) 
        cube(size = [step_width, step_length, step_depth * i]);
    }

    translate(v = [text_size * 1.8, step_length * 0, base_depth])
    cube(size=[step_width * step_count, step_length * 2, layer_height]);

    translate(v = [text_size * 2.2 + step_width * step_count, step_length * 2.5, base_depth])
    linear_extrude(height = text_depth)
    text(
        color_1,
        size = text_size,
        font = font,
        valign = "center"
    );

    translate(v = [text_size * 2.2 + step_width * step_count, step_length * 1.5, base_depth])
    linear_extrude(height = layer_height)  
    text(
        color_2,
        size = text_size,
        font = font,
        valign = "center"
    );

    translate(v = [text_size * 2.2 + step_width * step_count, step_length * 0.5, base_depth])
    linear_extrude(height = layer_height)
    text(
        color_3,
        size = text_size,
        font = font,
        valign = "center"
    );
}

module layer_3() {
    for (i = [1:1:step_count]) {
        translate(v = [text_size * 1.8 + step_width * (i - 1), step_length * 1, base_depth + layer_height]) 
        cube(size = [step_width, step_length, step_depth * i]);
    }

    translate(v = [text_size * 1.8, step_length * 0, base_depth + layer_height])
    cube(size=[step_width * step_count, step_length * 1, layer_height]);

    translate(v = [text_size * 2.2 + step_width * step_count, step_length * 1.5, base_depth + layer_height])
    linear_extrude(height = text_depth)
    text(
        color_2,
        size = text_size,
        font = font,
        valign = "center"
    );

    translate(v = [text_size * 2.2 + step_width * step_count, step_length * 0.5, base_depth + layer_height])
    linear_extrude(height = layer_height)
    text(
        color_3,
        size = text_size,
        font = font,
        valign = "center"
    );
}

module layer_4() {
    for (i = [1:1:step_count]) {
        translate(v = [text_size * 1.8 + step_width * (i - 1), step_length * 0, base_depth + layer_height * 2]) 
        cube(size = [step_width, step_length, step_depth * i]);
    }

    translate(v = [text_size * 2.2 + step_width * step_count, step_length * 0.5, base_depth + layer_height * 2])
    linear_extrude(height = text_depth) 
    text(
        color_3,
        size = text_size,
        font = font,
        valign = "center"
    );
}


color("darkgrey")
layer_1();

color("red")
layer_2();

color("goldenrod")
layer_3();

color("cyan")
layer_4();
