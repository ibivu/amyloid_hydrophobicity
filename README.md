# HydrTDependenceAmFibrils
Data and scripts to generate the figures in the manuscript on the hydrophobic
temperature dependence of amyloid fibril formation.

## Code for the simulation
Link to the source code of the model simulations: https://bitbucket.org/abeln/amyloid_hydrophobe/src/master/


## Scripts and data for simulation analysis
The figures showing the analysis results of the simulations were generated
with R scripts (version 3.5.2). If you run them, make sure to modify the directory names in
'setDataSources.R'. Also modify the location of the data files ('/path/dataframesEnthaly_....Rdata')
in each of the scripts.

* Figure 3: ManuscriptFiguresSA_ac_b.R
* Figure 4: HeatMap_SA.R
* Figure S1: PaggrFiguresSA.R
* Figure S2 + S3: SuppFiguresSA.R

## Scripts and data for experimental analysis
The figures showing the analysis results of the experiments were generated
with Python scripts (version 2.7.15). Because for most figures multiple data
files and/or scripts were used, these are organized per folder.

* Figure 5a: gamma: calculate_ASA.py -> fit_stats_onefig.py
* Figure 5b: gamma: plot_gamma.py (takes output from fit_stats_onefig.py as input) + barplot_ASA.py
* Figure 6: ionic_strength: ions_urea.py
* Figure S4: ITC_asyn_mf_raw: plot_ITC_raw_data.py
* Figure S6: depolymerisation: plot_glu_alac_depol.py
* Figure S7: GNNQQNY: plot_gnnqqny.py
* Figure S8: fluorescence: plot_fluorescence_spectra.py
* Figure S9: equilibration: fitting_g_340_330.py