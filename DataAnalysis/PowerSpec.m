function traj=PowerSpec(num,framerate,bug)
    %%
    % Go through each track and analyze only bugs with more than num points
    l=0;
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
            % Fourier Transform
            Y=abs(fft(k)).^2;
            T=bug{i}.time*framerate;
            L=length(Y);
            P2=abs(Y./T);
            length(P2);
            length(Y);
            P1=P2(1:L/2+1);
            P1(2:end-1)=2*P1(2:end-1);
            traj{l}.f=framerate*(0:(L/2))/L;
            traj{l}.fft=P1;
            plot(f,P1);
            figure();
        end
    end
end