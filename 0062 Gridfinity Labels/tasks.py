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
    "{washer} {box(0.5)}\\nM2.5",  # M2.5x5.5x0.5
    "{washer} {box(0.5)}\\nM3",    # M3x6x0.5
    "{nut} {nut_profile}\\nM2.5",  # DIN934
    "{nut} {nut_profile}\\nM3",    # DIN934
    "{head(hex)} {bolt(6,countersunk)}\\nM3×6",  # DIN7991
    "{head(hex)} {bolt(30,socket)}\\nM3×30",     # DIN912
    "{head(hex)} {bolt(40,socket)}\\nM3×40",     # DIN912

]

# Manual here --> https://github.com/ndevenish/gflabel/

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
def make_labels(ctx, vscode=False):
    all_labels = " ".join(f'"{label}"' for label in LABELS)

    cmd = f"gflabel --base={BASE} --font={FONT} --font-size={FONT_SIZE}"
    cmd += f" --style={STYLE} --margin={MARGIN} {all_labels} -o {OUTPUT}"

    if vscode:
        cmd += " --vscode"

    ctx.run(cmd)
