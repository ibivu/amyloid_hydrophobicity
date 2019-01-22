
# source("setDataSources.R")

# set directory names
#sourceDir <- "/Users/sanneabeln/GoogleDrive2/Papers/ErikAggregation2016/RCODE_FIGS/"
#dataDir <- "/Volumes/WDMacSA/AggregationSimulations"
#dataDir <- "/home2/DataErik/"
#figDir <- "/Users/sanneabeln/GoogleDrive2/Papers/ErikAggregation2016/Figures/"

#VM
dataDir <- "/DataErik/AggregationSimulations/"
sourceDir <- "/surfdrive/fibrilhydrophobicityall_juami/"
figDir <- "/surfdrive/FiguresVM_Juami/"
tmpDir <- "/surfdrive/temp/"

# required libraries
# install.packages('latex2exp')
library(latex2exp)

# import data processing R functions
# source(paste(sourceDir,"ParseAll.R",sep=""))
# source(paste(sourceDir,"GetEqdHSA.R",sep=""))
source(paste(sourceDir,"LoadData.R",sep=""))
source(paste(sourceDir,"TheoryEstimates.R",sep=""))


# DEFINE settings and corresponding labels
eSettings <-c(
						"alpha_0_long_LowT_H25",
						"alpha_0_long_LowT_H25_Leu", # something wrong? probably H75
						"alpha_0_long_LowT",
						"alpha_0_long_LowT_Leu",
						"alpha_0_long_LowT_H75",

						"alpha_20_long_LowT_H25",
						"alpha_20_long_LowT_H25_Leu",
						"alpha_20_long_LowT",
						"alpha_20_long_LowT_Leu",
						"alpha_20_long_LowT_H75",

						"alpha_40_long_LowT_H25",
						"alpha_40_long_LowT_H25_Leu",
						"alpha_40_long_LowT",
						"alpha_40_long_LowT_Leu",
						"alpha_40_long_LowT_H75",

						"alpha_60_long_LowT_H25",
						"alpha_60_long_LowT_H25_Leu",
						"alpha_60_long_LowT",
						"alpha_60_long_LowT_Leu",
						"alpha_60_long_LowT_H75"
						)


eLabels <- c(
				TeX("$\\alpha = 0, \\epsilon_{h,b}=0.25$"),
				TeX("$\\alpha = 0, \\epsilon_{h,b}=0.25$, Leu"),
				TeX("$\\alpha = 0, \\epsilon_{h,b}=0.5$"),
				TeX("$\\alpha = 0, \\epsilon_{h,b}=0.5$, Leu"),
				TeX("$\\alpha = 0, \\epsilon_{h,b}=0.75$"),

				TeX("$\\alpha = 20, \\epsilon_{h,b}=0.25$"),
				TeX("$\\alpha = 20, \\epsilon_{h,b}=0.25$, Leu"),
				TeX("$\\alpha = 20, \\epsilon_{h,b}=0.5$"),
				TeX("$\\alpha = 20, \\epsilon_{h,b}=0.5$, Leu"),
				TeX("$\\alpha = 20, \\epsilon_{h,b}=0.75$"),

				TeX("$\\alpha = 40, \\epsilon_{h,b}=0.25$"),
				TeX("$\\alpha = 40, \\epsilon_{h,b}=0.25$, Leu"),
				TeX("$\\alpha = 40, \\epsilon_{h,b}=0.5$"),
				TeX("$\\alpha = 40, \\epsilon_{h,b}=0.5$, Leu"),
				TeX("$\\alpha = 40, \\epsilon_{h,b}=0.75$"),

				TeX("$\\alpha = 60, \\epsilon_{h,b}=0.25$"),
				TeX("$\\alpha = 60, \\epsilon_{h,b}=0.25$, Leu"),
				TeX("$\\alpha = 60, \\epsilon_{h,b}=0.5$"),
				TeX("$\\alpha = 60, \\epsilon_{h,b}=0.5$, Leu"),
				TeX("$\\alpha = 60, \\epsilon_{h,b}=0.75$")
				)

eLabels2 <- c(
								TeX("$\\alpha = 0, \\epsilon_{h,b}=0.25$"),
								TeX("$\\alpha = 0, \\epsilon_{h,b}=0.25$, Leu"),
								TeX("$\\alpha = 0$"),
								TeX("$\\alpha = 0, Leu"),
								TeX("$\\alpha = 0, \\epsilon_{h,b}=0.75$"),

								TeX("$\\alpha = 20, \\epsilon_{h,b}=0.25$"),
								TeX("$\\alpha = 20, \\epsilon_{h,b}=0.25$, Leu"),
								TeX("$\\alpha = 20$"),
								TeX("$\\alpha = 20, Leu"),
								TeX("$\\alpha = 20, \\epsilon_{h,b}=0.75$"),

								TeX("$\\alpha = 40, \\epsilon_{h,b}=0.25$"),
								TeX("$\\alpha = 40, \\epsilon_{h,b}=0.25$, Leu"),
								TeX("$\\alpha = 40$"),
								TeX("$\\alpha = 40, Leu"),
								TeX("$\\alpha = 40, \\epsilon_{h,b}=0.75$"),

								TeX("$\\alpha = 60, \\epsilon_{h,b}=0.25$"),
								TeX("$\\alpha = 60, \\epsilon_{h,b}=0.25$, Leu"),
								TeX("$\\alpha = 60"),
								TeX("$\\alpha = 60, Leu"),
								TeX("$\\alpha = 60, \\epsilon_{h,b}=0.75$")
					)


# Test
# eSettings <-c("alpha_20_long_LowT_H25")
# eLabels <- c(	TeX("$\\alpha = 20, \\epsilon_{h,b}=0.25$"))
# or
# eSettings <-c("alpha_20_long_LowT","alpha_40_long_LowT")
# eLabels <- c(TeX("$\\alpha = 20, \\epsilon_{h,b}=0.5$"),	TeX("$\\alpha = 40, \\epsilon_{h,b}=0.5$"))
# or
# eSettings <-c("alpha_0_long_LowT","alpha_20_long_LowT","alpha_40_long_LowT","alpha_60_long_LowT")
# eLabels <- c(TeX("$\\alpha = 0, \\epsilon_{h,b}=0.5$"),TeX("$\\alpha = 20, \\epsilon_{h,b}=0.5$"),	TeX("$\\alpha = 40, \\epsilon_{h,b}=0.5$"),	TeX("$\\alpha = 60, \\epsilon_{h,b}=0.5$"))


## SAVE / RELOAD data
## dfs = dataLoad(eSettings)
## save(dfs,eSettings,eLabels,file=paste(tmpDir,"dataframesAll1.Rdata",sep=""))
## load(file=paste(tmpDir,"dataframesAll1.Rdata",sep=""))
##

# DATA set FLANKS
# this is possibly not correct need to check configs
# eSettings <-c("alpha_0_long_LowT_flankT","alpha_60_long_LowT_flankT")
# eLabels <- c(TeX("$\\alpha = 0, \\epsilon_{h,b}=0.5 flank$"),TeX("$\\alpha = 60, \\epsilon_{h,b}=0.5 flank$"))
## dflanks = dataLoad(eSettings)
## save(dflanks,eSettings,eLabels,file=paste(tmpDir,"dataframesFlanks.Rdata",sep=""))
## load(file=paste(tmpDir,"dataframesFlanks.Rdata",sep=""))
