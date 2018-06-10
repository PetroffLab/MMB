function [s,num]=read_frames(name,I)

num=list_them(name);

if nargin>1
    num=num(I);
end

k=0;
for i=num
k=k+1;
s{k}=read_frame(name,i);
if length(num)>1
    fprintf('reading frame %d  (%d of %d)\n',i,k,length(num));
end
end

if length(I)==1
    s=s{1};
end
end
