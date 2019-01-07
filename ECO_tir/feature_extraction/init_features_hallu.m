function [features, gparams, feature_info] = init_features_hallu(features, gparams, is_color_image, img_sample_sz, size_mode)

if nargin < 3
    size_mode = 'same';
end


% Set missing global parameters to default values
if ~isfield(gparams, 'normalize_power')
    gparams.normalize_power = [];
end
if ~isfield(gparams, 'normalize_size')
    gparams.normalize_size = true;
end
if ~isfield(gparams, 'normalize_dim')
    gparams.normalize_dim = false;
end
if ~isfield(gparams, 'square_root_normalization')
    gparams.square_root_normalization = false;
end
if ~isfield(gparams, 'use_gpu')
    gparams.use_gpu = false;
end

% find which features to keep
feat_ind = false(length(features),1);
for n = 1:length(features)
    
    if ~isfield(features{n}.fparams,'useForColor')
        features{n}.fparams.useForColor = true;
    end
    
    if ~isfield(features{n}.fparams,'useForGray')
        features{n}.fparams.useForGray = true;
    end
    
    if (features{n}.fparams.useForColor && is_color_image) || (features{n}.fparams.useForGray && ~is_color_image)
        % keep feature
        feat_ind(n) = true;
    end
end

% remove features that are not used
features = features(feat_ind);

num_features = length(features);

feature_info.min_cell_size = zeros(num_features,1);


% Initialize features by
% - setting the dimension (nDim)
% - specifying if a cell array is returned (is_cell)
% - setting default values of missing feature-specific parameters
% - loading and initializing necessary data (e.g. the lookup table or the network)
for k = 1:length(features)
    if isequal(features{k}.getFeature, @get_fhog)
        if ~isfield(features{k}.fparams, 'nOrients')
            features{k}.fparams.nOrients = 9;
        end
        features{k}.fparams.nDim = 3*features{k}.fparams.nOrients+5-1;
        features{k}.is_cell = false;
        features{k}.is_cnn = false;
        
    elseif isequal(features{k}.getFeature, @get_table_feature)
        table = load(['lookup_tables/' features{k}.fparams.tablename]);
        features{k}.fparams.nDim = size(table.(features{k}.fparams.tablename),2);
        features{k}.is_cell = false;
        features{k}.is_cnn = false;
        
    elseif isequal(features{k}.getFeature, @get_colorspace)
        features{k}.fparams.nDim = 1;
        features{k}.is_cell = false;
        features{k}.is_cnn = false;
        
    elseif isequal(features{k}.getFeature, @get_cnn_layers) || isequal(features{k}.getFeature, @get_OFcnn_layers)
        % make sure the layers are correcly sorted
        features{k}.fparams.output_layer = sort(features{k}.fparams.output_layer);
        
        % Set default parameters
        if ~isfield(features{k}.fparams, 'input_size_mode')
            features{k}.fparams.input_size_mode = 'adaptive';
        end
        if ~isfield(features{k}.fparams, 'input_size_scale')
            features{k}.fparams.input_size_scale = 1;
        end
        if ~isfield(features{k}.fparams, 'downsample_factor')
            features{k}.fparams.downsample_factor = ones(1, length(features{k}.fparams.output_layer));
        end
        
        % load the network
        net{k} = load_cnn(features{k}.fparams, img_sample_sz);
        
        % find the dimensionality of each layer
        features{k}.fparams.nDim = net{k}.info.dataSize(3, features{k}.fparams.output_layer+1)';
        
        % find the stride of the layers
        if isfield(net{k}.info, 'receptiveFieldStride')
            net_info_stride{k} = cat(2, [1; 1], net{k}.info.receptiveFieldStride);
        else
            net_info_stride{k} = [1; 1];
        end
        
        % compute the cell size of the layers (takes down-sampling factor
        % into account)
        features{k}.fparams.cell_size = net_info_stride{k}(1, features{k}.fparams.output_layer+1)' .* features{k}.fparams.downsample_factor';
        
        % this feature will always return a cell array
        features{k}.is_cell = true;
        features{k}.is_cnn = true;
    elseif isequal(features{k}.getFeature, @get_cnnho_layers)
        % make sure the layers are correcly sorted
        features{k}.fparams.output_layer = sort(features{k}.fparams.output_layer);
        
        % Set default parameters
        if ~isfield(features{k}.fparams, 'input_size_mode')
            features{k}.fparams.input_size_mode = 'adaptive';
        end
        if ~isfield(features{k}.fparams, 'input_size_scale')
            features{k}.fparams.input_size_scale = 1;
        end
        if ~isfield(features{k}.fparams, 'downsample_factor')
            features{k}.fparams.downsample_factor = ones(1, length(features{k}.fparams.output_layer));
        end
        
        % load the network
        net{k} = load_cnn(features{k}.fparams, img_sample_sz);
        
        % find the dimensionality of each layer
        features{k}.fparams.nDim = net{k}.info.dataSize(3, features{k}.fparams.output_layer+1)';
        
        % find the stride of the layers
        if isfield(net{k}.info, 'receptiveFieldStride')
            net_info_stride{k} = cat(2, [1; 1], net{k}.info.receptiveFieldStride);
        else
            net_info_stride{k} = [1; 1];
        end
        
        % compute the cell size of the layers (takes down-sampling factor
        % into account)
        features{k}.fparams.cell_size = net_info_stride{k}(1, features{k}.fparams.output_layer+1)' .* features{k}.fparams.downsample_factor';
        
        % this feature will always return a cell array
        features{k}.is_cell = true;
        features{k}.is_cnn = true;
    elseif isequal(features{k}.getFeature,@get_eitel_cnn)
        features{k}.fparams = make_eitel_feature(features{k}.fparams);
    else
        error('Unknown feature type');
    end
    
    % Set default cell size
    if ~isfield(features{k}.fparams, 'cell_size')
        features{k}.fparams.cell_size = 1;
    end
    
    % Set default penalty
    if ~isfield(features{k}.fparams, 'penalty')
        features{k}.fparams.penalty = zeros(length(features{k}.fparams.nDim),1);
    end
    
    % Find the minimum cell size of each layer
    feature_info.min_cell_size(k) = min(features{k}.fparams.cell_size);
