// Hipster PDA Case
//
// designed to hold a stack of 3x5 cards and a pen

// cards are 76x128 mm
// design pen is a F301
//      grip is ⌀ 8.8 mm
//      across clip is 12 mm
//      stored length is 130 mm

/* [Hipster PDA] */

card_width = 76;
card_length = 128;
pen_diamter = 9;
pen_clip_extra = 3;
pen_length = 130;
pen_height_under_clip = 80;
base_height = 0.75;
font = "Aldo";
front_text_1 = "Hipster PDA";
// in mm
front_text_1_font_size = 15;
front_text_2 = "Wm Minchin";
front_text_2_font_size = 6;
back_text_3 = "0092A / 2024-01-18";
back_text_3_font_size = 6;
back_text_4 = "3x5 cards + F301 pen";
back_text_4_font_size = 6;
// back_text_5 is case dimensions
back_text_5_font_size = 6;
// in mm
back_font_size = 8;
text_deboss_depth = 0.5;
wall_thickness = 2.0; // 0.01
width_play = 0.5;
depth_play = 0;
height_play = 1;
pen_play = 0.6;

// based on Swatch_Box_Remix_V5.scad (my print 0027)
// Output Type
part = "both";  // [top, bottom, both, plate, all]

/* [Case Dimensions] */

// Width (mm) of case walls
case_width = wall_thickness;  // [2:5]
// Height (mm) of case floor/ceiling
case_height = wall_thickness;                 // [2:5]
// Height (mm) of case overlap
case_lid_overlap = 4;                 // [2:5]
// Length (mm) of snap-in teeth
case_teeth_length = 20;                // [10:40]
teeth_d=1.5;
teeth_d_wiggle=0.3;

/* [Slot Dimensions] */
// Length (mm) of slot separators, i.e. how far do they stick into the box
slot_length = 0.8;					// [0:10]
// Width (mm) of slot separators
slot_width = 0.85;					// [1:3]
// Height (mm) of slot separators; controls bottom piece height
slot_height = 96;				// [10:30]
card_y = 0.6;
card_y_play = 0.1;

/* [Swatch Dimensions]  */

// Length (mm) of each swatch
swatch_x_1 = card_width + 2 * slot_length + width_play;
// Width (mm) of each swatch, i.e. the divider card
swatch_y = card_y + card_y_play;
// Height (mm) of each swatch
swatch_z = max(card_length, pen_length) + height_play;

swatch_x_2 = pen_diamter + pen_play + pen_clip_extra;

echo("swatch_x_2", swatch_x_2);


/* [Hidden] */

side_by_side_boxes = 2;
swatches = 5;

wiggle_x = 0.4;
slot_x = (
    swatch_x_1 + swatch_x_2
    + wiggle_x
    + (side_by_side_boxes - 1) * (case_width)
);   	// length of slots
slot_y = swatch_y;   	// width of slots
slot_z = swatch_z + 4;      // height of slots, some extra space to make them fit

inner_x = slot_x;
inner_y = (swatches * (slot_y + slot_width)) + slot_width;
echo("inner_y", swatches, slot_y, slot_width, inner_y);

case_width2 = case_width / 2;
case_x = inner_x + (case_width * 2);
case_y = inner_y + (case_width * 2);
case_z = swatch_z + (case_height * 2);

echo (case_x, case_y, case_z);

back_text_5 = str(
    str(case_x),
    " x ",
    str(case_y),
    " x ",
    str(case_z),
    " mm"
);

divider_x = case_width + swatch_x_1 + wiggle_x;
*for(j=[0:1:swatches-1])
for(i=[0:1:side_by_side_boxes-1])
    translate([divider_x*i, j*(slot_y+slot_width), 0])
        translate([case_width,case_width+swatch_y/2,case_height])
            color("white")
                cube([swatch_x_1,swatch_y,swatch_z]);


print_part();

module print_part()
{
    if (slot_height > (swatch_z - case_lid_overlap))
    {
        echo("Slot height would exceed the height of the case");
    }
    
	if (part == "top")
    {
        CaseTop();
	}
    else if (part == "bottom")
    {
		CaseBottom();
	}
    else if (part == "both")
    {
		CaseTop();
		CaseBottom();
    }
    else if (part == "plate")
    {
		Plate();
    }    
    else if (part == "all")
    {
		CaseTop();
		CaseBottom();
        Plate();
    }
}

