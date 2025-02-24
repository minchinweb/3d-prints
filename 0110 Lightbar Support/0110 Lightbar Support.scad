// Lightbar support

// My screen is rounded (3800R), while the lightbar is flat.
// https://www.newegg.ca/acer-34-uw-qhd-60-hz-100-hz-predator-x34-ips-black/p/N82E16824009869
//
// Also, the lightbar needs to be slightly out from the screen because of this.
//
// "a display with "3800R curvature" has a 3800 mm radius of curvature."


difference() {
    translate([0, -20, 0])
    cube([80, 20 * 2, 2]);

    translate([0, 3800, 0]) 
    cylinder(h = 2, r = 3800, $fn=4000);
    
    translate([40, -6 * 1.4, 2 - 0.6])
    linear_extrude(0.6 + 0.01)
    text(text = "0110A", size = 6, font = "Aldo", halign = "center");
}

translate([0, -20, -0.8])
cube([80, 40, 0.8]);
