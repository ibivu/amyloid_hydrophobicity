# HydrTDependenceAmFibrils
Data and scripts to generate the figures in the manuscript on the hydrophobic
temperature dependence of amyloid fibril formation.

Link to the source code of the model simulations: ......

The figures showing the analysis results of the simulations were generated
with R scripts (version 3.5.2). If you run them, make sure to modify the directory names in
'setDataSources.R'. Also modify the location of the data files ('/path/dataframesEnthaly_....Rdata')
in each of the scripts.

Figure 2a: HeatMap_SA.R
Figure 2b+2c+S2: ManuscriptFiguresSA_ac_b.R
Figure S1: PaggrFiguresSA.R
Figure S3 + S4: SuppFiguresSA.R

The figures showing the analysis results of the experiments were generated
with Python scripts (version 2.7.15). Because for most figures multiple data
files and/or scripts were used, these are organized per folder.

Figure 3a: gamma: ... -> fit_stats_onefig.py
Figure 3b: gamma: plot_gamma.py (takes output from fit_stats_onefig.py as input) + barplot_ASA.py
Figure S5: 
Figure S7: depolymerisation: plot_glu_alac_depol.py
Figure S8a: 
Figure S8b: 