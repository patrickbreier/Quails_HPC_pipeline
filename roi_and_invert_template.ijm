open("in_dir"+"in_file");
open("roi_file");
run("Crop");
run("Invert");
setOption("BlackBackground", false);
run("Dilate");
saveAs("Tiff", "in_dir/handCorrection_small.tif");
