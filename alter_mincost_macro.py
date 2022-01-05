#!/usr/bin/env python3

import sys

in_dir = sys.argv[1]
in_name = sys.argv[3]
out_dir = sys.argv[2]
rb_radius = sys.argv[4]
cl_slope = sys.argv[5]
rescale_xy = sys.argv[6]
delta_z = sys.argv[7]
time = sys.argv[8]

with open('/projects/Quails/scripts/pipeline/mincost_proj_template.ijm', 'r') as file:
    data = file.read().replace('input_dir', in_dir).replace('input_image', in_name).replace('rb_radius', rb_radius).replace('out_dir', out_dir).replace('cl_slope', cl_slope).replace('res_xy', rescale_xy).replace('dz', delta_z)

with open(f'/projects/Quails/scripts/pipeline/mincost_proj_mod_{time}.ijm', 'w') as file:  # what to do with the numbers?
    file.write(data)
