//master 
macro "mmCalibrate_Master" {

    // ---------- STEP 1: choose and open via Bio-Formats ----------
    filePath = File.openDialog("Choose a NIfTI (.nii or .nii.gz) file");
//    if (filePath == null) {
//        print("User cancelled file selection.");
//        return;
//    }

    currentPath = filePath;
    print("Opening via Bio-Formats: " + currentPath);

    run("Bio-Formats Importer",
        "open=[" + currentPath + "] " +
        "view=Hyperstack stack_order=XYCZT");

    // ---------- STEP 2: voxel parsing + Z-profile + unit dialog ----------
    title = getTitle();
    print(title);
    info = getInfo();
    lines = split(info, "\n");

    vx = vy = vz = "NA";
    unit = "NA";

    for (i = 0; i < lines.length; i++) {
        line = lines[i];
        if (startsWith(line, "Voxel size:")) {
            parts = split(line, ":");
            voxelPart = trim(parts[1]);
            voxelParts = split(voxelPart, " ");
            sizeString = voxelParts[0];
            unitString = voxelParts[1];

            sizes = split(sizeString, "x");
            vx = sizes[0];
            vy = sizes[1];
            vz = sizes[2];

            unit = replace(unitString, "^3", "");
        }
    }

    print("File: " + getTitle());
    print("  Voxel size X = " + vx + " " + unit);
    print("  Voxel size Y = " + vy + " " + unit);
    print("  Voxel size Z = " + vz + " " + unit);
    print("-----");

    selectImage(title);
    run("Plot Z-axis Profile");

    Dialog.create("Are the units correct?");
    Dialog.addChoice("Look at your Z axis profile and the new Ctrl+I output. Are the units correct?",
                     newArray("Yes", "No"), "No");
    Dialog.show();
    answer = Dialog.getChoice();

    if (answer == "Yes") {
        print("User chose YES, stopping. Congratulations you are done with this step of the processing.");
    } else {
        print("User chose NO, prompt to convert manually to mm.\n--------");

        instructions =
            "INSTRUCTIONS.\n" +
            "1. Press Ctrl+Shift+P.\n" +
            "2. Reference the Log output.\n" +
            "3. Convert X, Y, and Z units to the correct units (e.g. mm).\n" +
            "4. Manually enter the corrected numerical values from above in the log.\n" +
            "5. When you are done, plot the Z axis profile again.\n" +
            "6. Verify that the units in header and in Z axis are correct before moving on.";

        print(instructions);

        Dialog.create("Convert to mm");
        Dialog.addMessage("Look at the Log and follow the instructions");
        Dialog.show();
        selectWindow(title);
        selectWindow("Log");
    }

    // Give you a pause to fix Properties before saving
    waitForUser("Make your manual unit edits in Image ▸ Properties now, then click OK to continue.");

    // ---------- STEP 3: save using currentPath ----------
    print("--------Running Part 3 (saveWork)--------");

    Dialog.create("Are the units correct?");
    Dialog.addChoice("Look at your Z axis profile and the new Ctrl+I output. Are the units correct?",
                     newArray("Yes", "No"), "Yes");
    Dialog.show();
    answer2 = Dialog.getChoice();

    // Derive folder and base name from currentPath
    parentDir = File.getDirectory(currentPath);
    print(parentDir);

    baseName = File.getNameWithoutExtension(currentPath);
    print("initial base name= "+baseName);
    // If baseName still ends with ".nii", strip that too
if (endsWith(baseName, ".nii")){
    baseName = substring(baseName, 0, lengthOf(baseName) - 4);
    print("final base name= "+baseName);
}

    newName = "unitConverted_" + baseName + ".nii";
    print(newName);

    savePath = parentDir + newName;
    print(savePath);

    run("NIfTI-1", "save=[" + savePath+"]");

   
string="Saved re-calibrated NIfTI as: " + savePath;
 print(string);
 Dialog.addMessage(string);
Dialog.show();
}
