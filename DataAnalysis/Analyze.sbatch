#!/bin/bash

#SBATCH --job-name=Analyze
#SBATCH --output=Analyze.out
#SBATCH --error=Analyze.err
#SBATCH --nodes=1
#SBATCH --ntasks=1

# Initialize Matlab
module load matlab
MatlabFUNCTION=find_background

# Gain list of raw data
for FILE in Raw/*; do
echo ${FILE}
# Run the Analysis
matlab -nodisplay -r "${MatlabFUNCTION}('${FILE}')"
done

# Get rid of the raw data now that we don't need it on the cluster and reset
rm Raw/*.mat
