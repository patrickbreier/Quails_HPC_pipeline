#!/usr/bin/env python3

import deepprojection as dp
import sys

# has to be tested!
path_weights = sys.argv[1]
input_dir = sys.argv[2]  # make bash script create the folder to put the projections in
save_dir = sys.argv[3]  # this variable has a meaning in the package not only for "transfer"
file_number = sys.argv[4]
file_name = sys.argv[5]

# movie method. make this work!
temp_folder = "/projects/Quails/deepprojection/temp/"
folder = f"{input_dir}{file_name}{file_number}.tif"
output = f"{save_dir}/proj_{file_name}{file_number}.tif"

predict = dp.PredictMovie(folder, model=dp.ProjNet, weights=path_weights, resize_dim=(512, 512),
                          clip_thrs=(0, 99.9), n_filter=8, mask_thrs=None, temp_folder=temp_folder,
                          normalization_mode='movie', export_masks=True, invert_slices=False,
                          filename_output=output)
