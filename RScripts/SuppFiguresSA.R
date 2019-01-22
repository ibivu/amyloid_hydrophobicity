
# source("PaggrFiguresSA.R")

# required libraries
# install.packages('latex2exp')
library(latex2exp)

# import data processing R functions
# source(paste(sourceDir,"ParseAll.R",sep=""))
# source(paste(sourceDir,"GetEqdHSA.R",sep=""))

source(paste(sourceDir,"setDataSources.R",sep=""))
source(paste(sourceDir,"LoadData.R",sep=""))
source(paste(sourceDir,"TheoryEstimates.R",sep=""))
#load(file=paste(tmpDir,"dataframesEnthaly_Hbonds.Rdata",sep=""))



eSettingsH <-c(
"alpha_0_long_LowT",
"alpha_40_long_LowT_H25",
"alpha_40_long_LowT",
"alpha_40_long_LowT_H75",
"alpha_40_long_LowT_H100",
"alpha_40_long_LowT_H150"
)

eLabelsH <- c(
TeX("$\\alpha = 0, \\epsilon_{hb}=0.5$"),
TeX("$\\alpha = 40, \\epsilon_{hb}=0.25$"),
TeX("$\\alpha = 40, \\epsilon_{hb}=0.5$"),
TeX("$\\alpha = 40, \\epsilon_{hb}=0.75$"),
TeX("$\\alpha = 40, \\epsilon_{hb}=1.00$"),
TeX("$\\alpha = 40, \\epsilon_{hb}=1.50$")
)

## SAVE / RELOAD data
## dfsH = dataLoad(eSettingsH)
## save(dfsH,eSettingsH,eLabelsH,file=paste(tmpDir,"dataframesEnthaly_Hbonds.Rdata",sep=""))
load(file=paste(tmpDir,"dataframesEnthaly_Hbonds.Rdata",sep=""))
##


figureHbond <-function(){
	pdf(paste(figDir,"Hbond_figs.pdf",sep=""),width=8,height=8)

	## layout settings
	layout(matrix(1:4, ncol = 2,nrow=2,byrow=TRUE), widths = c(1,1),
	        heights = c(5,5), respect = FALSE)

	vars = eSettingsH
	picks = c(1,2,3,4,5)
	#picks = 1:length(vars)

	# P_fribril
	plot(0,type='n',xlim=c(0.1,0.6),ylim=c(0,1.0),xlab="temperature (reduced units)",ylab = TeX("$<\\;P_{fibril}\\; > $"),main="(a)")
	for(i in picks){
			ni = vars[i]
			lines(dfsH[[ni]]$temp,dfsH[[ni]]$Pstate2,col=i,lty=2)
			sampled <- dfsH[[ni]]$Gstate2!=Inf
			lines(dfsH[[ni]]$temp[sampled],dfsH[[ni]]$Pstate2[sampled],col=i,lty=1)
	}
	#legend("topright",legend=eLabelsH,col=1:length(vars),lty=1,bty="n",cex=0.5)


	# Free energy
	plot(0,type='n',xlim=c(0.1,0.6),ylim=c(-25,25),xlab="temperature (reduced units)",ylab = TeX("$\\Delta G (kT)$"),main="(b)")
	# zero line
	lines(dfsH[[ni]]$temp,rep(0,length(dfsH[[ni]]$temp)),lty=3,col="grey")
	for(i in picks){
		ni = vars[i]
		ebase = dfsH[[ni]]$Estate2[10] - dfsH[[ni]]$Estate1[10]
		lines(dfsH[[ni]]$temp,dfsH[[ni]]$Gstate2 - dfsH[[ni]]$Gstate1,col=i)
		lines(dfsH[[ni]]$temp,Fhydr(dfsH[[ni]]$temp,alpha=40,Ebase=ebase),lty=2,col=i)
	}
	legend("topleft",legend=eLabelsH[picks],col=picks,lty=1,bty="n")


	# Entropy
	plot(0,type='n',xlim=c(0.1,0.6),ylim=c(-25,25),xlab="temperature (reduced units)",ylab = TeX("$-T\\Delta S (kT)$"),main="(c)")
	# zero line
	lines(dfsH[[ni]]$temp,rep(0,length(dfsH[[ni]]$temp)),lty=3,col="grey")
	for(i in picks){
		ni = vars[i]
		ebase = dfsH[[ni]]$Estate2[10] - dfsH[[ni]]$Estate1[10]
		lines(dfsH[[ni]]$temp,(dfsH[[ni]]$Gstate2 - dfsH[[ni]]$Gstate1) - (dfsH[[ni]]$Estate2 - dfsH[[ni]]$Estate1) ,col=i)
		lines(dfsH[[ni]]$temp,-TdShydr(dfsH[[ni]]$temp,alpha=40,Ebase=ebase),lty=2,col=i)
	}
	#legend("topright",legend=eLabelsH,col=1:length(vars),lty=1,bty="n",cex=0.5)


	# Enthalpy
	plot(0,type='n',xlim=c(0.1,0.6),ylim=c(-50,25),xlab="temperature (reduced units)",ylab = TeX("$\\Delta H (kT)$"),main="(d)")
	# zero line
	lines(dfsH[[ni]]$temp,rep(0,length(dfsH[[ni]]$temp)),lty=3,col="grey")
	for(i in picks){
		ni = vars[i]
		# Index of 10 corresponds to T=0.4 (no T dependence)
		ebase = dfsH[[ni]]$Estate2[10] - dfsH[[ni]]$Estate1[10]
		lines(dfsH[[ni]]$temp,dfsH[[ni]]$Estate2 - dfsH[[ni]]$Estate1,lty=1,col=i)
		lines(dfsH[[ni]]$temp,Ehydr(dfsH[[ni]]$temp,alpha=40,Ebase=ebase),lty=2,col=i)
   }
	#legend("topright",legend=eLabelsH,col=1:length(vars),lty=1,bty="n",cex=0.5)


	dev.off()
}

