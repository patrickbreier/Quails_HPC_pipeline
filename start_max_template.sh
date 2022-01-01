#!/bin/bash

# Check what options you need here!
#SBATCH --job-name="projection"
#SBATCH --time=0-04:00:00
#SBATCH --mem-per-cpu=60000
#SBATCH --mail-user=pbreier@mpi-cbg.de
#SBATCH --mail-type=None
#SBATCH --output=/projects/Quails/scripts/output/slurm-projection_%j.out
#SBATCH --error=/projects/Quails/scripts/errors/slurm-projection_%j.err
#SBATCH --array=1-==number_of_tiles==  # how can I make this parameter be set by another script?


#this could be written in down in the line where it is actually called, but so it's more readable
input_dir=${1}
output_dir=${2} ####HOW CAN THIS BE USED?
filename=${3}

# set environment and load modules
eval "$(conda shell.bash hook)"
conda activate quail

# start projection
/projects/Quails/scripts/pipeline/max_proj.py "${input_dir}" "${output_dir}" $(printf "%02d" "$SLURM_ARRAY_TASK_ID") "${filename}"
