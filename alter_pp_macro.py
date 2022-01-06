#!/usr/bin/env python3

import sys

in_dir = sys.argv[1]
out_dir = sys.argv[2]
in_name = sys.argv[3]
rb_radius = sys.argv[4]
block_size = sys.argv[5]
image_number = sys.argv[6]
slope = sys.argv[7]

with open('/projects/Quails/scripts/pipeline/preprocessing_template.ijm', 'r') as file:
    data = file.read().replace('image_number', image_number).replace('in_dir', in_dir).replace('input_directory', in_dir).replace('rb_radius', rb_radius).replace('out_dir', out_dir).replace('in_file', in_name).replace('block_size', block_size).replace('slope', slope)

with open(f'/projects/Quails/scripts/pipeline/preprocessing_mod_{image_number}.ijm', 'w') as file:
    file.write(data)
