function results = report_tracking_result_local(seq, result, imgbounds)

if strcmpi(seq.format, 'vot_local')    
    bb_scale = 1;
    sz = result.target_size / bb_scale;
    tl = result.center_pos - (sz - 1)/2;
    br = result.center_pos + (sz - 1)/2;
    x1 = tl(2); y1 = tl(1);
    x2 = br(2); y2 = br(1);
    result_box = round(double([x1 y1 x2 y1 x2 y2 x1 y2]));
    if any(isnan(result_box) | isinf(result_box))
        error('Illegal values in the result.')
    end
    %         if any(result_box < 0)
    %             error('Negative values')
    %         end
    results.res = result_box; results.frame = seq.frame;
    if seq.reset
        % from vot-toolkit experiment_supervised
        %             imgbounds = [size(im,2),size(im,1)];
        o = region_overlap(result_box, seq.gt(seq.frame,:), imgbounds);
        if o(1) <= 0
            results.first_failure = seq.frame;
            break;
        end
    end
else
    error('Uknown sequence format');
end
