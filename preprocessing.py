#!/usr/bin/env python3

"""
for some reason this script is sbroken and gives black output
TODO
    - fix the script
    - figure out if 3D bg subtraction should be used or if a loop over each XY plane is better
    - how to start this file
    - how to parse args
"""

import numpy as np
import cv2 as cv
from skimage import (restoration, io)
from aicsimageio.writers import OmeTiffWriter
import sys

filepath = sys.argv[1]
filename = sys.argv[2]
image_number = sys.argv[3]
#kernel = sys.argv[4]
#clahe = sys.argv[5]

# read image and create empty image with same dimensions
# maybe figure out a way to transfer metadata
img = io.imread(f"{filepath}{filename}{image_number}.tif")
# new_image = np.zeros(shape=(img.shape))

# create kernel for rolling ball. unsure whether to use it like this or in loop over 2d slices
kernel = restoration.ellipsoid_kernel(
        (1, 1, 10, 10),                  # shape, figure out the best radius
        0.1                              # intensity
    )

# create a CLAHE object (Arguments are optional).
# clahe = cv.createCLAHE(clipLimit=2.0, tileGridSize=(8,8))

# apply roling ball algorithm
background_subtracted = restoration.rolling_ball(img, kernel=kernel)

# apply CLAHE
# for image_t in range(new_image.shape[0]):
#     for image_z in range(new_image.shape[1]):    # loop over every 2d image of timepoint 0
#         input_image = background_subtracted[image_t, image_z, ...]
#         clahe_2d = clahe.apply(input_image)
#         new_image[image_t, image_z, ...] = clahe_2d  # writing image 2d plane by 2d plane

# use tiffwriter to get proper hyperstack
OmeTiffWriter.save(background_subtracted, f"{filepath}../preprocessed/pp_tile_{image_number}.tif", dim_order="TZYX")
