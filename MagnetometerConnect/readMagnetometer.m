function [x,y,z] = readMagnetometer(comPort)
 
% It creates a serial element calling the function "stupSerial"

if(~exist('serialFlag','var'))
    [arduino] = setupSerial(comPort);
end

while(strcmp(fscanf(arduino,'%s'),'-'))
end

xvec = fscanf(arduino,'%f');

[x,y,z] = xvec;

fclose(arduino);
end