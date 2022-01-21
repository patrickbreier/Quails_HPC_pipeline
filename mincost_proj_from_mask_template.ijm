// open file and mask
open("/Volumes/Quails-1/deepproj/single_z/orig_data_02-1.tif");
open("/Volumes/Quails-1/deepproj/single_z/projection2/proj_orig_data_02-1.tif_masks.tif");
// binarize the mask
run("Make Binary", "method=Default background=Dark calculate")
imageCalculator("Multiply create 32-bit stack", "orig_data_02-1.tif","proj_orig_data_02-1.tif_masks.tif");
//selectWindow("Result of orig_data_02-1.tif");
run("Duplicate...", "duplicate");
run("Invert", "stack");
run("Min cost Z Surface", "input=[Result of orig_data_02-1.tif] cost=[Result of orig_data_02-1-1.tif] rescale_x,y=0.25 rescale_z=1 max_delta_z=1 display_volume(s) volume=1 max_distance=15 min_distance=3");
run("16-bit");
saveAs("Tiff", "/Users/pbreier/Desktop/projection.tif");
close();
run("16-bit");
saveAs("Tiff", "/Users/pbreier/Desktop/altitude_map.tif");
run("Close All");
