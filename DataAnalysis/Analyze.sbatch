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
for FILE in Raw/40X/*; do
echo ${FILE}
DIR=$(echo "${FILE%.*}")
echo ${DIR##*/}
mkdir ${DIR##*/}
ffmpeg -i ${FILE} ${DIR##*/}/${DIR##*/}%05d.bmp

# Pull Info from Filename
fullname=${DIR##*/}
echo ${fullname}
# VPP
partname=${fullname##*_}
echo ${partname}
volt=\'${partname%V*}\'
echo ${volt}
# Freq
partname=${fullname##*X_}
echo ${partname}
freq=\'${partname%H*}\'
echo ${freq}
# Mag
partname=${fullname%%X_*}
echo ${partname}
mag=\'${partname##*_}\'
echo ${mag}
# Type
partname=${fullname%%_*}
echo ${partname}
if [${partname} = ${mag}X]
then
  wave=\'\'
else
  wave=\'${partname}\'
fi

# Run the Analysis
matlab -nodisplay -r "load 40X_sm.mat; ${MatlabFUNCTION}(${mag},${freq},${volt},${wave})"
rm ${DIR##*/}/*.bmp
rmdir ${DIR##*/}
done
