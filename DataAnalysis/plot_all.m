function plot_all(bug);


for i = 1:length(bug)
%    plot(real(bug{i}.pos),imag(bug{i}.pos),25,bug{i}.time/24,'filled')
   plot(bug{i}.pos)
   axis equal
   
   %title(sprintf('index: %d',i))
   drawnow ;
   hold on;
   
   
   
end