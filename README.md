# spantracts

This repository contains scripts to track fibers from the anterior insula to nucleus accumbens. Each matlab script is well commented, but feel free to email josiah@stanford.edu with questions.

<b>Workflow: </b></br>
(1) Set up computing environment </br>
(2) Set up directory structure </br>
(3) Align T1-weighted anatomy to ACPC </br>
(4) Run FreeSurfer on the ACPC-ed T1 </br>
(5) Preprocess diffusion data </br>
(6) Extract FreeSurfer ROIs </br>
(7) Run MRtrix tractography </br>
(8) Visualize fibers and clean outliers </br>
(9) Extract diffusion tensor metrics along fibers </br>

<b>(1) Set up computing environment </b></br>
We rely on several software suites: </br> 
<a href="https://github.com/vistalab/vistasoft">VISTASOFT</a></br>
<a href="https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall">FreeSurfer </a></br>
<a href="http://jdtournier.github.io/mrtrix-0.2/">MRtrix 0.2</a></br>
<a href="http://web.stanford.edu/group/vista/cgi-bin/wiki/index.php/MrDiffusion">Helpful instruction</a></br>

and matlab packages: </br>
<a href="https://github.com/francopestilli/mba">Matlab Brain Anatomy</a></br>
<a href="https://github.com/vistalab/knkutils">knkutils</a></br>
<a href="http://www.fil.ion.ucl.ac.uk/spm/software/spm8/">SPM8</a></br>

<b>(2) Set up directory structure </b></br>
subject </br>
&nbsp;&nbsp;&nbsp;&nbsp;subject_t1.nii.gz</br>
&nbsp;&nbsp;&nbsp;&nbsp;raw </br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;subject.nii.gz </br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;subject.bvec </br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;subject.bval </br>

<b>(3) Align T1-weighted anatomy to ACPC </b></br>
Run mrAnatAverageAcpcNifti.m in matlab. You will be prompted to load the T1 data (subject_t1.nii.gz), and then to set the output filename (subject_t1_acpc.nii.gz). </br>
Use GUI to set the anterior commissure, posterior commissure, and a midsagittal point high (superior) in the brain. </br>

<b>(4) Run FreeSurfer on the ACPC-ed T1</b></br>
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

<b>(7) Run MRtrix tractography</b></br>
Run s_mrtrix_track_ains_nacc </br>

<b>(8) Visualize fibers and clean outliers</b></br>
(i) Use mrDiffusion in matlab to visualize fibers on the T1. Check for abnormal fibers (e.g., fibers that cross hemispheres, or enter cerebrospinal fluid).</br>
(ii) Exclude outlier fibers based on quantitative criteria (i.e., length and mahalanobis distance). Run s_clean_mbafiberoutlier_ains_nacc.m

<b>(9) Extract diffusion tensor metrics along fiber</b></br>
Create csv with tract data for further analysis. Run s_mrtrix_tractprofiles_ainsnacc.m


# ===== Use ConTrack to track MPFC-NAcc and VTA-NAcc ===== #
Workflow:
(1-5) Same as above.

(6) Define ROIs
NAcc: use ROI from FreeSurfer, described above.
MPFC: use mrDiffusion to manually place spherical ROI (5 mm diameter) in each hemisphere. Second gyrus in from front of the brain, and axially at the level of the genu of the corpus callosum.
VTA: Use mrDiffusion to manually place spherical ROI (or consult Kelly Hennigan for automated method).

(7) Perform ConTrack
(i) Run tractography
Run ctrBatchCreateContrackFiles.m, with parameters set to include your subject names, ROIs, number of fibers, max/min fiber length. This creates:
(a) a shell script in each subject folder with command line code to run contrack.
(b) one shell script that includes a line for each subject, which simply goes into subject directory to run subject level script above.

(ii) Either run the script from (ib), or run the script for each subject from (ia).

(iii) Score top fibers
Run ctrBatchScore.m, which will ask for .mat file created in (7i). This will create:
(a) a shell script in each subject folder with command line code to score fibers.
(b) one shell script that includes a line for each subject, which simply goes into subject directory to run the subject level scoring script above.

(iv) Either run the script from (iiib), or run the script for each subject from (iiia).

(8-9) Same as above.
