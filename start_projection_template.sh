#!/bin/bash

#update this script!

# Check what options you need here!
#SBATCH --job-name="projection"
#SBATCH --time=0-01:00:00
#SBATCH --mem-per-cpu=6000
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu
#SBATCH --mail-user=pbreier@mpi-cbg.de
#SBATCH --mail-type=None
#SBATCH --output=/projects/Quails/scripts/output/slurm-projection_%A_%a.out
#SBATCH --error=/projects/Quails/scripts/errors/slurm-projection_%A_%a.err
#SBATCH --array=1-==number_of_tiles==


#this could be written in down in the line where it is actually called, but so it's more readable
path_to_model=${1}
input_dir=${2}
output_dir=${3}
#filename=${4}


# set environment and load modules
eval "$(conda shell.bash hook)"
conda activate dpj
module load cuda/11.2.2
# start projection
/projects/Quails/scripts/pipeline/do_deepprojection.py ${path_to_model} ${input_dir} ${output_dir} $(printf "%02d" $SLURM_ARRAY_TASK_ID)  # ${filename}
