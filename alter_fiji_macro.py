#!/usr/bin/env python3

import sys

in_dir = sys.argv[1]
out_dir = sys.argv[2]
name_pattern = sys.argv[3]
tiles_x = sys.argv[4]
tiles_y = sys.argv[5]

with open('/projects/Quails/scripts/pipeline/stitching_display_template.ijm', 'r') as file:
    data = file.read().replace('tiles_x', tiles_x).replace('tiles_y', tiles_y).replace('input_directory', in_dir).replace('name_pattern', name_pattern).replace('output_directory', out_dir)

with open('/projects/Quails/scripts/pipeline/stitching_display_mod.ijm', 'w') as file:
    file.write(data)
