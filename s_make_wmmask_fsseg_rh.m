function s_make_wmmask_fsseg_rh
%
% This script makes the white-matter mask from freesurfer segmentation
%
% Copyright Franco Pestilli (c) Stanford University, 2014

% Path to subjects
datapath = '/media/lcne/matproc';

% Subject names
subjects = {'am160914'};
  
for isubj = 1:length(subjects)
    matRoiFolder = fullfile(matProcDir,subjects{isubj},'ROIs');
    
    % white-matter mask filename
    wmMaskFile = fullfile(matRoiFolder,'rh_wmmask_fs.nii.gz'); 
    [~,wmMaskFileName,~] = fileparts(wmMaskFile);
    wmMaskFileName = wmMaskFileName(1:end-4); %strip .nii after .gz
    
    % freesurfer segmentation filename
    fs_wm = matchfiles(fullfile(matRoiFolder,'a2009seg2acpc.nii.gz'));
    
    % perform mri_convert to ensure freesurfer file is RAS
    % only include segmentation / parcellation values defined below
    eval(sprintf('!mri_convert  --out_orientation RAS %s %s', fs_wm{1}, wmMaskFile));
    wm = niftiRead(wmMaskFile);
    invals = [16 41 49 50 51 52 58 60 12106 12113 12115 12116 12117 12118 12124 12139 12148 12149 12155 12163 12164 12165];
    origvals = unique(wm.data(:));
    fprintf('\n[%s] Converting voxels... ',mfilename);
    wmCounter=0;noWMCounter=0;
    for ii = 1:length(origvals);
        if any(origvals(ii) == invals)
            wm.data( wm.data == origvals(ii) ) = 1;
            wmCounter=wmCounter+1;
        else            
            wm.data( wm.data == origvals(ii) ) = 0;
            noWMCounter = noWMCounter + 1;
        end
    end
    fprintf('converted %i regions to White-matter (%i regions left outside of WM)\n\n',wmCounter,noWMCounter);
    niftiWrite(wm);
    
    %convert nifti to mat    
    im=niftiRead(wmMaskFile);
    wmMaskRoiMat = fullfile(matRoiFolder,[wmMaskFileName, '.mat']);
    
    %now we want to convert the image to a list of coordinates in acpc space
    %find roi index locations
    ndx=find(im.data);
    
    %convert to ijk coords 
    [I J K]=ind2sub(size(im.data),ndx);
    
    %convert to acpc coords
    acpcCoords=mrAnatXformCoords(im.qto_xyz, [I J K]);
    
    %now put these coordinates into the mrDiffusion roi structure
    roi=dtiNewRoi(wmMaskRoiMat,'r',acpcCoords);
    
    %save out the roi 
    dtiWriteRoi(roi,wmMaskRoiMat);
    fprintf('\nwriting file %s\n',fullfile(wmMaskRoiMat));
end
end
