function scan(bug,v);
if nargin==1
v=1:length(bug);
end

for i = v
   scatter(real(bug{i}.pos),imag(bug{i}.pos),25,bug{i}.time/24,'filled')
%   plot(bug{i}.pos)
   axis equal
   colorbar
   title(sprintf('index: %d',i))
   drawnow ;
   figure(1);
   input (' ');
   
end