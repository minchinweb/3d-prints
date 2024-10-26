opening_x = 3;  // in mm
opening_y = 38;  // in mm

gap_x = 1/4;
gap_y = 1;

length_z = 10;  // in mm

wall_size = 1;


length_x = opening_x + gap_x + wall_size * 2;
length_y = opening_y + gap_y + wall_size * 2;

difference() {
    cube(size = [length_x, length_y, length_z]);

    translate([gap_x /2 + wall_size, gap_y/2 + wall_size, -1]) 
    cube([opening_x, opening_y, length_z + 2]);

    color("red")
    translate([0.5, length_y/2, length_z/2 - 1/2])
    rotate(a = [90, 0, 90])
    rotate(a = [0, 180, 0])
    linear_extrude(height = 0.5) {
        text(
            "Disgust",
            size = 5,
            font = "Aldo",
            halign = "center",
            valign = "center"
        );
    }
}