end

% Order the features in increasing minimal cell size
% [~, feat_ind] = sort(feature_info.min_cell_size);
% features = features(feat_ind);
% feature_info.min_cell_size = feature_info.min_cell_size(feat_ind);

% Set feature info
feature_info.dim_block = cell(num_features,1);
feature_info.penalty_block = cell(num_features,1);

for k = 1:length(features)
    % update feature info
    feature_info.dim_block{k} = features{k}.fparams.nDim;
    feature_info.penalty_block{k} = features{k}.fparams.penalty(:);
end
% Feature info for each cell block
feature_info.dim = cell2mat(feature_info.dim_block);
feature_info.penalty = cell2mat(feature_info.penalty_block);

% This ugly code sets the image sample size to be used for extracting the
% features. It then computes the data size (size of the features) and the
% image support size (the corresponding size in the image).

% decide the datasize, choose the biggest one
for k = 1:length(features)
    scale = features{k}.fparams.input_size_scale;
    
    new_img_sample_sz{k} = img_sample_sz;
    
    % First try decrease one
    net_info = net{k}.info;
    
    if ~strcmpi(size_mode, 'same') && strcmpi(features{k}.fparams.input_size_mode, 'adaptive')
        orig_sz = net{k}.info.dataSize(1:2,end)' / features{k}.fparams.downsample_factor(end);
        
        if strcmpi(size_mode, 'exact')
            desired_sz = orig_sz + 1;
        elseif strcmpi(size_mode, 'odd_cells')
            desired_sz = orig_sz + 1 + mod(orig_sz,2);
        end
        
        while desired_sz(1) > net_info.dataSize(1,end)
            new_img_sample_sz{k} = new_img_sample_sz{k} + [1, 0];
            net_info = vl_simplenn_display(net{k}, 'inputSize', [round(scale * new_img_sample_sz{k}), 3 1]);
        end
        while desired_sz(2) > net_info.dataSize(2,end)
            new_img_sample_sz{k} = new_img_sample_sz{k} + [0, 1];
            net_info = vl_simplenn_display(net{k}, 'inputSize', [round(scale * new_img_sample_sz{k}), 3 1]);
        end
    end
    
