from invoke import task

LABELS = [
    "William",
    "{nut} M2.5",
    "{nut} M3",
    "{head(hex)} {bolt(4,countersunk)} M3×4",
    "{webbolt(countersunk,hex,flip)} M3×4",
    "{magnet} 6x2",
    "{head(square)} {bolt(20,button)} M5×20",
]

# Manual here --> https://github.com/ndevenish/gflabel/

FONT = "B612"
# BASE = "webb"
BASE = "pred"
# STYLE = "embedded"
STYLE = "embossed"
FONT_SIZE = 6

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
    cmd += f" --style={STYLE} {all_labels} -o {OUTPUT}"

    if vscode:
        cmd += " --vscode"

    ctx.run(cmd)
