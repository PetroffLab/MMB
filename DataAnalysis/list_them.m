function num=list_them(name)
a=ls(name);
a=char(a)

k=0;
for i=1:length(a)
   IND=strfind(a(i,:),'bmp');
   if ~isempty(IND)
       k=k+1;
       num(k)=str2double(a(i,(IND-6):(IND-2)));
   end
end
end