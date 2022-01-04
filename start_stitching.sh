#!/bin/bash

#SBATCH --partition=batch
#SBATCH --output=/projects/Quails/scripts/output/slurm-stitching_%j.out
#SBATCH --error=/projects/Quails/scripts/errors/slurm-stitching_%j.err
#SBATCH --job-name=stitching
#SBATCH --time=0-01:00:00
#SBATCH --mem-per-cpu=20000

input_dir=${1}
output_dir=${2}
name_pattern=${3}
tiles_x=${4}
tiles_y=${5}

# parsing arguments to Fiji script via python script
/projects/Quails/scripts/pipeline/alter_fiji_macro.py ${input_dir} ${output_dir} ${name_pattern} ${tiles_x} ${tiles_y}

# starting altered Fiji script
/projects/Quails/sw/Fiji.app/ImageJ-linux64  \
    --headless \
    -batch /projects/Quails/scripts/pipeline/stitching_display_mod.ijm

# set environment and load modules
eval "$(conda shell.bash hook)"
conda activate epyseg

# save as timeseries
/projects/Quails/scripts/pipeline/save_as_timeseries.py ${output_dir} "Fused"

sleep 20s

# move every file in separate folder
# somehow this failed
cd "${output_dir}/timeseries/" || exit
for x in ./*.tif; do
  mkdir "${x%.*}" && mv "$x" "${x%.*}"
done
