#!/bin/bash

# Check what options you need here!
#SBATCH --job-name="EPySeg prediction"
#SBATCH --time=0-00:30:00
#SBATCH --mem-per-cpu=1000
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu
#SBATCH --mail-user=pbreier@mpi-cbg.de
#SBATCH --mail-type=None
#SBATCH --output=/projects/Quails/scripts/output/slurm-segmentation_%A_%a.out
#SBATCH --error=/projects/Quails/scripts/errors/slurm-segmentation_%A_%a.err
#SBATCH --array=1-==timesteps==

# get arguments from master-script
input_dir=${1}
TA_mode=${2}
cut_cells=${3}


# set environment and load modules
eval "$(conda shell.bash hook)"
conda activate epyseg
module load cuda/11.2.2

# move every file in separate folder
cd "${input_dir}" || exit
for x in ./*.tif; do
  mkdir "${x%.*}" && mv "$x" "${x%.*}"
done

# job submission; set input path behind the script call
python /projects/Quails/scripts/pipeline/epyseg_nogui.py "${input_dir}" "${TA_mode}" "${cut_cells}" $(printf "%02d" "$SLURM_ARRAY_TASK_ID")  # change back to 3 digits!