module CaseTop()
{
    shift_x = (part == "both" && side_by_side_boxes > 1 ? inner_x + 2 * case_width     : -5);
    shift_y = (part == "both" && side_by_side_boxes > 1 ? inner_y + 2 * case_width + 5 :  0);
    translate([shift_x, shift_y, slot_z - slot_height + case_height])
    rotate([0, 180, 0])
    {
        translate([0, case_y])
        mirror([0, 1, 0])
            TopWallX();
            difference() {
                TopWallX();

                color("violet")
                // sets at top of the middle of the lid, with text upside down to
                // origin (but right way up for printed box)
                translate(v = [case_x / 2, text_deboss_depth - 0.01, slot_z - slot_height])
                rotate(a = [90, 0, 0])
                linear_extrude(height = text_deboss_depth)
                {
                    translate([0, -1 * front_text_1_font_size * 0.8])
                    text(
                        text = front_text_1,
                        size = front_text_1_font_size,
                        font = font,
                        halign = "center",
                        valign = "center"
                    );

                    translate([0, -1 * (2 * front_text_1_font_size + front_text_2_font_size) * 0.8])
                    text(
                        text = front_text_2,
                        size = front_text_2_font_size,
                        font = font,
                        halign = "center",
                        valign = "center"
                    );
                }
            }
        
        translate([case_x, 0])
        mirror([1, 0, 0])
            TopWallY();
            TopWallY();

        color("orange")
        translate([case_width, case_width, slot_z - slot_height])
            cube([inner_x, inner_y, case_height]);
    }
}

module CaseBottom()
{
    translate([0, case_y])
    mirror([0, 1, 0])
        BottomWallX();
        difference() {
            BottomWallX();

            color("violet")
            translate(v = [back_text_3_font_size * 0.8, text_deboss_depth - 0.01, 0])
            rotate(a = [90, 0, 0])
            linear_extrude(height = text_deboss_depth) {
                translate([0, (back_text_5_font_size) * 0.8])
                text(
                    back_text_5,
                    size = back_text_5_font_size,
                    font = font,
                    halign = "left",
                    valign = "center"
                );

                translate([0, (back_text_4_font_size + 2 * back_text_5_font_size) * 0.8])
                text(
                    back_text_4,
                    size = back_text_4_font_size,
                    font = font,
                    halign = "left",
                    valign = "center"
                );

                translate([0, (back_text_3_font_size + 2 * back_text_4_font_size + 2 * back_text_5_font_size)* 0.8])
                text(
                    back_text_3,
                    size = back_text_3_font_size,
                    font = font,
                    halign = "left",
                    valign = "center"
                );
            }
        }

    translate([case_x, 0])
        mirror([1, 0, 0])
            BottomWallY(1);

    BottomWallY(1);

    divider_x = case_width + swatch_x_1 + wiggle_x;
    if(side_by_side_boxes > 1)
    {
        for(i=[1:1:side_by_side_boxes-1])
        // for(i=[1:1:0])
            translate([divider_x*i, 0])
            {
                BottomWallY(toplid=0);

                translate([case_width, case_width])
                {
                    translate([-slot_length-case_width, 0])
                        Swatches();
            
                    // translate([0, 0])
                    //     Swatches();                
                }
            }
    }
        
    translate([case_width, case_width])
    {
        // bottom floor
        color("blue")    
        cube([inner_x, inner_y, case_height]);

        translate([0, 0])
            Swatches();
        // translate([inner_x - slot_length, 0])
        //     Swatches();
    }

    // hole for pen
    color("violet")
    translate(v = [divider_x + wall_thickness, wall_thickness, wall_thickness])
    difference() {
        cube(size = [
            pen_diamter + pen_play + pen_clip_extra,
            pen_diamter + pen_play,
            min(pen_height_under_clip, slot_height)
        ]);

        translate(v = [
            (pen_diamter + pen_play) / 2 + pen_clip_extra,
            (pen_diamter + pen_play) / 2,
            -0.01
        ]) 
        cylinder(
            h = pen_height_under_clip + 0.02,
            d = pen_diamter + pen_play,
            $fn = 360
        );
    }

    if (slot_height > pen_height_under_clip) {
        color("violet")
        translate(v = [
            divider_x + wall_thickness + (pen_diamter + pen_play) / 2 + pen_clip_extra,
            wall_thickness,
            wall_thickness + pen_height_under_clip
        ])
        difference() {
            cube(size = [
                (pen_diamter + pen_play) / 2,
                pen_diamter + pen_play,
                slot_height - pen_height_under_clip
            ]);

            // translate(v = [pen_diamter / 2 + pen_clip_extra, pen_diamter / 2, 1])
            translate(v = [0, (pen_diamter + pen_play) / 2, -0.01]) 
            cylinder(
                h = slot_height + 0.02,
                d = pen_diamter + pen_play,
                $fn = 360
            );

            // cube(size= [pen_diamter / 2 + pen_clip_extra, pen_diamter, slot_height - pen_height_under_clip]);
        }
    }

    }






/* ------- */
// Top Box //
/* ------- */

bigger_lip_to_make_it_fit = 0.4;

module TopWallX()
{
    color("orange")
    translate([0, 0, case_lid_overlap+bigger_lip_to_make_it_fit])
    resize([0, 0, slot_z - slot_height - case_lid_overlap-bigger_lip_to_make_it_fit + case_height])
        WallX();
    
