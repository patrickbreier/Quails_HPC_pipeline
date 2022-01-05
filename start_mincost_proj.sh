#!/bin/bash

#SBATCH --partition=batch
#SBATCH --output=/projects/Quails/scripts/output/slurm-mincost-%A_%a.out
#SBATCH --error=/projects/Quails/scripts/errors/slurm-mincost-%A_%a.err
#SBATCH --job-name=mincost-%A_%a
#SBATCH --time=0-10:00:00
#SBATCH --mem-per-cpu=75000
#SBATCH --array=1-==timesteps== # not sure how to process this array

in_dir=${1}
in_name=${2}
out_dir=${3}
rb_radius=${4}
cl_slope=${5}
rescale_xy=${6}
delta_z=${7}

eval "$(conda shell.bash hook)"
conda activate quail

/projects/Quails/scripts/pipeline/alter_mincost_macro.py ${in_dir} ${in_name} ${out_dir} ${rb_radius} ${cl_slope} ${rescale_xy} ${delta_z}  $(printf "%03d" $SLURM_ARRAY_TASK_ID)

sleep 5s

/projects/Quails/sw/Fiji.app/ImageJ-linux64  \
    --headless \
    -batch /projects/Quails/scripts/pipeline/mincost_proj_mod_$(printf "%03d" $SLURM_ARRAY_TASK_ID).ijm # what to do woht the numbers?