end    
% decide the datasize, choose the biggest one
new_img_sample_sz0 = new_img_sample_sz{1};
for k = 1:length(features)
    if new_img_sample_sz0(1) < new_img_sample_sz{k}(1);
        new_img_sample_sz0 = new_img_sample_sz{k};
    end
end
feature_info.img_sample_sz = round(new_img_sample_sz0);

% respectively allocate two nets' size
for k = 1:length(features)    
    scale = features{k}.fparams.input_size_scale;
    net_info = vl_simplenn_display(net{k}, 'inputSize', [round(scale * new_img_sample_sz0), 3 1]);

    if strcmpi(features{k}.fparams.input_size_mode, 'adaptive')
        features{k}.img_input_sz = feature_info.img_sample_sz;
    else
        features{k}.img_input_sz = net{k}.meta.normalization.imageSize(1:2);
    end
    
    % Sample size to be input to the net
    scaled_sample_sz = round(scale * features{k}.img_input_sz);
    
    if isfield(net_info, 'receptiveFieldStride')
        net_info_stride{k} = cat(2, [1; 1], net_info.receptiveFieldStride);
    else
        net_info_stride{k} = [1; 1];
    end
    
    net_stride = net_info_stride{k}(:, features{k}.fparams.output_layer+1)';
    total_feat_sz = net_info.dataSize(1:2, features{k}.fparams.output_layer+1)';
    
    shrink_number = max(2 * ceil((net_stride(end,:) .* total_feat_sz(end,:) - scaled_sample_sz) ./ (2 * net_stride(end,:))), 0);
    
    deepest_layer_sz = total_feat_sz(end,:) - shrink_number;
    scaled_support_sz = net_stride(end,:) .* deepest_layer_sz;
    
    % Calculate output size for each layer
    cnn_output_sz{k} = round(bsxfun(@rdivide, scaled_support_sz, net_stride));
    features{k}.fparams.start_ind = floor((total_feat_sz - cnn_output_sz{k})/2) + 1;
    features{k}.fparams.end_ind = features{k}.fparams.start_ind + cnn_output_sz{k} - 1;
    
    feature_info.img_support_sz = round(scaled_support_sz .* feature_info.img_sample_sz ./ scaled_sample_sz);
    
    % Set the input size
    features{k}.fparams.net = set_cnn_input_size(net{k}, feature_info.img_sample_sz);
    
    if gparams.use_gpu        
        features{k}.fparams.net = vl_simplenn_move(features{k}.fparams.net, 'gpu');
    end
end

% Set the sample size and data size for each feature
feature_info.data_sz_block = cell(num_features,1);
for k = 1:length(features)
    if features{k}.is_cnn
        % CNN features have a different sample size, since the receptive
        % field is often larger than the support size
        features{k}.img_sample_sz = feature_info.img_sample_sz(:)';
        
        % Set the data size based on the computed output size
        feature_info.data_sz_block{k} = floor(bsxfun(@rdivide, cnn_output_sz{k}, features{k}.fparams.downsample_factor'));
    else
        % implemented classic features always have the same sample and
        % support size
        features{k}.img_sample_sz = feature_info.img_support_sz(:)';
        features{k}.img_input_sz = features{k}.img_sample_sz;
        
        % Set data size based on cell size
        feature_info.data_sz_block{k} = floor(bsxfun(@rdivide, features{k}.img_sample_sz, features{k}.fparams.cell_size));
    end
end

feature_info.data_sz = cell2mat(feature_info.data_sz_block);