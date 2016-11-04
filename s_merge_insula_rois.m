function s_merge_insula_rois
% merges two mat rois, saves as single mat roi

% Path to subjects
datapath = '/media/lcne/matproc';

% Subject names
subjects = {'am160914'};

% Hemispheres
hemis = {'lh','rh'};

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    for hemi = 1:length(hemis)
        roi1name = [hemis{hemi} '_antins_a2009s_fd.mat'];
        roi2name = [hemis{hemi} '_shortins_a2009s_fd.mat'];
        newRoiName = [hemis{hemi} '_antshortins_fd.mat'];
        roi1    = dtiReadRoi(fullfile(roiPath, roi1name));
        roi2    = dtiReadRoi(fullfile(roiPath, roi2name));
        newRoiPath = fullfile(roiPath, newRoiName);
        newRoi     = dtiMergeROIs(roi1,roi2);
        dtiWriteRoi(newRoi, newRoiPath)
    end
end