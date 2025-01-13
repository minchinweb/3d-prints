// the point of this file is to be a sort of DSL for constructing keycaps.
// when you create a method chain you are just changing the parameters
// key.scad uses, it doesn't generate anything itself until the end. This
// lets it remain easy to use key.scad like before (except without key profiles)
// without having to rely on this file. Unfortunately that means setting tons of
// special variables, but that's a limitation of SCAD we have to work around

// include <./includes.scad>
include <../libs/KeyV2/includes.scad>


// example key
// dcs_row(5) legend("⇪", size=9) key();

// example row
// for (x = [0:1:4]) {
//     translate_u(0,-x) dcs_row(x) key();
// }

// for (x = [0:1:4]) {
//     translate_u(0,-x) dsa_row(x) key();
// }

// for (x = [0:1:4]) {
//     translate_u(0,-x) g20_row(x) key();
// }

// for (x = [0:1:4]) {
//     translate_u(0,-x) oem_row(x) key();
// }

// for (x = [0:1:4]) {
//     translate_u(0,-x) sa_row(x) key();
// }

// example layout
// preonic_default("dcs") key();


my_keys = [
    "HDG", "APR", "NAV", "BC",
    "FD", "BNK",  // "BANK"
    "AP", "YD", "XFR",  // box around AP and YD
    "ALT", "VS", "FLC", "VNV", "SPD"
];

my_key_xy = [
    [1, 0], [1, 1], [2, 0], [2, 1],
    [2, 3], [2, 5],
    [1, 3], [2, 2], [2, 6],
    [1, 2], [3, 0], [3, 2], [3, 1], [3, 3]
];

for (i = [0:len(my_keys) - 1]) {
    echo(my_key_xy[i], my_keys[i]);

    translate_u(my_key_xy[i][1], my_key_xy[i][0] * -1)
        g20_row(my_key_xy[i][0])
        legend(my_keys[i], size=4)
        key();
}
