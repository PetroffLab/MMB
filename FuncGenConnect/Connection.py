###############################################################################
################ Function Generator To Python Connection ######################
################################ 6/25/18 ######################################

import visa
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

freq = "2.0"
amp = "1.0"
offset = "0.5"
func_gen.write("APPL:SIN " + freq + ", " + amp + ", " + offset)


###############################################################################
# Outputting to function generator

func_gen.write("OUTP ON")

###############################################################################
# Close function Generator
func_gen.close()
