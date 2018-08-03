###############################################################################
################# Find the Delay from GPhoto to Camera ########################
################################ 8/3/18 #######################################

import visa
import time
import gphoto2cffi as gp
import StringIO
from PIL import image

rm = visa.ResourceManager("@py")

# Label address of function generator. If device is changed, this must also change
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

freq = "0.1"
amp = "1.0"
offset = "0.5"
func_gen.write("APPL:PULS " + freq + ", " + amp + ", " + offset)


###############################################################################
# Outputting to function generator

func_gen.write("OUTP ON")

###############################################################################
# Using GPhoto
my_cam = next(gp.list_cameras())
imageData = my_cam.capture()


###############################################################################
# Close function Generator
func_gen.close()
