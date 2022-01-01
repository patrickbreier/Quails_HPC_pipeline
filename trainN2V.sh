#!/bin/bash

# Check what options you need here!
#SBATCH --job-name N2V_training 
#SBATCH --time 0-10:00:00
#SBATCH --mem-per-cpu 16000
#SBATCH --gres=gpu:1
#SBATCH --partition gpu
#SBATCH --mail-user pbreier@mpi-cbg.de
#SBATCH --mail-type NONE
#SBATCH --exclude=r02n01
#SBATCH --output /projects/Quails/scripts/output/slurm-N2V_training_%j.out
#SBATCH --error /projects/Quails/scripts/errors/slurm-N2V_training_%j.err


# Change parameters and uncomment the next two lines before usage!
path_to_folder=${1}
number_of_epochs=${2}
steps_per_epoch=${3}

data=raw

eval "$(conda shell.bash hook)"
conda activate newN2V
module load cuda/11.2.2  # use most up-to-date cuda

# line is needed due to some stupid error I got (can't create file ...)
export HDF5_USE_FILE_LOCKING='FALSE'

# Check options and uncomment following line!
/projects/Quails/scripts/pipeline/trainN2V.py --baseDir=${path_to_folder}/../model --dataPath=${path_to_folder}/../${data} --fileName='*.tif' --epochs=${number_of_epochs} --dims=ZYX --validationFraction=5 --patchSizeZ=24 --batchSize=24 --stepsPerEpoch=${steps_per_epoch}
