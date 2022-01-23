# still has to be written
# google use localz porjector in scripts (should be an entry in image.sc forum)

# Check what options you need here!
#SBATCH --job-name="projection"
#SBATCH --time=0-04:00:00
#SBATCH --mem-per-cpu=60000
#SBATCH --mail-user=pbreier@mpi-cbg.de
#SBATCH --mail-type=None
#SBATCH --output=/projects/Quails/scripts/output/slurm-projection_%j.out
#SBATCH --error=/projects/Quails/scripts/errors/slurm-projection_%j.err
#SBATCH --array=1-==number_of_tiles==


