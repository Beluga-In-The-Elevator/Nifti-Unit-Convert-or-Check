
// Read voxel size from the Info text (Ctrl+I) and log it, prompt to manually convert if neeeded

// Make sure an image is open
title = getTitle();

info = getInfo();         // full Image Info text
lines = split(info, "\n");

vx = vy = vz = "NA";
unit = "NA";

for (i = 0; i < lines.length; i++) {
    line = lines[i];
    if (startsWith(line, "Voxel size:")) {
        // Example line: "Voxel size: 0.2148x0.2273x0.1719 micron^3"

        // Remove "Voxel size: "
        parts = split(line, ":");
        voxelPart = trim(parts[1]);   // " 0.2148x0.2273x0.1719 micron^3"

        // Split off the unit
        // First split by space: ["0.2148x0.2273x0.1719", "micron^3"]
        voxelParts = split(voxelPart, " ");
        sizeString = voxelParts[0];   // "0.2148x0.2273x0.1719"
        unitString = voxelParts[1];   // "micron^3"

        // Split sizes by 'x'
        sizes = split(sizeString, "x");
        vx = sizes[0];
        vy = sizes[1];
        vz = sizes[2];

        // Unit without ^3
        unit = replace(unitString, "^3", "");
    }
}

print("File: " + getTitle());
print("  Voxel size X = " + vx + " " + unit);
print("  Voxel size Y = " + vy + " " + unit);
print("  Voxel size Z = " + vz + " " + unit);
print("-----");



// need to try to generalize this I guess. Otherwise just do this manually. 

//sanity check that z depth is correct in millimeters
selectImage(title);

run("Plot Z-axis Profile");

// Create a dialog with a Yes/No choice
Dialog.create(" Are the units correct?");
Dialog.addChoice("Look at your Z axis profile and the new Ctrl I output. Are the units correct?", newArray("Yes", "No"), "Yes");
Dialog.show();
// Read the user's choice
answer = Dialog.getChoice();

// Use the result
if (answer == "Yes") {
    print("User chose YES, stopping. Congratulations you are done with this step of the processing.");
} else {
    print("User chose NO, prompt to convert manually to mm.\n"+
    "--------");

    instructions =
        "INSTRUCTIONS .\n" + 
        "Press Ctrl+Shift+P.\n" +
        "Reference the Log output.\n" +
        "Convert X, Y, and Z units to the correct units (e.g. mm).\n" +
        "Then manually enter the corrected numerical values.\n" +
        "When you are done, open the Z-axis Profile, select LIVE .\n" + 
        " verify that the units are correct before moving on.";

    print(instructions);

    Dialog.create("Convert to mm");
    Dialog.addMessage(
        "Look at the Log and follow the instructions"
    );
    Dialog.show();
    selectWindow(title);
}


//sanity check that z depth is correct in millimeters
selectImage(title);
run("Plot Z-axis Profile");



// optional save prompt could go here in future

