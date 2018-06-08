#!/bin/bash

#SBATCH --job-name=Analyze
#SBATCH --output=Analyze.out
#SBATCH --error=Analyze.err
#SBATCH --nodes=1
#SBATCH --ntasks=1

cd Magnetometer
for FILE in *; do
echo ${FILE}
done

for FILE in *.sbatch; do
echo ${FILE}
done

cd ..

#module load matlab

#matlab -nodisplay < matlab_simple.m
