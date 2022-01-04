#!/usr/bin/env python3

import sys
import numpy as np
from skimage import io
from aicsimageio.writers import OmeTiffWriter
import re
import os

# get arguments from bash script
input_dir = sys.argv[1]
save_dir = sys.argv[2]
file_number = sys.argv[3]


# use regex for file input
regex = re.compile(f".+({file_number})")  # finds all files that end on the input number
for root, dirs, files in os.walk(input_dir):
    for file in files:
        if regex.match(file):
            img_name = f"{input_dir}{file}"  # will this stay in the loop or can I use it?
            file_name = f"{file}"

img = io.imread(img_name)
img_max = np.max(img, axis=-3)

# use tiff writer to get proper hyperstack
if len(img_max.shape) == 3:
    OmeTiffWriter.save(img_max, f"{save_dir}max_{file_name}", dim_order="TYX")
elif len(img_max.shape) == 2:
    OmeTiffWriter.save(img_max, f"{save_dir}max_{file_name}", dim_order="YX")
else:
    print("image dimensions are not as expected")
    exit(1)
