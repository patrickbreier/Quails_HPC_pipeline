#!/usr/bin/env python3

import sys
import numpy as np
from skimage import io
from aicsimageio.writers import OmeTiffWriter

# get arguments from bash script
input_dir = sys.argv[1]
save_dir = sys.argv[2]
file_number = sys.argv[3]
file_name = sys.argv[4]

img_name = f"{input_dir}{file_name}{file_number}.tif"
img = io.imread(img_name)
img_max = np.max(img, axis=-3)  # figure out if that really does what i want! does it work with timelapse? use negative index to make it work for 3D data as well


# use tiff writer to get proper hyperstack
if len(img_max.shape) == 3:
    OmeTiffWriter.save(img_max, f"{save_dir}max_{file_name}{file_number}.tif", dim_order="TYX")
elif len(img_max.shape) == 2:
    OmeTiffWriter.save(img_max, f"{save_dir}max_{file_name}{file_number}.tif", dim_order="YX")
else:
    print("image dimensions are not as expected")
    exit(1)
