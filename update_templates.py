#!/usr/bin/env python3

import sys
import os

number_of_tiles = sys.argv[1]
timesteps = sys.argv[2]
script_dir = sys.argv[3]

for filename in os.listdir(script_dir):
    if filename.endswith("template.sh"):
        # print(filename)
        # print(filename.removesuffix('_template.sh'))
        with open(f'{script_dir}{filename}', 'r') as file:
            data = file.read().replace('==number_of_tiles==', number_of_tiles).replace('==timesteps==', timesteps)
        with open(f"{script_dir}{filename.removesuffix('_template.sh')}_mod.sh", 'w') as file:
            file.write(data)
