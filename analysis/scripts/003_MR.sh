#!/bin/bash

#SBATCH --job-name=MR
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd ~/001_projects/

Rscript analysis/scripts/003_MR.R