    color("orange")
    {
        difference()
        {
            resize([0, 0, case_lid_overlap+bigger_lip_to_make_it_fit])
                WallX();
            
            translate([case_width, case_width2 - 0.2])
                cube([inner_x, case_width2 + 0.2, case_lid_overlap+bigger_lip_to_make_it_fit]);
        
            translate([case_width2 - 0.2, case_width2 - 0.2])
            resize([case_width2 + 0.4, case_width2 + 0.4, case_lid_overlap+bigger_lip_to_make_it_fit])
                Corner();
        
            translate([inner_x + case_width + case_width2 + 0.2, case_width2 - 0.2])
            mirror([1, 0, 0])
            resize([case_width2 + 0.4, case_width2 + 0.4, case_lid_overlap+bigger_lip_to_make_it_fit])
                Corner();
        }
    }
    
    // snap-in teeth
    color("orange")
    translate([case_x / 2 - case_teeth_length * 3/2, case_width2 - 0.4, case_lid_overlap / 2])
    rotate([0, 90, 0])
        intersection()
        {
            cylinder(h = case_teeth_length, d = teeth_d+teeth_d_wiggle, $fn = 360);
            translate([-teeth_d/2,0,0])
                cube([teeth_d*2,teeth_d*2,case_teeth_length]);
        }

    color("orange")
    translate([case_x / 2 + case_teeth_length * 1/2, case_width2 - 0.4, case_lid_overlap / 2])
    rotate([0, 90, 0])
        intersection()
        {
            cylinder(h = case_teeth_length, d = teeth_d+teeth_d_wiggle, $fn = 360);
            translate([-teeth_d/2,0,0])
                cube([teeth_d*2,teeth_d*2,case_teeth_length]);
        }
}


module TopWallY()
{
    color("orange")
    translate([0, 0, case_lid_overlap + bigger_lip_to_make_it_fit])
    resize([0, 0, slot_z - slot_height - case_lid_overlap-bigger_lip_to_make_it_fit + case_height])
        WallY();
    
    color("orange")
    translate([0, case_width])
        cube([case_width2 - 0.2, inner_y, case_lid_overlap+bigger_lip_to_make_it_fit]);
}





/* ---------- */
// Bottom Box //
/* ---------- */

module BottomWallX()
{
    //color("red")
    resize([0, 0, slot_height + case_height])
        WallX();
    
    //color("red")
    translate([case_width2, case_width2, slot_height + case_height])
    {
        resize([case_width2, case_width2, case_lid_overlap])
            Corner();
        
        translate([inner_x + case_width, 0])
        mirror([1, 0, 0])
        resize([case_width2, case_width2, case_lid_overlap])
            Corner();
        
        // remove dedent for snap-in teeth
        translate([case_width2, 0])
        difference()
        {
            cube([inner_x, case_width2, case_lid_overlap]);
            translate([(inner_x / 2 - case_teeth_length * 3/2) - 0.2, 0, case_lid_overlap / 2])
            rotate([0, 90, 0])
                cylinder(h = case_teeth_length + 0.4, d = teeth_d, $fn = 360);

            translate([(inner_x / 2 + case_teeth_length * 1/2) - 0.2, 0, case_lid_overlap / 2])
            rotate([0, 90, 0])
                cylinder(h = case_teeth_length + 0.4, d = teeth_d, $fn = 360);
        }
    }
}

module BottomWallY(toplid=0)
{
    color("red")
    resize([0, 0, slot_height + case_height])
        WallY();
    
    if (toplid==1)    
    color("red")
    translate([case_width2, case_width, slot_height + case_height])
        cube([case_width2, inner_y, case_lid_overlap]);
    
}

module Swatches()
{
    for (i = [0 : slot_y + slot_width : inner_y])
    {
        color("green")
        translate([0, i, case_height])
            cube([slot_length, slot_width, slot_height]);
    }
}





/* --------- */
// Universal //
/* --------- */

module WallX()
{
    translate([case_width, 0])
        cube([inner_x, case_width, 1]);
    
    translate([case_x, 0])
    mirror([1, 0, 0])
        Corner();
        Corner();
}

module WallY()
{
    translate([0, case_width])
        cube([case_width, inner_y, 1]);
}

module Corner()
{
    translate([case_width, case_width])
    difference()
    {
        cylinder(h = 1, r = case_width, $fn = 360);
        
        translate([-case_width, 0])
            cube([10, case_width, 1]);
        translate([0, -case_width])
            cube([case_width, case_width, 1]);
    }
}


module Plate() {
    shift_plate_x = (part == "plate" ? 0 : case_x + 5);
    translate([shift_plate_x, 0, 0])
    cube([card_width, card_length, card_y]);
}
