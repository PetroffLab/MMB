###############################################################################
################# Find the Delay from GPhoto to Camera ########################
################################ 8/3/18 #######################################

## Run as either Root or sudo, possibly sudo -H to avoid 'Device has no Languid'

import visa
import time
import subprocess as sp

rm = visa.ResourceManager("@py")

# Label address of function generator. If device is changed, this must also change
## Also change the values of the controls below to calibrate
addr = 'USB0::2391::5383::MY48006606::0::INSTR'

# Open Function Generator
func_gen = rm.open_resource(addr)
func_gen.write("OUTP OFF")

###############################################################################
# These controls are Model Specific!!!!!!
# Before continuing make sure commands and model numbers match
###############################################################################

###############################################################################
# Controls for Agilent 33210A
## Command list inside http://nnp.ucsd.edu/Lab_Equip_Manuals/hp_33210a_User_guide.pdf

freq = "1.0"
amp = "2.37"
offset = "1.18"
func_gen.write("APPL:SIN " + freq + ", " + amp + ", " + offset)


###############################################################################
# Outputting to function generator

func_gen.write("OUTP ON")

###############################################################################
# Using GPhoto
command = ['gphoto2']
command.append('--capture-movie=10s')

sp.check_call(command)

###############################################################################
# Close function Generator
func_gen.close()
