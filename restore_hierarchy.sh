#!/bin/bash

#SBATCH --partition=batch
#SBATCH --output=/projects/Quails/scripts/output/slurm-reordering-%j.out
#SBATCH --error=/projects/Quails/scripts/errors/slurm-reordering-%j.err
#SBATCH --job-name=reordering-$j
#SBATCH --time=0-00:01:00
#SBATCH --mem-per-cpu=100

parent_dir=${1}

cd ${parent_dir} || exit
mv **/max_pp_tile*.tif . # move FusedXXX.tif one folder up
find . -maxdepth 2 -mindepth 2 -type d -exec bash -c "cd '{}' && mv * ../ " \; # move handcorrection one folder up
find . -maxdepth 2 -mindepth 1 -empty -type d -delete  # delete now empty directories