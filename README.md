# spantracts

This repository contains scripts to track fibers from the anterior insula to nucleus accumbens. Each matlab script is well commented, but for questions email josiah@stanford.edu

<b>Instructions: </b></br>
(1) Setup computing environment </br>
(2) Setup directory structure </br>
(3) AcPc-align T1 data </br>
(4) Perform FreeSurfer on AcPc T1 </br>
(5) Preprocess DWI data </br>
(6) Extract FreeSurfer ROIs </br>
(7) Perform MRtrix tractography </br>
(8) Visualize fibers and clean outliers </br>
(9) Extract diffusion tensor metrics along fibers </br>

<b>(1) Setup computing environment </b></br>
We rely on several software suites: </br> 
<a href="https://github.com/vistalab/vistasoft">VISTASOFT</a></br>
<a href="https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall">Freesurfer </a></br>
<a href="http://jdtournier.github.io/mrtrix-0.2/">MRtrix 0.2</a></br>
<a href="http://web.stanford.edu/group/vista/cgi-bin/wiki/index.php/MrDiffusion">Helpful instructions</a></br>

<b>(2) Setup directory structure </b></br>
subject </br>
&nbsp;&nbsp;&nbsp;&nbsp;subject_t1.nii.gz</br>
&nbsp;&nbsp;&nbsp;&nbsp;raw </br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;subject.nii.gz </br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;subject.bvec </br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;subject.bval </br>

<b>(3) AcPc-align T1-weighted data </b></br>
Run mrAnatAverageAcpcNifti.m in matlab. You will be prompted to load the T1 data (subject_t1.nii.gz), and then to set the output filename (subject_t1_acpc.nii.gz). </br>
Use GUI to set the anterior commissure, posterior commissure, and a midsagittal point high (superior) in the brain. </br>

<b>(4) Start FreeSurfer on AcPc T1</b></br>
Set freesurfer environment and run in command line:</br>
recon-all -all -3T -s subject -i subject_t1_acpc.nii.gz

<b>(5) Preprocess DWI data</b></br>
Run s_dtiInit.m

<b>(6) Extract FreeSurfer ROIs</b></br>
(i) Convert freesurfer segmentation from freesurfer space to acpc space:</br>
Command line: mri_convert -rl rawavg.mgz -rt nearest -odt int aparc.a2009s+aseg.mgz a2009seg2acpc.nii.gz</br>
(ii) Copy a2009seg2acpc.nii.gz to /subject/ROIs </br>
(iii) Extract mat ROIs from freesurfer. Run s_dtiConvFSroi2mat.m </br>
(iv) Create white matter mask. Run s_make_wmmask_fsseg_rh.m and s_make_wmmask_fsseg_lh.m </br>
(v) Smooth and dilate ROIs. Run s_make_and_smooth_roi.m </br>
(vi) Combine anterior and short gyrus of insula ROIs. Run s_merge_insula_rois.m </br>

<b>(7) Perform MRtrix tractography</b>
Run s_mrtrix_track_ains_nacc </br>

<b>(8) Visualize fibers and clean outliers</b></br>
(i) Use mrDiffusion in matlab to visualize fibers over T1. Check for abnormal fibers (e.g., fibers that cross hemispheres, or cross cerebrospinal fluid).</br>
(ii) Exclude outlier fibers with quantitative criteria (i.e., length and mahalanobis distance). Run s_clean_mbafiberoutlier_ains_nacc.m

<b>(9) Extract diffusion tensor metrics along fibers</b></br>
Run s_mrtrix_tractprofiles_ainsnacc.m
