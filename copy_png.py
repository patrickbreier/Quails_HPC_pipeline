#!/usr/bin/env python3

"""
copies .tif to .png
"""

import sys
from skimage import io

# get arguments
filepath = sys.argv[1]  # should be ../stitched/timeseries/
filename = sys.argv[2]  # should be Fused_
image_number = sys.argv[3]  # should be timepoint



# import tif image and save as png in different folder
img = io.imread(f"{filepath}{filename}{image_number}.tif")
io.imsave(f"{filepath}{filename}{image_number}/original.png", img)
