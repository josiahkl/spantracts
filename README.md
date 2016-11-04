# spantracts

This repository contains scripts to track fibers from the anterior insula to nucleus accumbens.

<b>Instructions: </b></br>
1) Setup computing environment </br>
2) Setup directory structure </br>
3) AcPc-align T1-weighted data </br>
4) Start FreeSurfer on AcPc T1 </br>
5) Preprocess DWI data </br>
6) Extract FreeSurfer ROIs </br>
7) Perform MRTrix tractography </br>
8) Visualize fibers and clean outliers </br>
9) Extract diffusion tensor metrics along fibers </br>

<b>(1) Setup computing environment </b></br>
We rely on several software suites: </br> 
<a href="https://github.com/vistalab/vistasoft">VISTASOFT</a></br>
<a href="https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall">Freesurfer </a></br>
<a href="http://jdtournier.github.io/mrtrix-0.2/">MRtrix 0.2</a></br>
<a href="http://web.stanford.edu/group/vista/cgi-bin/wiki/index.php/MrDiffusion">Helpful instructions</a></br>

<b>(2) Setup directory structure </b></br>
subject </br>
    subject_t1.nii.gz </br>
    raw </br>
      subject.nii.gz </br>
      subject.bvec </br>
      subject.bval </br>

<b>(3) AcPc-align T1-weighted data </b></br>
Run mrAnatAverageAcpcNifti in matlab. You will be prompted to load the T1 data (subject_t1.nii.gz), and then to define the output filename (subject_t1_acpc.nii.gz). </br>
Use GUI to set the anterior commissure, posterior commissure, and midsagittal point high (superior) in the brain. </br>

<b>(4) Start FreeSurfer on AcPc T1</b>

<b>(5) Preprocess DWI data</b></br>
Run s_dtiInit.m

<b>(6) Extract FreeSurfer ROIs</b></br>
