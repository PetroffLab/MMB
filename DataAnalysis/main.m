%%
Fs = 1000;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector
%%
% Test Functions
test{1}.pos = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t) + 5i*t;
test{2}.pos = sin(2*pi*120*t) + 5i*t;
test{3}.pos = (sin(2*pi*120*t) + 5i*t) * exp(1i*pi/4) + 4;
test{4}.pos = 0.7*sin(2*pi*50*t) + 5i*t;
test{3}.pos = (0.7*sin(2*pi*50*t) + 5i*t) * exp(1i*pi/4) + 4;
for i=1:length(test)
  test{i}.time = t;
end

testtraj=PowerSpec(15,Fs,test)
%%

for i=1:length(testtraj)
  figure()
  plot(test{i}.pos);
end


for i=1:length(testtraj)
  figure()
  plot(testtraj{i}.f,testtraj{i}.fft);
end

bug=find_background('40','2.0','0.75','SQ');
traj=PowerSpec(20,24,bug);

for i=1:length(traj)
  figure()
  plot(traj{i}.f,traj{i}.fft);
end