figureHbond()


eSettingsN <-c(
"alpha_0_long_LowT",
"alpha_0_long_LowT_numStates5",
"alpha_20_long_LowT",
"alpha_20_long_LowT_numStates5",
"alpha_40_long_LowT",
"alpha_40_long_LowT_numStates5",
"alpha_60_long_LowT",
"alpha_60_long_LowT_numStates5"
)

eLabelsN <- c(
TeX("$\\alpha = 0, \\epsilon_{hb}=0.5,N_{\\beta}=0$"),
TeX("$\\alpha = 0, \\epsilon_{hb}=0.5,N_{\\beta}=5$"),
TeX("$\\alpha = 20, \\epsilon_{hb}=0.5,N_{\\beta}=0$"),
TeX("$\\alpha = 20, \\epsilon_{hb}=0.5,N_{\\beta}=5$"),
TeX("$\\alpha = 40, \\epsilon_{hb}=0.5,N_{\\beta}=0$"),
TeX("$\\alpha = 40, \\epsilon_{hb}=0.5,N_{\\beta}=5$"),
TeX("$\\alpha = 60, \\epsilon_{hb}=0.5,N_{\\beta}=0$"),
TeX("$\\alpha = 60, \\epsilon_{hb}=0.5,N_{\\beta}=5$")
)


## SAVE / RELOAD data
## dfsN = dataLoad(eSettingsN)
## save(dfsN,eSettingsN,eLabelsN,file=paste(tmpDir,"dataframesEnthaly_NumStates.Rdata",sep=""))
load(file=paste(tmpDir,"dataframesEnthaly_NumStates.Rdata",sep=""))
##



