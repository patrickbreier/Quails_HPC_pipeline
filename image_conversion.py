#!/usr/bin/env python3

"""
TODO
    - make this be able to run for large enough files
    --> lazy loading
"""

import sys
from aicsimageio import AICSImage

# get arguments
filepath = sys.argv[1]
filename = sys.argv[2]
image_number = sys.argv[3]

# import vsi image and save as tiff in different folder
AICSImage(f"{filepath}{filename}{image_number}.vsi").save(f"{filepath}/../raw/tile_{image_number}.tif")