#!/bin/bash

#SBATCH --partition=batch
#SBATCH --output=/projects/Quails/scripts/output/slurm-fileconversion-%A_%a.out
#SBATCH --error=/projects/Quails/scripts/errors/slurm-fileconversion-%A_%a.err
#SBATCH --job-name=fileconversion-%A_%a
#SBATCH --time=0-02:00:00
#SBATCH --mem-per-cpu=6000
#SBATCH --array=1-==number_of_tiles==  # will be modified by update_templates.py

# get filepath, filename, number of files from console input
filepath="$1"
filename="$2"

eval "$(conda shell.bash hook)"
conda activate quail

/projects/Quails/scripts/pipeline/image_conversion.py ${filepath} ${filename} $(printf "%02d" $SLURM_ARRAY_TASK_ID)