figureNumStates <-function(){
	pdf(paste(figDir,"NumStates_figs.pdf",sep=""),width=8,height=8)

	## layout settings
	#par(mfrow=c(2,1),mar=c(5,4,2,2)+0.1)
	layout(matrix(1:4, ncol = 2,nrow=2,byrow=TRUE), widths = c(1,1),
	        heights = c(5,5), respect = FALSE)

	vars = eSettingsN
	picks = c(1,5,6)
	#picks = 1:length(vars)

	# P_fribril
	plot(0,type='n',xlim=c(0.1,0.6),ylim=c(0,1.0),xlab="temperature (reduced units)",ylab = TeX("$<\\;P_{fibril}\\; > $"),main="(a)")
	for(i in picks){
			ni = vars[i]
			lines(dfsN[[ni]]$temp,dfsN[[ni]]$Pstate2,col=i,lty=2)
			sampled <- dfsN[[ni]]$Gstate2!=Inf
			lines(dfsN[[ni]]$temp[sampled],dfsN[[ni]]$Pstate2[sampled],col=i,lty=1)
	}

	# Free energy
	plot(0,type='n',xlim=c(0.1,0.6),ylim=c(-25,25),xlab="temperature (reduced units)",ylab = TeX("$\\Delta G (kT)$"),main="(b)")
	# zero line
	lines(dfsN[[ni]]$temp,rep(0,length(dfsN[[ni]]$temp)),lty=3,col="grey")
	for(i in picks){
		ni = vars[i]
		ebase = dfsN[[ni]]$Estate2[10] - dfsN[[ni]]$Estate1[10]
		lines(dfsN[[ni]]$temp,dfsN[[ni]]$Gstate2 - dfsN[[ni]]$Gstate1,col=i)
		lines(dfsN[[ni]]$temp,Fhydr(dfsN[[ni]]$temp,alpha=floor((i-1)/2)*20,Ebase=ebase),lty=2,col=i)
	}
	legend("topleft",legend=eLabelsN[picks],col=picks,lty=1,bty="n")


	# Entropy
	plot(0,type='n',xlim=c(0.1,0.6),ylim=c(-25,25),xlab="temperature (reduced units)",ylab = TeX("$-T\\Delta S (kT)$"),main="(c)")
	# zero line
	lines(dfsN[[ni]]$temp,rep(0,length(dfsN[[ni]]$temp)),lty=3,col="grey")
	for(i in picks){
		ni = vars[i]
		ebase = dfsN[[ni]]$Estate2[10] - dfsN[[ni]]$Estate1[10]
		lines(dfsN[[ni]]$temp,(dfsN[[ni]]$Gstate2 - dfsN[[ni]]$Gstate1) - (dfsN[[ni]]$Estate2 - dfsN[[ni]]$Estate1) ,col=i)
		lines(dfsN[[ni]]$temp,-TdShydr(dfsN[[ni]]$temp,alpha=floor((i-1)/2)*20,Ebase=ebase),lty=2,col=i)
	}
	#legend("topright",legend=eLabelsN,col=1:length(vars),lty=1,bty="n",cex=0.5)


	# Enthalpy
	plot(0,type='n',xlim=c(0.1,0.6),ylim=c(-50,25),xlab="temperature (reduced units)",ylab = TeX("$\\Delta H (kT)$"),main="(d)")
	# zero line
	lines(dfsN[[ni]]$temp,rep(0,length(dfsN[[ni]]$temp)),lty=3,col="grey")
	for(i in picks){
		ni = vars[i]
		# Index of 10 corresponds to T=0.4 (no T dependence)
		ebase = dfsN[[ni]]$Estate2[10] - dfsN[[ni]]$Estate1[10]
		lines(dfsN[[ni]]$temp,dfsN[[ni]]$Estate2 - dfsN[[ni]]$Estate1,lty=1,col=i)
		lines(dfsN[[ni]]$temp,Ehydr(dfsN[[ni]]$temp,alpha=floor((i-1)/2)*20,Ebase=ebase),lty=2,col=i)
   }
	#legend("topright",legend=eLabelsN,col=1:length(vars),lty=1,bty="n",cex=0.5)


	dev.off()
}

figureNumStates()
