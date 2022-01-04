# -*- coding: utf-8 -*-
"""
EPySeg alternative for non GUI segmentation
TODO
  - what are the ideal parameters?
"""

from epyseg.deeplearning.deepl import EZDeepLearning
import os
import sys
import re

# get arguments from bash script
input_path = sys.argv[1]
TA_mode = sys.argv[2]
cut_cells = sys.argv[3]
image_number = sys.argv[4]  # WORKS ONLY IF EVERY IMAGE IN SINGLE FOLDER!

if __name__ == '__main__':
    # predict parameters
    IS_TA_OUTPUT_MODE = TA_mode  # stores as handCorrection.tif in the folder with the same name as the parent file without ext
    input_channel_of_interest = None  # assumes image is single channel or multichannel nut channel of interest is ch0, needs be changed otherwise, e.g. 1 for channel 1
    TILE_WIDTH = 256  # 128 # 64
    TILE_HEIGHT = 256  # 128 # 64
    TILE_OVERLAP = 32

    # input as regex
    regex = re.compile(f".+({image_number})")  # finds all directories that end on the input number
    for root, dirs, files in os.walk(input_path):
        for directory in dirs:
            if regex.match(directory):
                INPUT_FOLDER = f"{input_path}{directory}"

    try:
        INPUT_FOLDER
    except FileNotFoundError:
        print("Could not find input file")
        exit(1)
    else:
        print(f"found file {INPUT_FOLDER}")

    EPYSEG_PRETRAINING = 'Linknet-vgg16-sigmoid-v2'  # or 'Linknet-vgg16-sigmoid' for v1
    SIZE_FILTER = cut_cells  # None #100 # set to 100 to get rid of cells having pixel area < 100 pixels

    # raw code for predict
    deepTA = EZDeepLearning()
    deepTA.load_or_build(architecture='Linknet', backbone='vgg16', activation='sigmoid', classes=7, pretraining=EPYSEG_PRETRAINING)

    deepTA.get_loaded_model_params()
    deepTA.summary()

    input_shape = deepTA.get_inputs_shape()
    output_shape = deepTA.get_outputs_shape()

    input_normalization = {'method': 'Rescaling (min-max normalization)', 'range': [0, 1], 'individual_channels': True}

    predict_parameters = {"input_channel_of_interest": input_channel_of_interest,
                          "default_input_tile_width": TILE_WIDTH, "default_input_tile_height": TILE_HEIGHT,
                          "default_output_tile_width": TILE_WIDTH, "default_output_tile_height": TILE_HEIGHT,
                          "tile_width_overlap": TILE_OVERLAP, "tile_height_overlap": TILE_OVERLAP,
                          "hq_pred_options": "Use all augs (pixel preserving + deteriorating) (Recommended for segmentation)",
                          "post_process_algorithm": "default (slow/robust) (epyseg pre-trained model only!)",
                          "input_normalization": input_normalization, "filter": SIZE_FILTER}

    predict_generator = deepTA.get_predict_generator(
        inputs=[INPUT_FOLDER], input_shape=input_shape,
        output_shape=output_shape,
        clip_by_frequency=None, **predict_parameters)

    if not IS_TA_OUTPUT_MODE:
        predict_output_folder = os.path.join(INPUT_FOLDER, 'predict')
    else:
        predict_output_folder = 'TA_mode'

    deepTA.predict(predict_generator, output_shape, predict_output_folder=predict_output_folder, batch_size=1, **predict_parameters)
