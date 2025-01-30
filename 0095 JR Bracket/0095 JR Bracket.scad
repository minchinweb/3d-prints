// Bracket for holding wood in aluminum channel

// Time spent
// Jan 25/25 -- 3/4 hr
// Jan 25/25 -- 1 hr
//
// Print time
// x2 PLA Design A -- 0h55
// x2 PLA Design B -- ~1hr 
// x2 PETG -- 1h
// x30 PETG -- 11h58

// Asking Price:
// 1.75hr x $50/hr = $87.50
// 15     x $2/hr  = $30
//           Total = $117.50  (or $3.92/ea)


// Version A comments
//
// - filet the outside corner (in case the aluminum channel isn't perfectly
//   clean)
// - actual clearances (for fins, including back) at 17.6, 16.6, 17.0, and
//   16.3mm (so an average of 16.875mm)
// - concern that if the fins are too long, the bottom one will hit the
//   aluminum without allowing the wood all the way in
// - asked for final ones to be printed in white (in case they're seen)

// Version B changes
//
// - add back camfer
// - adjust shelf lengths
// - shorten bottom shelf
// - make shelves full width
// - remove back plate thickness from shelf length
// - rotate the whole assembly so it comes out on the side (for better print
//   strength)
// - go from 3 to 4 shelves


base_w = 50;
base_l = 12;
base_d = 4;

back_h = 22;

shelf_w = base_w;
shelf_thickness = 0.6;
shelf_count = 4;
// measured gap
shelf_l = 17.6;
// how much "extra" to add to the shelf
shelf_l_extended = 1;
// the minimum measured shelf
shelf_l_min = 16.3;
// in degrees
shelf_angle = -15;

label_text = "0095B / WM";
label_font = "Aldo";
label_deboss = 0.6;
label_font_size = 6;

camfer_size = 3;


module jason_widget() {
    // echo(cos(abs(shelf_angle)));
    shelf_l_2 = (shelf_l + shelf_l_extended - base_d) * cos(abs(shelf_angle));
    shelf_l_2_min = (shelf_l_min - base_d) * cos(abs(shelf_angle));

    difference() {
        cube([base_w, base_l, base_d]);

        translate(v = [base_w/2, base_l, 0])
        my_camfer(length = base_w, camfer_size = camfer_size);
    }

    back_delta_y = base_l - base_d;
    translate(v = [0, back_delta_y, 0])
    difference() {
        cube([base_w, base_d, back_h]);

        translate(v = [base_w/2, base_l - back_delta_y, 0])
        my_camfer(length = base_w + 0.02, camfer_size = camfer_size);

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
        if (i == 1) {
            translate(v = [shelf_delta_x, back_delta_y, i * shelf_delta_z + base_d])
                rotate(a=[-1 * shelf_angle, 180 , 180])
                cube([shelf_w, shelf_l_2_min, shelf_thickness]);
        } else {
            translate(v = [shelf_delta_x, back_delta_y, i * shelf_delta_z + base_d])
                rotate(a=[-1 * shelf_angle, 180 , 180])
                cube([shelf_w, shelf_l_2, shelf_thickness]);
        }
    }
}

module my_camfer(length = 100, camfer_size = 10) {
    rotate(a=[45, 0, 0])
        cube([length, camfer_size, camfer_size], center=true);
}

rotate(a = [0, 270, 0])
    jason_widget();
