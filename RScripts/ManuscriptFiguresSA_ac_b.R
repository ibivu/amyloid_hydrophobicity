
# source("ManuscriptFiguresSA.R")

# required libraries
# install.packages('latex2exp')
library(latex2exp)

# import data processing R functions
# source(paste(sourceDir,"ParseAll.R",sep=""))
# source(paste(sourceDir,"GetEqdHSA.R",sep=""))

source(paste(sourceDir,"setDataSources.R",sep=""))
source(paste(sourceDir,"LoadData.R",sep=""))
source(paste(sourceDir,"TheoryEstimates.R",sep=""))


#Test
#eSettings <-c("alpha_0_long_LowT_H25")
#eLabels <- c(	TeX("$\\alpha = 0, \\epsilon_{h,b}=0.25$"))


## SAVE / RELOAD data
## dfs = dataLoad(eSettings)
## save(dfs,eSettings,eLabels,file=paste(tmpDir,"dataframesEnthaly3.Rdata",sep=""))
## load(file=paste(tmpDir,"dataframesEnthaly3.Rdata",sep=""))
##

# Generate figures
figureEnthalpyAll <- function(){
  pdf(paste(figDir,"enthalpy_all.pdf",sep=""))
  plot(0,type='n',xlim=c(0.1,0.6),ylim=c(-50,25),xlab="temperature (reduced units)",ylab = TeX("$\\Delta H (kT)$"))
  for(i in 1:length(eSettings)){
    ni = eSettings[i]
    lines(dfs[[ni]]$temp,dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1,lty=1,col=i)
    #lines(dfs[[ni]]$temp,Ehydr(dfs[[ni]]$temp,alpha=0,Ebase=-18),lty=2,col=i)
  }
  legend("topright",eLabels,col=1:length(eSettings),lty=1)
  dev.off()
}


