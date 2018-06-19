%%
% Load Proper Scaling Matrix
load 40X_sm.mat
%%
% Track Particles
bug = find_background('SQ_40X_2.0HZ_0.75VPP');
%%
% Go through each track and analyze only bugs with more than num points
hold on;
l=0;
num = 15;
for i=1:length(bug)
    if(length(bug{i}.pos)>num)
        %%
        % Load Data from the find_background function
        x = zeros(length(bug{i}.pos));
        y = zeros(length(bug{i}.pos));
        x=real(bug{i}.pos);
        y=imag(bug{i}.pos);
        %%
        % Find the Curvature
        dt=mean(diff(bug{i}.time));
        dx=[0,diff(x)]/dt;
        ddx=[0,diff(dx)]/dt;
        dy=[0,diff(y)]/dt;
        ddy=[0,diff(dy)]/dt;
        tempk=(dx.*ddy)-(dy.*ddx);
        k=tempk/((dot(dx,dx)+dot(dy,dy))^(3/2));
        l=l+1;
        %%
        % Load Chosen tracks into a special variable to analyze later
        traj{l}.t=bug{i}.time;
        traj{l}.x=x;
        traj{l}.y=y;
        traj{l}.k=k;
        %%
        % Plot the important bits
%         plot(x,y)
        figure();
        plot(bug{i}.time,k)
%         plot(bug{i}.time,fft(k))
%         i
%         axis([0 2 0 5]);
    end
end
hold off;