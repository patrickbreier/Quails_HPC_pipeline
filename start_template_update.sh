#!/bin/bash

#SBATCH --partition=batch
#SBATCH --output=/projects/Quails/scripts/output/slurm-template_update-%j.out
#SBATCH --error=/projects/Quails/scripts/errors/slurm-template_update-%j.err
#SBATCH --job-name=template_update-%j
#SBATCH --time=0-00:01:00
#SBATCH --mem-per-cpu=100

number_of_tiles=${1}
timesteps=${2}
script_dir=${3}

eval "$(conda shell.bash hook)"
conda activate quail

/projects/Quails/scripts/pipeline/update_templates.py ${number_of_tiles} ${timesteps} ${script_dir}