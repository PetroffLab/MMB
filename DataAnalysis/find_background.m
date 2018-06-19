function bug=find_background(MAG,freq,volt,TYPE)

if nargin==0
    TYPE=input('wave type (press enter for sine wave): ','s');
    MAG=input('magnification: ','s');
    freq=input('frequency: ','s');
    volt=input('peak to peak voltage: ','s');
end

if nargin==3
    TYPE='';
end

if isempty(TYPE)
    name=sprintf('%sX_%sHZ_%sVPP',MAG,freq,volt);
else
    name=sprintf('%s_%sX_%sHZ_%sVPP',TYPE,MAG,freq,volt);
end



num=list_them(name);
%v=VideoReader(name);

s=read_frames(name,round(linspace(1,length(num),60)));
back=0*s{1};

for i=1:length(s)
    back=back+s{i}/length(s);
%     A=readFrame(v);
%     A=double(rgb2gray(A);
%     save(sprintf('v%d.mat',i),'A');
end
clear('s')
%num=num(1:10);

% %s=read_frames(name,100);
% 
% % figure
% % for i=1:length(s)
% % imagesc(s{i})
% % axis equal
% % drawnow
% % end
% 
% back=zeros(size(s{1}));
% 
% for i=1:length(s)
%     back=back+s{i};
% end
% back=back/length(s);

% [X,Y]=meshgrid(-14:14,-14:14);
% R=sqrt(X.*X + Y.*Y);
% sm=0*R;
% sm(R<13.5)=-1;
% sm(R<5)=1;
% sm=sm/sum(sm(:));

%MANUAL CHANGE
load 40X_sm;

pos=cell(size(num));
tic;
for i=1:length(num)
    
    %imagesc(read_frames(name,i)-back);
    5; 
    
    A=-conv2(read_frames(name,i)-back,sm,'same');
   % imagesc(A)
    axis equal
    bw=A>20;
    data{i}=regionprops(bw);
    hold on
    for j=1:length(data{i})
        %plot(data{i}(j).Centroid(1),data{i}(j).Centroid(2),'ro')
        pos{i}(j)=data{i}(j).Centroid(1)+1i*data{i}(j).Centroid(2);
    end
    hold off
    %drawnow
    TOC=toc;
    fprintf('found cell: %d of %d\n',i,length(num));
    fprintf('%f sec remaining\n',(TOC/i)*(length(num)-i));
end

predictions=[real(pos{1}'), imag(pos{1}')];
assign = cell(length(num)-1,1);
untrack = cell(length(num)-1,1);
undetect = cell(length(num)-1,1);





for i=2:length(pos);
    detections=[real(pos{i}'), imag(pos{i}')];
    cost = zeros(size(predictions,1),size(detections,1));
    for j = 1:size(predictions, 1)
      try
        diff = detections - repmat(predictions(j,:),[size(detections,1),1]);
      cost(j, :) = sqrt(sum(diff .^ 2,2));
      catch
          5;
      end
    end
    [assignment,unassignedTracks,unassignedDetections] =assignDetectionsToTracks(cost,50);
     predictions=detections;
     assign{i} = assignment;
     untrack{i} = unassignedTracks;
     undetect{i} = unassignedDetections;
   
    5;
     fprintf('stitching cells: %d\n',i);
end

w = 1;
while (length(pos{w}) == 0)
    w=w+1;
end
    
for i =1:length(pos{w})
    bug{i}.pos = pos{w}(i);
    bug{i}.time = 1;
    bug{i}.index = i;    
end
5;

for t = 2:(length(num)-1)
   %we need to track the bugs through each frame/time
   for i =1:size(assign{t},1)
       D = assign{t}(i,2); %detected 
       P = assign{t}(i,1); %predicted
       
       for k = 1: length(bug)
           try
           T = bug{k}.time(end); %current time
           I = bug{k}.index(end);%current index
           catch
               5;
           end
           if I ==P && T == (t-1)
               K = k;
           end
       end
     bug{K}.pos(end +1) = pos{t}(D);
     bug{K}.time(end +1) = t;
     bug{K}.index(end +1) = D;
      
   end
    5;
    
     
      for j = 1:size(undetect{t},1)
    bug{end+1}.pos = pos{t}(undetect{t}(j));
    bug{end}.time = t;
    bug{end}.index = undetect{t}(j);
      end
     
end


kill = zeros(length(bug),1);

for i = 1:length(bug)
    try 
   if length(bug{i}.pos) < 15
       kill(i) = 1;
   end
    catch
        5;
    end
end

bug(kill == 1) = [];

5;

try
    system(strcat('mkdir .\AnalyzedData\',name));
catch
    system(strcat('mkdir ./AnalyzedData/',name));
end

if isempty(TYPE)
    save_name=sprintf('./AnalyzedData/%s/bug_%sX_%sHZ_%sVPP.mat',name,MAG,freq,volt);
else
    save_name=sprintf('./AnalyzedData/%s/bug_%s_%sX_%sHZ_%sVPP.mat',name,TYPE,MAG,freq,volt);
end

save(save_name,'bug','name')







