# Nifti-Unit-Convert-or-Check
Verify or convert image properties for imageJ/FIJI nifti files that have been imported using the bioformats importer

README – Voxel Size Check & Unit Sanity Macro (ImageJ/Fiji)
What this macro does
For the currently open image, this macro:

Reads the “Voxel size:” line from the Image Info (same as pressing Ctrl+I).

Parses the X, Y, and Z voxel sizes and their units (e.g., micron^3).

Prints those values to the Log window so you can see the numeric voxel sizes clearly.

Plots a Z‑axis profile to help you visually sanity‑check slice thickness vs. physical depth.

Shows a Yes/No dialog asking if the units now look correct based on:

The Log output, and

The Ctrl+I Info panel and Z‑axis profile.

If you answer:

Yes: the macro stops and tells you this step is complete.

No: it displays a guidance dialog reminding you to:

Press Ctrl+Shift+P;  Use the Log values to convert X, Y, Z units (e.g., microns → mm).; Manually update the voxel sizes and units in Image ▸ Properties….

The macro does not automatically change units or voxel sizes; it is a helper to expose the metadata and guide you through manual correction when needed.




How to run it
Open the NIfTI image you want to check (e.g., map_T1_VAFI.nii or T1w-stack.nii.gz).

Make sure that:

Ctrl+I (Image Info) shows a line titled Voxel size (e.g. Voxel size: 0.2148x0.2273x0.1719 micron^3.) 

Run the macro:

Plugins ▸ Macros ▸ Run… or from the Script Editor.

Watch the Log window:

It will print:

The file name.

Voxel size X, Voxel size Y, Voxel size Z, and the unit.

The macro will:

Plot a Z‑axis profile to help you confirm slice depth vs. physical units.

Show a Yes/No dialog:

“Look at your Z axis profile and the new Ctrl I output. Are the units correct?”

Respond to the dialog:

If you select Yes:

The macro prints a confirmation message and stops.

If you select No:

A “Convert to mm” dialog appears with instructions:

Press Ctrl+Shift+P (Macro Recorder).

Reference the Log output.

Convert X, Y, Z units to the correct units (e.g., mm).

Manually enter the corrected voxel sizes and unit in Image ▸ Properties….

When to use this macro
Use it when you:

Suspect that voxel sizes are in the wrong units (e.g., microns vs. millimeters).

Need to verify slice thickness and voxel spacing before registration and overlay.

Want a structured prompt that reminds you:

Where to look (Log, Info, Z‑profile).

What to correct (X/Y/Z voxel sizes, unit in Image ▸ Properties…).

It’s meant as a sanity‑check and manual calibration helper, not as a fully automated calibration tool.
