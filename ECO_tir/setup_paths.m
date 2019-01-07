function setup_paths()

% Add the neccesary paths

[pathstr, name, ext] = fileparts(mfilename('fullpath'));

% Tracker implementation
addpath(genpath([pathstr '/implementation/']));

% Runfiles
addpath(genpath([pathstr '/runfiles/']));

% Utilities
addpath([pathstr '/utils/']);

% The feature extraction
addpath(genpath([pathstr '/feature_extraction/']));

% Matconvnet
% addpath([pathstr '/external_libs/matconvnet/matlab/mex/']);
% addpath([pathstr '/external_libs/matconvnet/matlab']);
% addpath([pathstr '/external_libs/matconvnet/matlab/simplenn']);
addpath('/home/lichao/softwares/matconvnet25/matlab/mex/');
addpath('/home/lichao/softwares/matconvnet25/matlab');
addpath('/home/lichao/softwares/matconvnet25/matlab/simplenn');
vl_setupnn

% PDollar toolbox
addpath(genpath([pathstr '/external_libs/pdollar_toolbox/channels']));

% Mtimesx
addpath([pathstr '/external_libs/mtimesx/']);

% mexResize
addpath([pathstr '/external_libs/mexResize/']);
