function [seq, ground_truth] = load_video_info(video_path)

ground_truth = dlmread([video_path '/groundtruth.txt']);

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

img_path = [video_path '/'];

if exist([img_path num2str(1, '%08i.png')], 'file'),
    img_files = num2str((1:seq.len)', [img_path '%08i.png']);
elseif exist([img_path num2str(1, '%08i.jpg')], 'file'),
    img_files = num2str((1:seq.len)', [img_path '%08i.jpg']);
elseif exist([img_path num2str(1, '%08i.bmp')], 'file'),
    img_files = num2str((1:seq.len)', [img_path '%08i.bmp']);
else
    error('No image files to load.')
end

seq.s_frames = cellstr(img_files);

end

