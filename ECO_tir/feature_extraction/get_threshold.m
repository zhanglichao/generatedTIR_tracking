function [ thresh_im ] = get_threshold( im, fparam, gparam )

    if isfield(fparam, 'cell_size')
        cell_size = fparam.cell_size;
    else
        cell_size = gparam.cell_size;
    end

    if isinteger(im)
        thresh_im = single(im)/255;
    end

    if isfield(fparam, 'diff_im') && ~isempty(fparam.diff_im)
        if isinteger(im)
            thresh_im = thresh_im - single(fparam.diff_im)/255;
        else
            thresh_im = thresh_im - fparam.diff_im;
        end
    end
    
    if isfield(fparam, 'pre_mapping') && ~isempty(fparam.pre_mapping)
        thresh_im = fparam.pre_mapping(thresh_im);
    end
    
    switch fparam.threshold_type
        case 'larger_than'
            binary_im = thresh_im > fparam.threshold;
        case 'smaller_than'
            binary_im = thresh_im < fparam.threshold;
        otherwise
            error('Unknown threshold type');
    end
    
    thresh_im = single(binary_im);
    
    if isfield(fparam, 'post_mapping') && ~isempty(fparam.post_mapping)
        thresh_im = fparam.post_mapping(thresh_im);
    end
    
    if isfield(fparam, 'post_mapping_chan') && ~isempty(fparam.post_mapping_chan)
        for k = 1:size(thresh_im,3)
            for l = 1:size(thresh_im,4)
                thresh_im(:,:,k,l) = fparam.post_mapping_chan(thresh_im(:,:,k,l));
            end
        end
    end
    if isa(gparam.data_type, 'gpuArray')
        thresh_im = gpuArray(thresh_im);
    end
    if cell_size > 1
        thresh_im = average_feature_region(thresh_im, cell_size);
    end;
end

