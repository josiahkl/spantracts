# spantracts

This repository contains scripts to track fibers from the anterior insula to nucleus accumbens.

Instructions: </br>
1) Setup computing environment </br>
2) Setup directory structure </br>
3) AcPc-align T1-weighted data </br>
4) Start Freesurfer on AcPc T1 </br>
5) Preprocess DWI data </br>
6) Extract Freesurfer ROIs </br>
7) Perform MRTrix tractography </br>
8) Visualize fibers and clean outliers </br>
9) Extract diffusion tensor metrics along fibers </br>

(1) Setup computing environment </br>
We rely on several software suites: </br> 
VISTASOFT repository https://github.com/vistalab/vistasoft </br>
FreeSurfer https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall </br>
MRtrix 0.2 http://jdtournier.github.io/mrtrix-0.2/ </br>
Helpful instructions here: http://web.stanford.edu/group/vista/cgi-bin/wiki/index.php/MrDiffusion

(2) Setup directory structure </br>
subject
  subject_t1.nii.gz
  raw
    subject.nii.gz
    subject.bvec
    subject.bval

(3) AcPc-align T1-weighted data </br>
Run mrAnatAverageAcpcNifti in matlab. You will be prompted to load the T1 data (subject_t1.nii.gz), and then to define the output filename (subject_t1_acpc.nii.gz). </br>
Use GUI to set the anterior commissure, posterior commissure, and midsagittal point high (superior) in the brain. </br>


