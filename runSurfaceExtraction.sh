#!/bin/bash

#SBATCH -p batch
#SBATCH -o SurfaceExtraction.out
#SBATCH -e SurfaceExtraction.err
#SBATCH -J SurfaceExtraction
#SBATCH -t 10:00:00
#SBATCH --mem-per-cpu=1000
#SBATCH --array 24,28 

PRJ=/projects/project_jana

vars="
   processType='current image' 
   processFolder='$PRJ/SD4/n2v_stitched_crop/'
   processFile='$PRJ/SD4/n2v_stitched_crop/20200224_ecadGFP_cdc2ts_400nM20_30C_$( printf "%03d" $SLURM_ARRAY_TASK_ID ).tif'
   useRoi=false
   saveOption=true
   outFolder='$PRJ/SD4/n2v_projected'

   downsample_factor_xy=0.04
   downsample_factor_z=1
   max_dz=14
   zMapBlurringRadius=10

   downsample_factor_xy_fine=0.1
   downsample_factor_z_fine=1
   max_dz_fine=4
   relativeWeight=0.4
   surfacesMinDistance=6
   surfacesMaxDistance=80
"

Fiji.app/ImageJ-linux64 \
    --headless \
    --run $PRJ/SD4/Wing2SurfaceExtraction_ND_v1.4.py "$( echo "$vars" | grep = | tr '\012' ',' | sed 's/   //g' | sed 's/,$//' )"

