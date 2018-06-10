function stitch(bug)

kill = zeros(length(bug),1);

for i = 1:length(bug)
   if length(bug{i}.pos) < 15
       kill(i) = 1;
   end
end

bug(kill == 1) = [];

for i = 1:length(bug)
   if length(bug{i}.pos) > 4
%       Reslope = real(bug{i}.pos(end)')-real(bug{i}.pos(1)');
%       Imslope = imag(bug{i}.pos(end)')-imag(bug{i}.pos(1)');
%       
%       Reslope = Reslope/length(bug{i}.pos);
%       Imslope = Imslope/length(bug{i}.pos);
%       
%       newx = real(bug{i}.pos(end)') + Reslope;
%       newy = imag(bug{i}.pos(end)') + Imslope;
%       
%       %comparing any new bugs to this bug that just ended
%       predictions = complex(newx, newy);

        T = bug{i}.time(end) + 1; 
        t_ = bug{i}.time(end-4:end);
        y = bug{i}.pos(end-4:end);
        p = polyfit(t_,y,1);
        prediction= polyval(p,T); 

%     x = linspace(bug{i}.time(end-4),bug{i}.time(end),5);
%     y = linspace(bug{i}.pos(end-4),bug{i}.pos(end),5);
%     p = polyfit(x,y,1);

        for k = i:length(bug)
            prediction= polyval(p,bug{k}.time(1));

            detections=[real(bug{k}.pos(1)'), imag(bug{k}.pos(1)')];
            %cost = zeros(size(predictions,1),size(detections,1));

            diff = detections - predictions;
            cost = sqrt(sum(diff .^ 2,2));

            [assignment,unassignedTracks,unassignedDetections] =assignDetectionsToTracks(cost,100);
            predictions=detections;
            assign{i} = assignment;
            untrack{i} = unassignedTracks;
            undetect{i} = unassignedDetections;

            fprintf('stitching cells: %d\n',i);
        end
    end
end