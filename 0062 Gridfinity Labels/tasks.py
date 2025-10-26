from invoke import task

LABELS = [
    ## Test Lables
    # "William",
    # "{head(square)} {bolt(50,button)}\\nM5×50",
    # "{circle} {nut_profile} {locknut_profile}\\nTest",

    ## 0062C -- Nov 24, 2024
    # "{head(hex)} {bolt(4,countersunk)}\\nM3×4",  # DIN7991
    # "{nut} {locknut_profile}\\nM2.5",  # DIN985, locking
    # "{nut} {locknut_profile}\\nM3",    # DIN985, locking
    # "{head(hex)} {bolt(10,socket)}\\nM2.5×10",
    # "{head(hex)} {bolt(14,socket)}\\nM2.5×14",
    # "{head(hex)} {bolt(18,socket)}\\nM2.5×18",
    # "{circle} {box(2.0)}\\n{magnet} 6x2",

    ## 0062D -- Dec 5, 2024
    # "{washer} {box(0.5)}\\nM2.5",  # M2.5x5.5x0.5
    # "{washer} {box(0.5)}\\nM3",    # M3x6x0.5
    # "{nut} {nut_profile}\\nM2.5",  # DIN934
    # "{nut} {nut_profile}\\nM3",    # DIN934
    # "{head(hex)} {bolt(6,countersunk)}\\nM3×6",  # DIN7991
    # "{head(hex)} {bolt(30,socket)}\\nM3×30",     # DIN912
    # "{head(hex)} {bolt(40,socket)}\\nM3×40",     # DIN912

    ## 0062E -- March 1, 2025
    # ## half width
    # "{nut} {nut_profile}\\nM2",
    # # "{washer} {box(0.5)}\\nM2.5",
    # # "{washer} {box(0.5)}\\nM3",
    # ## 1u wide
    # "{head(hex)} {bolt(20,socket)}\\nM2×20",
    # "{head(torx)} {bolt(20,countersunk)}\\nM2.5×20",
    # "{head(cross)} {bolt(5,wafer)}\\nM3×5",
    # "{head(cross)} {bolt(6,wafer)}\\nM3×6",
    # "{head(cross)} {bolt(8,wafer)}\\nM3×8",
    # "{head(torx)} {bolt(8,countersunk)}\\nM3×8",
    # "{head(torx)} {bolt(10,countersunk)}\\nM3×10",
    # "{head(cross)} {bolt(16,wafer)}\\nM3×16",
    # "{head(hex)} {bolt(16,socket)}\\nM3×20",
    # "{head(cross)} {bolt(25,pan)}\\nM3.5×25",
    # "{nut} {nut_profile}\\nM3.5",
    # "{head(cross)} {bolt(10,wafer)}\\nM4×10",
    # "{head(cross)} {bolt(25,wafer)}\\nM4×25",
    # ## 2u wide
    # # "{head(hex)} {bolt(30,socket)}\\nM3×30",     # DIN912
    # # "{head(hex)} {bolt(40,socket)}\\nM3×40",

    # ## 0062F -- March 2, 2025
    # "{nut} {nut_profile}\\nM2{|}{washer} {box(0.5)}\\nM2",
    # "{nut} {nut_profile}\\nM2.5{|}{washer} {box(0.5)}\\nM2.5",
    # "{nut} {nut_profile}\\nM3{|}{washer} {box(0.5)}\\nM3",

    # ## 0062G -- May 11, 2025
    # "{...}{nut} {nut_profile}{...}{...}{washer} {box(0.5)}{...}\\nM2",
    # "{...}{nut} {nut_profile}{...}{...}{washer} {box(0.5)}{...}\\nM2.5",
    # "{...}{nut} {nut_profile}{...}{...}{washer} {box(0.5)}{...}\\nM3",
    # "{square_nut}\\nM3",
    # "{...}{head(hex)} {bolt(4,countersunk)}{...}{...}{bolt(6,countersunk)}{...}\\n{...}M3×4{...}{...}×6{...}",
    # "{head(cross)} {bolt(5,wafer)}    {bolt(6,wafer)}\\n{...}M3×5{...}{...}×6{...}",
    # "{head(cross)} {bolt(12,wafer)}\\nM3×12",  # DIN912
    # "{head(hex)} {bolt(55,socket)}\\nM3×55",
    # "{washer} {box(0.8)}\\nM4",  # M4x9x0.8
    # "{nut} {nut_profile}\\nM4",  # DIN934
    # "{washer} {box(1.0)}\\nM5",  # M5x10x1
    # "{nut} {nut_profile}\\nM5",  # DIN934
    # "{head(hex)} {bolt(20,socket)}\\nM5×20",  # DIN912

    # ## 0062H -- Oct 25, 2025
    # "{head(hex)} {bolt(50, socket)}\\nM5×50",  # DIN912
    # "{hexhead} {bolt(20, standoff)}\\nM3×20+6",
    # "{hexhead} {bolt(6, standoff)}\\nM3×6+6",

    ## 0062I -- Oct 26, 2025
    "{head(hex)} {bolt(50, socket)}\\nM3×50",  # DIN912
    "{nut} {bolt(20, standoff, flipped)}\\nM3×20+6",
    "{nut} {bolt(6, standoff, flipped)}\\nM3×6+6",
    "William",
]

