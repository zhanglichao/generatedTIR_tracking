function seq = load_video_info_vot1(ground_truth)

% ground_truth = dlmread([video_path '/groundtruth.txt']);

seq.format = 'otb';
seq.len = size(ground_truth, 1);
init_region  = ground_truth(1,:);

% If the provided region is a polygon ...
if numel(init_region) > 4    
    cx = mean(init_region(1:2:end));
    cy = mean(init_region(2:2:end));
    x1 = min(init_region(1:2:end));
    x2 = max(init_region(1:2:end));
    y1 = min(init_region(2:2:end));
    y2 = max(init_region(2:2:end));
    A1 = norm(init_region(1:2) - init_region(3:4)) * norm(init_region(3:4) - init_region(5:6));
    A2 = (x2 - x1) * (y2 - y1);
    s = sqrt(A1/A2);
    w = s * (x2 - x1) + 1;
    h = s * (y2 - y1) + 1;
    seq.init_rect = [cx-w/2,cy-h/2,w,h];
else
    x1 = init_region(1);
    y1 = init_region(2);
    w = init_region(3);
    h = init_region(4);
    seq.init_rect = [x1 y1 w h];
end



end