figureEnthalpyFit <-function(){
  pdf(paste(figDir,"enthalpy_fits.pdf",sep=""))
  labels <- c()
  plot(0,type='n',xlim=c(0.1,0.6),ylim=c(-50,25),xlab="temperature (reduced units)",ylab = TeX("$\\Delta H (kT)$"))
  
  ni <- "alpha_0_long_LowT"
  labels <- append(labels,eLabels[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1,lty=1,col=1)
  lines(dfs[[ni]]$temp,Ehydr(dfs[[ni]]$temp,alpha=0,Ebase=-16.3),lty=2,col=1)
  
  ni <- "alpha_20_long_LowT"
  labels <- append(labels,eLabels[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1,lty=1,col=2)
  lines(dfs[[ni]]$temp,Ehydr(dfs[[ni]]$temp,alpha=20,Ebase=-16.3),lty=2,col=2)
  points(TE0estimate(alpha=20,Ebase=16.3),0,pch=8,col=2)
  
  ni <- "alpha_40_long_LowT"
  labels <- append(labels,eLabels[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1,lty=1,col=3)
  lines(dfs[[ni]]$temp,Ehydr(dfs[[ni]]$temp,alpha=40,Ebase=-16.3),lty=2,col=3)
  points(TE0estimate(alpha=40,Ebase=-16.3),0,pch=8,col=3)
  
  
  ni <- "alpha_0_long_LowT_Leu"
  labels <- append(labels,eLabels[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1,lty=1,col=4)
  lines(dfs[[ni]]$temp,Ehydr(dfs[[ni]]$temp,alpha=0,Ebase=-13.3),lty=2,col=4)
  
  ni <- "alpha_20_long_LowT_Leu"
  labels <- append(labels,eLabels[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1,lty=1,col=5)
  lines(dfs[[ni]]$temp,Ehydr(dfs[[ni]]$temp,alpha=20,Ebase=-13.3),lty=2,col=5)
  points(TE0estimate(alpha=20,Ebase=-13.3),0,pch=8,col=5)
  
  #print(labels)
  
  
  
  # zero line
  lines(dfs[[ni]]$temp,rep(0,length(dfs[[ni]]$temp)),lty=3,col="grey")
  
  legend("topright",labels,col=c(1,2,3,4,5),lty=1)
  
  
  dev.off()
}


# Figure 4 in manuscript:

figureGHFit <-function(){
  pdf(paste(figDir,"G_H_fits.pdf",sep=""), width=5,height=10)
  
  labels <- c()
  cs <-c(2,3,4,5,6,7)
  
  
  layout(matrix(1:2, ncol = 1), widths = c(1,1),
         heights = c(2,2), respect = FALSE)
  
  par(cex=1.1,lwd=2,mar=c(4, 4.5, 2, 1))
  # mar= c(bottom, left, top, right)
  
  
  # Free energy
  plot(0,type='n',xlim=c(0.1,0.6),ylim=c(-25,25),xlab="temperature (reduced units)",ylab = TeX("$\\Delta G (kT)$"),main="(b)")
  
  ni <- "alpha_0_long_LowT"
  lines(dfs[[ni]]$temp,dfs[[ni]]$Gstate2 - dfs[[ni]]$Gstate1,col=cs[1])
  lines(dfs[[ni]]$temp,Fhydr(dfs[[ni]]$temp,alpha=0,Ebase=-16.3),lty=2,col=cs[1])
  
  ni <- "alpha_20_long_LowT"
  lines(dfs[[ni]]$temp,dfs[[ni]]$Gstate2 - dfs[[ni]]$Gstate1,col=cs[2])
  lines(dfs[[ni]]$temp,Fhydr(dfs[[ni]]$temp,alpha=20,Ebase=-16.3),lty=2,col=cs[2])
  
  ni <- "alpha_40_long_LowT"
  lines(dfs[[ni]]$temp,dfs[[ni]]$Gstate2 - dfs[[ni]]$Gstate1,col=cs[3])
  lines(dfs[[ni]]$temp,Fhydr(dfs[[ni]]$temp,alpha=40,Ebase=-16.3),lty=2,col=cs[3])
  
  ni <- "alpha_60_long_LowT"
  lines(dfs[[ni]]$temp,dfs[[ni]]$Gstate2 - dfs[[ni]]$Gstate1,col=cs[4])
  lines(dfs[[ni]]$temp,Fhydr(dfs[[ni]]$temp,alpha=60,Ebase=-16.3),lty=2,col=cs[4])
  #lines(dfs[[ni]]$temp,Fhydr(dfs[[ni]]$temp ,alpha=60,Ebase=-16.3)+ (-24.63 + 103.03*dfs[[ni]]$temp ),lty=4,col=cs[4])
  
  ni <- "alpha_0_long_LowT_Leu"
  lines(dfs[[ni]]$temp,dfs[[ni]]$Gstate2 - dfs[[ni]]$Gstate1,col=cs[5])
  lines(dfs[[ni]]$temp,Fhydr(dfs[[ni]]$temp,alpha=00,Ebase=-13.3),lty=2,col=cs[5])
  
  ni <- "alpha_20_long_LowT_Leu"
  lines(dfs[[ni]]$temp,dfs[[ni]]$Gstate2 - dfs[[ni]]$Gstate1,col=cs[6])
  lines(dfs[[ni]]$temp,Fhydr(dfs[[ni]]$temp,alpha=20,Ebase=-13.3),lty=2,col=cs[6])
  
  # zero line
  lines(dfs[[ni]]$temp,rep(0,length(dfs[[ni]]$temp)),lty=3,col="grey")
  
  
  # Enthalpy
  plot(0,type='n',xlim=c(0.1,0.6),ylim=c(-50,25),xlab="temperature (reduced units)",ylab = TeX("$\\Delta H (kT)$"),main="(c)")
  
  ni <- "alpha_0_long_LowT"
  labels <- append(labels,eLabels2[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1,lty=1,col=cs[1])
  lines(dfs[[ni]]$temp,Ehydr(dfs[[ni]]$temp,alpha=0,Ebase=-16.3),lty=2,col=cs[1])
  
  ni <- "alpha_20_long_LowT"
  labels <- append(labels,eLabels2[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1,lty=1,col=cs[2])
  lines(dfs[[ni]]$temp,Ehydr(dfs[[ni]]$temp,alpha=20,Ebase=-16.3),lty=2,col=cs[2])
  points(TE0estimate(alpha=20,Ebase=-16.3),0,pch=8,col=cs[2])
  
  ni <- "alpha_40_long_LowT"
  labels <- append(labels,eLabels2[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1,lty=1,col=cs[3])
  lines(dfs[[ni]]$temp,Ehydr(dfs[[ni]]$temp,alpha=40,Ebase=-16.3),lty=2,col=cs[3])
  points(TE0estimate(alpha=40,Ebase=-16.3),0,pch=8,col=cs[3])
  
  ni <- "alpha_60_long_LowT"
  labels <- append(labels,eLabels2[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1,lty=1,col=cs[4])
  lines(dfs[[ni]]$temp,Ehydr(dfs[[ni]]$temp,alpha=60,Ebase=-16.3),lty=2,col= cs[4])
  points(TE0estimate(alpha=60,Ebase=-16.3),0,pch=8,col=cs[4])
  
  
  ni <- "alpha_0_long_LowT_Leu"
  labels <- append(labels,eLabels2[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1,lty=1,col=cs[5])
  lines(dfs[[ni]]$temp,Ehydr(dfs[[ni]]$temp,alpha=0,Ebase=-13.3),lty=2,col=cs[5])
  
  ni <- "alpha_20_long_LowT_Leu"
  labels <- append(labels,eLabels2[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1,lty=1,col=cs[6])
  lines(dfs[[ni]]$temp,Ehydr(dfs[[ni]]$temp,alpha=20,Ebase=-13.3),lty=2,col=cs[6])
  points(TE0estimate(alpha=20,Ebase=-13.3),0,pch=8,col=cs[6])
  
  #print(labels)
  
  
  # zero line
  lines(dfs[[ni]]$temp,rep(0,length(dfs[[ni]]$temp)),lty=3,col="grey")
  
  legend("bottomleft",labels,col=cs,lty=1)
  
  
  dev.off()
}

figureTSFit <-function(){
  pdf(paste(figDir,"G_S_fits.pdf",sep=""), width=4,height=4)
  
  labels <- c()
  cs <-c(2,3,4,5,6,7)
  
  
  layout(matrix(1:1, ncol = 1), widths = c(1),
         heights = c(1), respect = FALSE)
  
  par(cex=0.9,lwd=2,mar=c(4, 4.5, 2, 1))
  # mar= c(bottom, left, top, right)
  
  # Entropy
  plot(0,type='n',xlim=c(0.1,0.6),ylim=c(-25,25),xlab="temperature (reduced units)",ylab = TeX("$-T\\Delta S (kT)$"),main="(b)")
  
  ni <- "alpha_0_long_LowT"
  labels <- append(labels,eLabels2[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,(dfs[[ni]]$Gstate2 - dfs[[ni]]$Gstate1) - (dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1) ,col=cs[1])
  lines(dfs[[ni]]$temp,-TdShydr(dfs[[ni]]$temp,alpha=0,Ebase=-16.3),lty=2,col=cs[1])
  
  ni <- "alpha_20_long_LowT"
  labels <- append(labels,eLabels2[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,(dfs[[ni]]$Gstate2 - dfs[[ni]]$Gstate1) - (dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1) ,col=cs[2])
  lines(dfs[[ni]]$temp,-TdShydr(dfs[[ni]]$temp,alpha=20,Ebase=-16.3),lty=2,col=cs[2])
  
  
  ni <- "alpha_40_long_LowT"
  labels <- append(labels,eLabels2[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,(dfs[[ni]]$Gstate2 - dfs[[ni]]$Gstate1) - (dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1) ,col=cs[3])
  lines(dfs[[ni]]$temp,-TdShydr(dfs[[ni]]$temp,alpha=40,Ebase=-16.3),lty=2,col=cs[3])
  
  ni <- "alpha_60_long_LowT"
  labels <- append(labels,eLabels2[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,(dfs[[ni]]$Gstate2 - dfs[[ni]]$Gstate1) - (dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1) ,col=cs[4])
  lines(dfs[[ni]]$temp,-TdShydr(dfs[[ni]]$temp,alpha=60,Ebase=-16.3),lty=2,col=cs[4])
  
  ni <- "alpha_0_long_LowT_Leu"
  labels <- append(labels,eLabels2[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,(dfs[[ni]]$Gstate2 - dfs[[ni]]$Gstate1) - (dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1) ,col=cs[5])
  lines(dfs[[ni]]$temp,-TdShydr(dfs[[ni]]$temp,alpha=0,Ebase=-13.3),lty=2,col=cs[5])
  
  ni <- "alpha_20_long_LowT_Leu"
  labels <- append(labels,eLabels2[which(eSettings==ni)])
  lines(dfs[[ni]]$temp,(dfs[[ni]]$Gstate2 - dfs[[ni]]$Gstate1) - (dfs[[ni]]$Estate2 - dfs[[ni]]$Estate1) ,col=cs[6])
  lines(dfs[[ni]]$temp,-TdShydr(dfs[[ni]]$temp,alpha=20,Ebase=-13.3),lty=2,col=cs[6])
  
  
  # zero line
  lines(dfs[[ni]]$temp,rep(0,length(dfs[[ni]]$temp)),lty=3,col="grey")
  
  legend("bottomright",labels,col=cs,lty=1)
  
  
  dev.off()
}




figureGHFit()
figureTSFit()

figureEnthalpyAll()
figureEnthalpyFit()
