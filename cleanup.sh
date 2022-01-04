#!/bin/bash

#SBATCH --partition=batch
#SBATCH --output=/projects/Quails/scripts/output/slurm-cleanup-%j.out
#SBATCH --error=/projects/Quails/scripts/errors/slurm-cleanup-%j.err
#SBATCH --job-name=cleanup-$j
#SBATCH --time=0-00:01:00
#SBATCH --mem-per-cpu=100

parent_dir=${1}

cd ${parent_dir} || exit
rm *_mod*