// Bracket for holding wood in aluminum channel

base_w = 50;
base_l = 12;
base_d = 4;

back_h = 22;

shelf_w = 30;
shelf_thickness = 0.6;
shelf_count = 3;
shelf_l = 19;
// in degrees
shelf_angle = -15;

label_text = "0095A / WM";
label_font = "Aldo";
label_deboss = 0.6;
label_font_size = 6;


cube([base_w, base_l, base_d]);

back_delta_y = base_l - base_d;
translate(v = [0, back_delta_y, 0])
difference() {
    cube([base_w, base_d, back_h]);

    translate(v = [base_w / 2, base_d - label_deboss, back_h / 2]) 
    rotate(a = [90, 0, 180])
    linear_extrude(height = label_deboss + 0.01) {
        text(
            text = label_text,
            size = label_font_size,
            font = label_font,
            halign = "center",
            valign = "center"
        );
    }
}

shelf_delta_z = (back_h - base_d) / (shelf_count);
shelf_delta_x = (base_w - shelf_w) / 2;
for (i = [1:shelf_count]) {
    translate(v = [shelf_delta_x, back_delta_y, i * shelf_delta_z + base_d])
        rotate(a=[-1 * shelf_angle, 180 , 180])
        cube([shelf_w, shelf_l, shelf_thickness]);
}
