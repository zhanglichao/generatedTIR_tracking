function regions = read_vot_regions0(regions)
% READ_VOT_REGIONS
% reads vot ground-truth regions and transforms them to axis-aligned

%     regions = dlmread(filename);
if size(regions,2) > 4,
    cx = mean(regions(:,1:2:end),2);
    cy = mean(regions(:,2:2:end),2);
    x1 = round(min(regions(:, 1:2:end), [], 2));
    x2 = round(max(regions(:, 1:2:end), [], 2));
    y1 = round(min(regions(:, 2:2:end), [], 2));
    y2 = round(max(regions(:, 2:2:end), [], 2));
    %         regions = round([x1, y1, x2 - x1, y2 - y1]);
    x1y1x2y2 = regions(:,1:2) - regions(:,3:4);
    x2y2x3y3 = regions(:,3:4) - regions(:,5:6);
    A1 = sqrt(sum(x1y1x2y2.*x1y1x2y2,2)).* sqrt(sum(x2y2x3y3.*x2y2x3y3,2));
    A2 = (x2 - x1) .* (y2 - y1);
    s = sqrt(A1./A2);
    w = s .* (x2 - x1) + 1;
    h = s .* (y2 - y1) + 1;
    regions = [cx-w/2,cy-h/2,w,h];
end

end % endfunction