LABELS_2_WIDE = [
    ## 0062I -- Oct 26, 2025
    "{head(hex)} {bolt(30, socket)}\\n  M3×30{...}",  # DIN912
    "{head(hex)} {bolt(40, socket)}\\n  M3×40{...}",  # DIN912
    "{head(hex)} {bolt(50, socket)}\\n  M3×50{...}",  # DIN912
    "{head(hex)} {bolt(55, socket)}\\n  M3×55{...}",  # DIN912
]

# Manual here --> https://github.com/ndevenish/gflabel/


TEST_LABELS = [
    # bold heads
    "{bolt(10, pan)} pan",
    "{bolt(10, socket)} socket",
    "{bolt(10, round)} round",
    "{bolt(10, countersunk)} CS",
    "{bolt(10, pan,tapping)} tap",
    "{bolt(10, pan, flipped)} flip",
    "{bolt(10, pan, slot)} slot",
    "{bolt(10, pan, flanged)} flang",
    "{bolt(10, wafer)} wafer",
    "{bolt(10, standoff)} SO",

    # # drives
    "{head(cross)} "
    "{head(phillips)} "
    "{head(pozidrive)}",
    "{head(square)} "
    "{head(triangle)} "
    "{head(slot, square)}",
    "{head(hex)} "
    "{head(phillipsslot)} "
    "{head(slot)}",
    "{head(torx)} "
    "{head(slot, triangle)} "
    "{head(torx, security)}",

    # # fregments
    "{box(9)} "
    "{circle} "
    "{hexhead}",
    "{nut} "
    "{locknut_profile} "
    "{lockwasher}",
    "{magnet} "
    "{washer} "
    "{square_nut}",
]


FONT = "B612"
BASE = "webb"
# BASE = "pred"
# STYLE = "embedded"
STYLE = "embossed"
FONT_SIZE = 6
MARGIN = 0

# OUTPUT = "labels.step"
OUTPUT = "labels.stl"

# FILENAME_REPLACEMENTS = [
#     ["{nut}", "nut"],
#     ["{head(", ""],
#     ["{webbolt(", ""],
#     [")}", ""],
#     [",", "-"],
#     [" ", "-"],
# ]

@task
def make_labels(ctx, vscode=False, two=False, test=False):
    width = ""
    if test is True:
        all_labels = " ".join(f'"{label}"' for label in TEST_LABELS)
    elif two is True:
        all_labels = " ".join(f'"{label}"' for label in LABELS_2_WIDE)
        width = "--width 2"
    else:  # two is True
        all_labels = " ".join(f'"{label}"' for label in LABELS)

    cmd = f"gflabel {BASE} --font={FONT} --font-size={FONT_SIZE}"
    cmd += f" --style={STYLE} --margin={MARGIN} {width} {all_labels} -o {OUTPUT}"

    if vscode:
        cmd += " --vscode"

    ctx.run(cmd)
