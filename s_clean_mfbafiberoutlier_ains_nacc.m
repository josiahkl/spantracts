function s_clean_mfbafiberoutlier_ains_nacc
%
% script to cleanfiber group outliers based on fiber length and mahalanobis
% distance
%

% Path to subjects
datapath = '/media/lcne/matproc';

% Subject names
subjects = {'am160914'};

for isubj = 1:length(subjects)

    subjectDir    = [subjects{isubj}];
    fibersFolder  = fullfile(baseDir, subjectDir, '/dti96trilin/fibers/mrtrix/');
    
    %load fiber group, clean outliers, save cleaned fiber group
    rh_fg_name = dir([fibersFolder '/*rh_antshortins_fd_rh_nacc_aseg_fd_rh_antshortins_fd*.pdb']);
    rh_fg_path = fullfile(fibersFolder, rh_fg_name.name);
    rh_fg_unclean = fgRead(rh_fg_path);
    [rh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(rh_fg_unclean, 3, 2, 100);
    fgWrite(rh_fg_clean, [fibersFolder '/clean_rh_antshortins_nacc'],'mat');

    %left hemisphere
    lh_fg_name = dir([fibersFolder '/*lh_antshortins_fd_lh_nacc_aseg_fd_lh_antshortins_fd*.pdb']);
    lh_fg_path = fullfile(fibersFolder, lh_fg_name.name);
    lh_fg_unclean = fgRead(lh_fg_path);
    [lh_fg_clean, fg_keep_vec] = mbaComputeFibersOutliers(lh_fg_unclean, 3, 2, 100);
    fgWrite(lh_fg_clean, [fibersFolder '/clean_lh_antshortins_nacc'],'mat');
end