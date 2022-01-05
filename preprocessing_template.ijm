// arguments get parsed by the script alter_pp_macro.py
open("in_dir/in_file" + "image_number" + "_N2V.tif");
run("16-bit");

run("Subtract Background...", "rolling=rb_radius stack");
run("Z Project...", "projection=[Max Intensity]");
run( "Enhance Local Contrast (CLAHE)", "blocksize=block_size histogram=256 maximum=slope mask=*None* fast_(less_accurate)");


saveAs("Tiff", "out_dir" + "max_pp_" + "in_file" + "image_number.tif");
