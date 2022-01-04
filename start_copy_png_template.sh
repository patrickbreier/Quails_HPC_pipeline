#!/bin/bash

#SBATCH --partition=batch
#SBATCH --output=/projects/Quails/scripts/output/slurm-copy_png-%A_%a.out
#SBATCH --error=/projects/Quails/scripts/errors/slurm-copy_png-%A_%a.err
#SBATCH --job-name=copy_png-%A_%a
#SBATCH --time=0-02:00:00
#SBATCH --mem-per-cpu=60000
#SBATCH --array=0-==number_of_timesteps=  # will be modified by update_templates.py

# get filepath, filename, number of files from console input
filepath="$1"
filename="$2"

eval "$(conda shell.bash hook)"
conda activate quail

/projects/Quails/scripts/pipeline/copy_to_png.py ${filepath} ${filename} $(printf "%03d" $SLURM_ARRAY_TASK_ID)