# HydrTDependenceAmFibrils
Data and scripts to generate the figures in the manuscript on the hydrophobic
temperature dependence of amyloid fibril formation.

## Code for the simulation
Link to the source code of the model simulations: https://bitbucket.org/abeln/amyloid_hydrophobe/src/master/



## Scripts and data for simulation nalysis
The figures showing the analysis results of the simulations were generated
with R scripts (version 3.5.2). If you run them, make sure to modify the directory names in
'setDataSources.R'. Also modify the location of the data files ('/path/dataframesEnthaly_....Rdata')
in each of the scripts.

* Figure 2a: HeatMap_SA.R
* Figure 2b+2c+S2: ManuscriptFiguresSA_ac_b.R
* Figure S1: PaggrFiguresSA.R
* Figure S3 + S4: SuppFiguresSA.R

The figures showing the analysis results of the experiments were generated
with Python scripts (version 2.7.15). Because for most figures multiple data
files and/or scripts were used, these are organized per folder.

<<<<<<< HEAD
Figure 3a: gamma: calculate_ASA.py -> fit_stats_onefig.py
Figure 3b: gamma: plot_gamma.py (takes output from fit_stats_onefig.py as input) + barplot_ASA.py
Figure S5: ITC_asyn_mf_raw: plot_ITC_raw_data.py
Figure S7: depolymerisation: plot_glu_alac_depol.py
Figure S8: GNNQQNY: plot_gnnqqny.py
=======
* Figure 3a: gamma: calculate_ASA.py -> fit_stats_onefig.py
* Figure 3b: gamma: plot_gamma.py (takes output from fit_stats_onefig.py as input) + barplot_ASA.py
* Figure S5: ITC_asyn_mf_raw: plot_ITC_raw_data.py
* Figure S7: depolymerisation: plot_glu_alac_depol.py
* Figure S8: GNNQQNY: plot_gnnqqny.py

## Experimental Data
>>>>>>> b43a097bc85354ff99f0661b9415381659560c0b
