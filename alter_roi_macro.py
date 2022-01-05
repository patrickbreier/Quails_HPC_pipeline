#!/usr/bin/env python3

import sys

in_dir = sys.argv[1]
in_name = sys.argv[2]
roi_file = sys.argv[3]

with open('/projects/Quails/scripts/pipeline/roi_and_invert_template.ijm', 'r') as file:
    data = file.read().replace('in_dir', in_dir).replace('in_file', in_name).replace('roi_file', roi_file)

with open(f'/projects/Quails/scripts/pipeline/roi_and_invert_mod.ijm', 'w') as file:
    file.write(data)
