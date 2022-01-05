// arguments get parsed by the script alter_pp_macro.py
open("in_dir/in_file" + "image_number" + ".tif");
run("16-bit");


getDimensions( width, height, channels, slices, frames );
for ( f=1; f<=frames; f++ ) {
  Stack.setFrame( f );
  for ( s=1; s<=slices; s++ ) {
    Stack.setSlice( s );
    run( "Enhance Local Contrast (CLAHE)", "blocksize=block_size histogram=256 maximum=3 mask=*None* fast_(less_accurate)");
  }
}

run("Subtract Background...", "rolling=rb_radius stack");
saveAs("Tiff", "out_dir" + "pp_" + "in_file" + "image_number.tif");
