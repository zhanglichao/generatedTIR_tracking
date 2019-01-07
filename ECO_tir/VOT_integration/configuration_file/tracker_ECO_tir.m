
% Copy this template configuration file to your VOT workspace.
% Enter the full path to the ECO repository root folder.

ECO_repo_path = '/home/lichao/papers/ECO/ECO';

tracker_label = 'OTB_DEEP_settings_tircnn';
tracker_command = generate_matlab_command('benchmark_tracker_wrapper(''ECO'', ''OTB_DEEP_settings_tircnn'', true)', {[ECO_repo_path '/VOT_integration/benchmark_wrapper']});
tracker_interpreter = 'matlab';
