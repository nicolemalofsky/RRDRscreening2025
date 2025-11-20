# RRDRscreening2025

Part 1: Overview of all files included in this repository and their organization into subfolders. 
Part 1: "How-to" guide for applying the post-processing baseline subtraction code for external research use. 

------------------------------------------------------------------------------------------------------

-- Part 1 -- Overview of all files included in this repository and their organization into subfolders: 

Research data with associated data analysis, figures, and tables for this report are divided into subfolders related to either the "Main Report", "Supporting Information", or features "All-Encompassing" information. One additional subfolder titled "Generalized Post-processing Baseline Subtraction Codes" includes the two generalized codes required for post-processing QuantStudio 5 SSMA melt data for baseline subtraction and Tm calling along with a compatible demo .xlsx data file.

There are three "Main Report" folders:

(1) The three folders "Main Report - RRDR SSMA Assay Data Repository Part 1 of 3", (2) "Main Report - RRDR SSMA Assay Data Repository Part 2 of 3", and (3) "Main Report - RRDR SSMA Assay Data Repository Part 3 of 3" together include all raw data files, analyzed data files, experimental protocol sheets, instrument run files, and post-processing baseline subtraction codes associated with data collection for the RRDR SSMA diagnostic using the QuantStudio 5 real-time PCR instrument. The aforementioned data is sorted into subfolders for each independent experiment contributing to (i) N=5 independent experiments in triplicate per sample type at 2E6 copies per reaction; and (ii) N=2 independent experiments in triplicate per sample type at 2E5, 2E4, 2E3. 2E1, 2E0 copies per reaction.

There are two "Supporting Information" folders:

(1) "Supporting Information - Data Repository - Part 1 of 2" includes all raw data files, analyzed data files, experimental protocol sheets, instrument run files, and post-processing baseline subtraction codes associated with data collection for (i) the supplemental optimization of LCGreen Plus intercalating dye concentration (N=1 independent experiments on the QuantStudio 5); and (ii) the supplemental characterization of increased salt concentration on duplex melting profiles ( N=1 independent experiments on the QuantStudio 5). 

(2) "Supporting Information - Data Repository - Part 2 of 2" includes all raw data files, analyzed data files, experimental protocol sheets, instrument run files, and post-processing baseline subtraction codes associated with data collection for (i) the supplemental optimization of PCR annealing temperature (N=1 independent experiments on the QuantStudio 5); and (ii) the supplemental optimization of segment 1 melt probe duplex Tm ( N=1 independent experiments on the QuantStudio 5). 

There are two "All-Encompassing" folders:

(1) "All-Encompassing - Figures' includes all image files for the figures included in the report.

(2) "All-Encompassing - Prism File for Data Analysis, Statistics, Figure Making" includes the Prism program file used to perform statistical data analysis and make figures included in the report.


------------------------------------------------------------------------------------------------------

-- Part 2 -- "How-to" guide for applying the post-processing baseline subtraction code for external research use: 

The subfolder titled "Generalized Post-processing Baseline Subtraction Codes" includes the two generalized codes required for post-processing QuantStudio 5 SSMA melt data for baseline subtraction and Tm calling. While the "GrabChannel.m" file will not be adjusted, the "backgroundsubtractionver2_ExptXXXyear_mo_day.m" file must be edited with every new run file. The subfolder "Generalized Post-processing Baseline Subtraction Codes" also includes a compatible demo .xlsx data file from SSMA, "2025-04-22 Expt 65 modified asym pcr and melt_20250423_120943.xlsx", that can also be found in "Expt 65" within "Main Report - RRDR SSMA Assay Data Repository - Part 1 of 3". 

Follow the steps outlined below to post-process QuantStudio 5 SSMA melt data files for baseline subtraction and Tm calling. 

(1) Open "GrabChannel.m" and "backgroundsubtractionver2_ExptXXXyear_mo_day.m" in MATLAB, having the two files open simultaneously in separate MATLAB windows. (Note: this report was performed using MATLAB_R2024b). Save these files to a new folder designated for your experiment of interest. In MATLAB, navigate your "Current Folder" pane to the new experiment folder you just created. 
(2) Open your QuantStudio 5 ".eds" run file using the Design & Analysis Software. (Note: this report was performed using Design & Analysis 2.8.0). Click "Analyze" to analyze your .eds run file. Export your analyzed data by clicking "Actions > Export...". Under "Browse", select the new experiment folder created in step (1). Check the box for "Combined all export tables in one file". Click "Export". 
(3) Find your newly exported ".xlsx" file and copy the file name to your clipboard. Paste the file name into line 3 of the "backgroundsubtractionver2_ExptXXXyear_mo_day.m" file open in MATLAB. Note that the generalized run file is currently compatible with "Expt 65" within the "Main Report - RRDR SSMA Assay Data Repository - Part 1 of 3". This means that the QuantStudio-analzyed run file being uploaded in line 3 of the demo code is "2025-04-22 Expt 65 modified asym pcr and melt_20250423_120943.xlsx". An easy mistake is to accidentally double paste or completely forget the ".xlsx" - so double check this! 
(3) With the "backgroundsubtractionver2_ExptXXXyear_mo_day.m" file open in MATLAB, click "Save" then "Run" to run the code. A new ".xlsx" file will be populated in the experiment folder created in step (1) - the file will have "Background subtracted " added to the front of your uploaded ".xlsx" file name. For the demo run file mentioned in step (3), the exported file will be called "Background subtracted 2025-04-22 Expt 65 modified asym pcr and melt_20250423_120943.xlsx". 
(4) Open the new background-subtracted ".xlsx" file. The document will have 2 tabs. The first tab (Sheet 1) includes the baseline-subtracted derivative melt data for each sample (each well) in pairwise columns of temperature (ºC) and -dF/dT, where row 1 is the sample's "Target" name from the ".eds" file and row 2 is the sample's well number from the ".eds" file. The second tab (Sheet 2) includes the Tm values obtained from the baseline-corrected derivative data with one sample (well) per column, where row 1 is the sample's "Target" name from the ".eds" file, row 2 is the sample's well number from the ".eds" file, and rows 3+ are the Tm values reported for that sample. Tm values of "0" are simply placeholders in the reporting sheet and should not be interpreted as Tm values. 

