# span tracts

This repository has scripts to track fibers between the anterior insula and nucleus accumbens (NAcc).  Each matlab script is commented, but feel free to email josiah@stanford.edu with questions. Instructions to track MPFC-NAcc and VTA-NAcc fibers are also below.

<b>Workflow: </b></br>
(1) Set up computing environment </br>
(2) Set up directory structure </br>
(3) Align T1 anatomical scan to AC/PC space </br>
(4) Run FreeSurfer on the T1 scan </br>
(5) Preprocess diffusion data </br>
(6) Extract FreeSurfer ROIs </br>
(7) Perform MRtrix tractography </br>
(8) Visualize fibers and clean outliers </br>
(9) Extract diffusion measures along the fibers </br>

<b>(1) Set up computing environment </b></br>
We rely on these software: </br> 
<a href="https://github.com/vistalab/vistasoft">VISTASOFT</a></br>
<a href="https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall">FreeSurfer </a></br>
<a href="http://jdtournier.github.io/mrtrix-0.2/">MRtrix 0.2</a></br>
<a href="http://web.stanford.edu/group/vista/cgi-bin/wiki/index.php/MrDiffusion">Helpful instruction</a></br>

and matlab packages: </br>
<a href="https://github.com/francopestilli/mba">Matlab Brain Anatomy</a></br>
<a href="https://github.com/vistalab/knkutils">knkutils</a></br>
<a href="http://www.fil.ion.ucl.ac.uk/spm/software/spm8/">SPM8</a></br>

<b>(2) Set up directory structure </b></br>
subject/ </br>
&nbsp;&nbsp;&nbsp;&nbsp;subject_t1.nii.gz</br>
&nbsp;&nbsp;&nbsp;&nbsp;raw/ </br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;subject.nii.gz </br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;subject.bvec </br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;subject.bval </br>

<b>(3) Align T1 anatomical scan to AC/PC space </b></br>
Run mrAnatAverageAcpcNifti.m in matlab. You will be prompted to load the T1 data (subject_t1.nii.gz), and then to set the output filename (subject_t1_acpc.nii.gz). </br>
Use GUI to set the anterior commissure, posterior commissure, and a midsagittal point high (superior) in the brain. </br>

<b>(4) Run FreeSurfer on the T1 scan</b></br>
Set freesurfer environment, then run in command line: recon-all -all -s subject -i subject_t1_acpc.nii.gz

<b>(5) Preprocess diffusion data</b></br>
Run s_dtiInit.m

<b>(6) Extract FreeSurfer ROIs</b></br>
(i) Convert brain segmentation from freesurfer space to acpc space:</br>
Run in command line: mri_convert -rl rawavg.mgz -rt nearest -odt int aparc.a2009s+aseg.mgz a2009seg2acpc.nii.gz</br>
(ii) Copy a2009seg2acpc.nii.gz to /subject/ROIs </br>
(iii) Extract relevant ROIs. Run s_dtiConvFSroi2mat.m </br>
(iv) Create white matter mask. Run s_make_wmmask_fsseg_rh.m and s_make_wmmask_fsseg_lh.m </br>
(v) Smooth ROIs. Run s_make_and_smooth_roi.m </br>
(vi) Combine anterior and short gyrus insula ROIs. Run s_merge_insula_rois.m </br>

<b>(7) Perform MRtrix tractography</b></br>
Run s_mrtrix_track_ains_nacc </br>

<b>(8) Visualize fibers and clean outliers</b></br>
(i) Use mrDiffusion in matlab to visualize fibers on the T1. Check for abnormal fibers (e.g., cross hemispheres, enter cerebrospinal fluid, loop in many directions).</br>
(ii) Exclude outlier fibers based on quantitative criteria (i.e., length and mahalanobis distance). Run s_clean_mbafiberoutlier_ains_nacc.m

<b>(9) Extract diffusion measures along the fibers</b></br>
Create csv with tract data for further analysis. Run s_mrtrix_tractprofiles_ainsnacc.m


# Use ConTrack to track MPFC-NAcc and VTA-NAcc

<b>(1-5) Same as above</b></br>

<b>(6) Define ROIs</b></br>
NAcc: use ROI from FreeSurfer, same as above.</br>
MPFC: use mrDiffusion to manually place spherical ROI (5 mm diameter) in each hemisphere. Coronally, identify the second gyrus in from the front of the brain, and axially at the level of the genu of the corpus callosum.</br>
VTA: use mrDiffusion to manually place spherical ROI (or consult Kelly Hennigan for automatic method).</br>

<b>(7) Perform ConTrack tractography</b></br>
(i) Track fibers</br>
Run ctrBatchCreateContrackFiles.m, with parameters set to include your subject names, ROIs, number of fibers, max/min fiber length, etc. This creates:</br>
(a) a shell script in each subject folder with command line code to track fibers.</br>
(b) one shell script that includes command line code for each subject, which simply goes into the subject folder to run the script from 7ia.</br>

(ii) Either run the script for each subject from step 7ia, or run the script from step 7ib.</br>

(iii) Score top fibers</br>
Run ctrBatchScore.m, which will ask for .mat file created in (7). This creates:</br>
(a) a shell script in each subject folder with command line code to score fibers.</br>
(b) one shell script that includes command line code for each subject, which simply goes into the subject folder to run the scoring script in step 7iiia.</br>

(iv) Either run the script for each subject from step 7iiia, or run the script from 7iiib.</br>

<b>(8-9) Same as above</b></br>
