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
for FILE in Raw/0.54a/*; do
echo ${FILE}
DIR=$(echo "${FILE%.*}")
echo ${DIR##*/}
mkdir ${DIR##*/}
ffmpeg -i ${FILE} ${DIR##*/}/${DIR##*/}%05d.bmp
# Run the Analysis
matlab -nodisplay -r "load 0.54a_sm.mat; ${MatlabFUNCTION}('${DIR##*/}')"
rm ${DIR##*/}/*.bmp
rmdir ${DIR##*/}
done

for FILE in Raw/40X/*; do
echo ${FILE}
DIR=$(echo "${FILE%.*}")
echo ${DIR##*/}
mkdir ${DIR##*/}
ffmpeg -i ${FILE} ${DIR##*/}/${DIR##*/}%05d.bmp
# Run the Analysis
matlab -nodisplay -r "load 40X_sm.mat; ${MatlabFUNCTION}('${DIR##*/}')"
rm ${DIR##*/}/*.bmp
rmdir ${DIR##*/}
done
# Get rid of the raw data now that we don't need it on the cluster and reset
