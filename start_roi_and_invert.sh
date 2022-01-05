#!/bin/bash

#SBATCH --partition=batch
#SBATCH --output=/projects/Quails/scripts/output/slurm-roi_invert-%j.out
#SBATCH --error=/projects/Quails/scripts/errors/slurm-roi_invert-%j.err
#SBATCH --job-name=roi_invert-%j
#SBATCH --time=0-0:10:00
#SBATCH --mem-per-cpu=2000

in_dir=${1}
in_name=${2}
roi_file=${3}

eval "$(conda shell.bash hook)"
conda activate quail

/projects/Quails/scripts/pipeline/alter_roi_macro.py ${in_dir} ${in_name} ${roi_file}

sleep 10s

/projects/Quails/sw/Fiji.app/ImageJ-linux64  \
    --headless \
    -batch /projects/Quails/scripts/pipeline/roi_and_invert_mod.ijm