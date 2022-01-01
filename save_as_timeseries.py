#!/usr/bin/env python3

import sys
import tifffile

in_dir = sys.argv[1]
filename = sys.argv[2]

image = tifffile.imread(f"{in_dir}{filename}.tif")

for image_t in range(image.shape[0]):
    tifffile.imwrite(f"{in_dir}/timeseries/{filename}{image_t+1:03}.tif", image[image_t, :, :])
