// Need to create spacer for mounting a monitor to a VERA mount, as the
// provided washers/spacers are too long.

// inch in mm
in = 25.4;

// inside diamter; match original
// measured at 6.4 mm; assume 1/4"
inside_d = 1/4 * in;


// outside diamter; match original
// measured at 12.27mm; assume 1/2"
outside_d = 1/2 * in;

// height; original was 1/2"
// measued at 12.98 mm; assume 1/2"
// do 1/8" or 3/16"?
height = 3/16 * in;

// change circle resolution
$fn = 4 * 10;

difference() {
    cylinder(h = height, d = outside_d);

    cylinder(h = height, d = inside_d);
}
