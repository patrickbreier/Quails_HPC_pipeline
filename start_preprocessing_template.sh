#!/bin/bash

#SBATCH --partition=batch
#SBATCH --output=/projects/Quails/scripts/output/slurm-preprocessing-%A_%a.out
#SBATCH --error=/projects/Quails/scripts/errors/slurm-preprocessing-%A_%a.err
#SBATCH --job-name=preprocessing-%A_%a
#SBATCH --time=0-10:00:00
#SBATCH --mem-per-cpu=75000
#SBATCH --array=1-==number_of_tiles==

in_dir=${1}
out_dir=${2}
filename=${3}
rb_radius=${4}
block_size=${5}

eval "$(conda shell.bash hook)"
conda activate quail

/projects/Quails/scripts/pipeline/alter_pp_macro.py ${in_dir} ${out_dir} ${filename} ${rb_radius} ${block_size} $(printf "%02d" $SLURM_ARRAY_TASK_ID)

sleep 5s

/projects/Quails/sw/Fiji.app/ImageJ-linux64  \
    --headless \
    -batch /projects/Quails/scripts/pipeline/preprocessing_mod_$(printf "%02d" $SLURM_ARRAY_TASK_ID).ijm