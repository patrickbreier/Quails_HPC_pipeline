// include smoothing step
open("input_dir" + "input_image.tif");
run("Subtract Background...", "rolling=15 stack");
run("Duplicate...", "duplicate");
run("Invert", "stack");
run("Min cost Z Surface", "input=input_image.tif cost=input_image.tif rescale_x,y=res_xy rescale_z=1 max_delta_z=dz display_volume(s) volume=1 max_distance=15 min_distance=3");
run("Enhance Local Contrast (CLAHE)", "blocksize=49 histogram=256 maximum=cl_slope mask=*None*");
saveAs("Tiff", "out_dir" + "mincost_pp_" + "input_image.tif");
close();
saveAs("Tiff", "out_dir" + "mincost_map_" + "input_image.tif");
close();