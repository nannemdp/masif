#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --time=48:0:0
#SBATCH --qos=gpu
#SBATCH --gres=gpu:1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=gpu
#SBATCH --mem 16384

module purge
slmodules -r deprecated
module load gcc/5.4.0 cuda cudnn mvapich2 openblas
source /home/gainza/lpdi_fs/seednet/monet_seeder/tensorflow_on_gpu/bin/activate
export MONET_DIR=/home/gainza/lpdi_fs/seednet/monet_seeder/
export PYTHONPATH=$PYTHONPATH:$MONET_DIR:./
masif_root=$(git rev-parse --show-toplevel)
masif_source=$masif_root/source/
masif_matlab=$masif_root/source/matlab_libs/
export PYTHONPATH=$PYTHONPATH:$masif_source

srun python -u $masif_source/masif_ligand/masif_ligand_train.py
