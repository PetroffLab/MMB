function num=list_them(name)
a=dir(name);
% length(a)

k=0;
for i=1:length(a)
    b=char(a(i).name);
   IND=strfind(b,'bmp');
   if ~isempty(IND)
       k=k+1;
       num(k)=str2double(b((IND-6):(IND-2)));
   end
end
end