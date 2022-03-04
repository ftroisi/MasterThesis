#!/bin/bash -l
# Stk12andard output and error:
#SBATCH -o ./jobName.out.%j
#SBATCH -e ./jobName.err.%j
# Initial working directory:
#SBATCH -D ./
# Job Name:
#SBATCH -J jobName
# Queue (Partition):
#SBATCH --partition=general,mpsd,express
# Number of nodes and MPI tasks per node:
#SBATCH --nodes=NNODES
#SBATCH --ntasks-per-node=72
#SBATCH --ntasks=NTASKS
# for OpSpenMP:
#SBATCH --cpus-per-task=1
#
# Request 122 GB of main memory per node in units of MB:
#SBATCH --mem=122000
#
#SBATCH --mail-type=ALL
##SBATCH --mail-user=your_email@place.com
# Wall clock Limit: e.g. 2 hours
#SBATCH --time=02:00:00

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
# For pinning threads correctly
export OMP_PLACES=cores

# Load modules
module purge
module load intel/21.2.0 impi/2021.2 octopus/11

# set octopus flags if desired, alternatively keep everything in the input files
export OCT_PARSE_ENV=1 #This must be one for any other environment variables to affect octopus
#export OCT_ExperimentalFeatures=yes
#export OCT_ParDomains=no
#export OCT_ParStates=no
#export OCT_ParKPoints=NTASKS

# example workflow
cp inpGs ./inp
export OCT_CalculationMode=gs
srun octopus >& out-gs

cp inpTd ./inp
export OCT_CalculationMode=td
srun octopus >& out-td
    
