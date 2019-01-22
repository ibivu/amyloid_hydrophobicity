
# source("PaggrFiguresSA.R")

# required libraries
# install.packages('latex2exp')
library(latex2exp)
library(methods)

# set directories and load data
sourceDir <- "/surfdrive/fibrilhydrophobicityall_juami/"
source(paste(sourceDir,"setDataSources.R",sep=""))
source(paste(sourceDir,"LoadData.R",sep=""))
source(paste(sourceDir,"TheoryEstimates.R",sep=""))


## SAVE / RELOAD data
load(file=paste(tmpDir,"dataframesEnthaly_NumStates.Rdata",sep=""))
dfs <- dfsN
##


# Manuscript Fig 3

figurePstatesAll2 <-function(){
	sets <- c(which(eSettings=="alpha_0_long_LowT"),
	which(eSettings=="alpha_20_long_LowT"),
	which(eSettings=="alpha_40_long_LowT"),
	which(eSettings=="alpha_60_long_LowT")
	)
	print(sets)
	pdf(paste(figDir,"Pstate_all2.pdf",sep=""),width=6,height=7)
	#layout(matrix(1:4, ncol = 1), widths = 1,
	#				heights = c(5,5,5,5.9), respect = FALSE)
	layout(matrix(1:5, ncol = 1), widths = 1,
									heights = c(5,5,5,5,1.4), respect = FALSE)
	# par = c(bottom, left, top, right)
	par(mar=c(2, 4.5, 2, 1),cex=0.9)
	cols <- c("gray45","cadetblue2","cadetblue4")
	for(i in sets){
		ni <- eSettings[i]
		print(ni)
		print(dfs[[ni]]$temp)
		print(dfs[[ni]]$Pstate2)
		if(ni=="alpha_60_long_LowT"){
			#par(mar=c(4, 4, 2, 1))
		}
		plot(0,type='n',xlim=c(0.18,0.52),ylim=c(0,1.0),xlab="temperature (reduced units)",
		ylab = TeX("$<\\;P_{state}\\;>$"),main=eLabels2[i],yaxp=c(0.0,1.0,1),las=1)

		lines(dfs[[ni]]$temp,dfs[[ni]]$Pstate2,col=cols[1],lty=2)
		sampled <- dfs[[ni]]$Gstate2!=Inf
		lines(dfs[[ni]]$temp[sampled],dfs[[ni]]$Pstate2[sampled],col=cols[1],lty=1,lwd=2)

		lines(dfs[[ni]]$temp,dfs[[ni]]$Pstate1,col=cols[2],lty=2)
		sampled <- dfs[[ni]]$Gstate1!=Inf
		lines(dfs[[ni]]$temp[sampled],dfs[[ni]]$Pstate1[sampled],col=cols[2],lty=1,lwd=2)

		lines(dfs[[ni]]$temp,dfs[[ni]]$Pstate3,col=cols[3],lty=2)
		sampled <- dfs[[ni]]$Gstate3!=Inf
		lines(dfs[[ni]]$temp[sampled],dfs[[ni]]$Pstate3[sampled],col=cols[3],lty=1,lwd=2)
		if(ni=="alpha_0_long_LowT"){
			legend("topright",legend=c("fibril","monomer","amorphous"),col=cols,lty=1,bty="n")
		}
	}
	#plot the xlabel
	par(mar=c(0, 0, 0, 0))
	plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
	text(x = 0.5, y = 0.5, "temperature (reduced units)", col = "black")
	dev.off()
}

figurePstatesAll2()
