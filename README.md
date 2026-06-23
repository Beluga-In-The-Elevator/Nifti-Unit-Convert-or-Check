This macro automates opening, inspecting, manually calibrating, and saving NIfTI images in ImageJ/Fiji using the Bio-Formats importer and the NIfTI-1 plugin.

What it does
Prompts the user to select a single NIfTI file (.nii or .nii.gz) via a file open dialog.

Opens the selected file with Bio-Formats Importer as a hyperstack (view=Hyperstack, stack_order=XYCZT).

Reads the Image Info, parses the “Voxel size” line, and prints the X, Y, and Z voxel sizes and units to the Log window.

Plots a Z-axis profile for a quick sanity check of slice spacing.

Shows a dialog asking whether the units look correct; if not, it prints step-by-step instructions for manually editing units and voxel sizes via Image ▸ Properties (Ctrl+Shift+P).

Pauses with waitForUser(...) so the user can make manual calibration edits.

Asks one final “Are the units correct?” question and then saves a new NIfTI file using the NIfTI-1 plugin, with a clean filename based on the original file’s path.

File naming and paths
The macro remembers the full input file path in a variable called currentPath.

The parent directory is extracted using:

javascript
parentDir = File.getDirectory(currentPath);
The base name (without .nii.gz and .nii) is extracted using:

javascript
baseName = File.getNameWithoutExtension(currentPath); // strips .gz
if (endsWith(baseName, ".nii"))
    baseName = substring(baseName, 0, lengthOf(baseName) - 4); // strips .nii
The output filename is constructed as:

javascript
newName  = "unitConverted_" + baseName + ".nii";
savePath = parentDir + newName;
so if the original file is X:/.../2a_38740/38740_grp1.nii.gz, the output will be X:/.../2a_38740/unitConverted_38740_grp1.nii.

NIfTI-1 plugin call (important)
To ensure the NIfTI-1 plugin uses the intended filename instead of the current window title (which may include Bio-Formats suffixes like -0-0), the macro calls:

javascript
run("NIfTI-1", "save=[" + savePath + "]");
The save=[path] argument is required; if you only pass the bare path string, the plugin will fall back to using the window title for the output name.

Usage notes
The macro assumes Bio-Formats and the NIfTI-1 plugin (nifti_io.jar) are installed and available in Fiji/ImageJ.

It is designed for interactive use: you select a file, inspect the voxel sizes, and manually correct units and spacing before saving the calibrated NIfTI.

The window title inside ImageJ may still show suffixes like -0-0 when opening files via Bio-Formats; this does not affect the actual filename written to disk.
