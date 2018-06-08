#!/bin/bash

#SBATCH --job-name=HelloWorld
#SBATCH --output=Hello.out
#SBATCH --error=Hello.err
#SBATCH --nodes=1
#SBATCH --ntasks=1

echo Hello %1
