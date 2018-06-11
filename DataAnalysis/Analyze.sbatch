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
for FILE in Raw/*.mp4; do
echo ${FILE}
DIR = ${FILE%*.}
echo ${DIR}
# mkdir ${DIR}
# ffmpeg -i ${FILE} ${DIR}/${DIR}%05d.png
# Run the Analysis
# matlab -nodisplay -r "${MatlabFUNCTION}('Raw/${FILE}')"
done

# Get rid of the raw data now that we don't need it on the cluster and reset
# rm Raw/*.mat
