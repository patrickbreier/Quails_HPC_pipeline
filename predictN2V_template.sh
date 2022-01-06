#!/bin/bash


# Check what options you need here!
#SBATCH --job-name N2V_predict
#SBATCH --time 1-00:00:00
#SBATCH --mem-per-cpu 6000
#SBATCH --gres=gpu:1
#SBATCH --partition gpu
#SBATCH --mail-user pbreier@mpi-cbg.de
#SBATCH --mail-type NONE
#SBATCH --output /projects/Quails/scripts/output/slurm-N2V_predict_%A_%a.out
#SBATCH --error /projects/Quails/scripts/errors/slurm-N2V_predict_%A_%a.err
#SBATCH --exclude=r02n01
#SBATCH --array=1-==number_of_tiles==    # set by update_templates.py


# Change these parameters and uncomment the next three lines before usage!
path_to_folder=${1}
path_to_model=${2}

data=raw
outdir=clean

eval "$(conda shell.bash hook)"
conda activate myN2V
module load cuda/11.2.2  # use most up-to-date cuda

# line is needed due to some stupid error I got
export HDF5_USE_FILE_LOCKING='FALSE'

# Dimensions correct?
# do the arrays work?
if [ ${path_to_model} == None ]
then
  /projects/Quails/scripts/pipeline/predictN2V.py --baseDir=${path_to_folder}/../model/ --dataPath=${path_to_folder}/../${data}/ --fileName='tile_'$(printf "%02d" $SLURM_ARRAY_TASK_ID)'.tif' --output=${path_to_folder}/../${outdir}/ --dims=ZYX --tile=4
else
  /projects/Quails/scripts/pipeline/predictN2V.py --baseDir=${path_to_model}/ --dataPath=${path_to_folder}/../${data}/ --fileName='tile_'$(printf "%02d" $SLURM_ARRAY_TASK_ID)'.tif' --output=${path_to_folder}/../${outdir}/ --dims=ZYX --tile=4
fi