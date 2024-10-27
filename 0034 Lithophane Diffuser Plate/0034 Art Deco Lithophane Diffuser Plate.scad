// in mm, original was 107mm, slot is 109.67 mm
length_x = 109;
// in mm, original was 149mm, leaves ~1.5mm between plate and bottom "lid"
length_y = 150;
// plate thickness, in mm, original was 1.5mm
length_z = 1.5;

// chamfer (corner cut) on XY plane, in mm, original was 2mm
corner_chamfer = 2;

/// Generate Object!

use <..\libs\Chamfers-for-OpenSCAD\Chamfer.scad>;

chamferCube(
    [length_x, length_y, length_z],
    chamfers=[
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [corner_chamfer, corner_chamfer, corner_chamfer, corner_chamfer]
    ]
);

