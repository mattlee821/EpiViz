#!/bin/bash
#SBATCH -J obtain_adiposity_instruments
#SBATCH -A mr_adiposity_proteins_crc
#SBATCH --mem=100M
#SBATCH -t 1:00:00

cd ~/001_projects/000_datasets/

## Adiposity measures pulit ====
ls adiposity_GWAS/pulit_EU_2018/*.txt | while read f; do awk -F" " 'NR==1{print;next}$9<5e-09' ${f} > ${f}_pulit_snps.txt; done;
