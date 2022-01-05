// arguments get parsed by the script alter_pp_macro.py
open("in_dir/in_file" + "image_number" + "_N2V.tif");
run("16-bit");

// run("Subtract Background...", "rolling=rb_radius stack");
saveAs("Tiff", "out_dir" + "pp_" + "in_file" + "image_number.tif");
