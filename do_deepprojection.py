#!/usr/bin/env python3

import deepprojection as dp
import sys
import re
import os

# has to be tested!
path_weights = sys.argv[1]
input_dir = sys.argv[2]  # make bash script create the folder to put the projections in
save_dir = sys.argv[3]  # this variable has a meaning in the package not only for "transfer"
file_number = sys.argv[4]
# file_name = sys.argv[5]

# use regex for file input
regex = re.compile(f".+({file_number})")  # finds all files that end on the input number
for root, dirs, files in os.walk(input_dir):
    for file in files:
        if regex.match(file):
            try:
                file_name = f"{file}".replace("_N2V.tif", "_")  # needed because no preprocessing
            except:
                print("no N2V ending")
                file_name = f"{file}_"
                print("filename: ", file_name)

# movie method. make this work!
temp_folder = "/projects/Quails/deepprojection/temp/"
folder = f"{input_dir}{file_name}{file_number}.tif"
output = f"{save_dir}/proj_{file_name}{file_number}.tif"

predict = dp.PredictMovie(folder, model=dp.ProjNet, weights=path_weights, resize_dim=(512, 512),
                          clip_thrs=(0, 99.9), n_filter=8, mask_thrs=None, temp_folder=temp_folder,
                          normalization_mode='movie', export_masks=True, invert_slices=False,
                          filename_output=output)
