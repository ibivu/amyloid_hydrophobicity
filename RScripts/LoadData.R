
### Call this R script with source("LoadData.R")


# set directory names
#sourceDir <- "/Users/sanneabeln/GoogleDrive2/Papers/ErikAggregation2016/RCODE_FIGS/"
#dataDir <- "/Volumes/WDMacSA/AggregationSimulations/"
#dataDir <- "/home2/DataErik/"
#figDir <- "/Users/sanneabeln/GoogleDrive2/Papers/ErikAggregation2016/Figures/"


# import data processing R functions
#source(paste(sourceDir,"ParseAll.R",sep=""))
#source(paste(sourceDir,"GetEqdHSA.R",sep=""))

simulationE <- setRefClass("simulationE", fields=list(id="character", description="character", data="data.frame"))


# LOAD DATA in dfs
dataLoad <- function(eSettings){
	# a list of data frames, same order as eSettings
	dfs <- list()
	for (i in 1:length(eSettings)){
		dfe <- GetEnthalpyD(ID=eSettings[i],dataDir=dataDir);
		dfg <- getFreeEnergy(ID=eSettings[i],dataDir=dataDir);
		dfp <- getPstate(ID=eSettings[i],dataDir=dataDir);
		dfs[[eSettings[i]]] <- merge(merge(dfe,dfg,by=0,sort=FALSE),dfp,by=0,sort=FALSE)
	}
	return(dfs)
}


GetEnthalpyD <- function(ID,dataDir="", state1 = 70, state2 = 91, state3=84,
													Umbrella = c(70,75,80,85,90), nProc=24){

	cnames=c("temp","Estate1","Estate2","Estate3")
	ncol = length(cnames)
	m <- matrix(rep(0,ncol*nProc),ncol=ncol,nrow=nProc)
	colnames(m) <- cnames
	for(p in 0:(nProc-1)){
		totE1=0
		totE2=0
		totE3=0
		N1=0
		N2=0
		N3=0
		for(u in Umbrella){
			x=read.table(paste(dataDir,ID,"/",u,"/","statsTable",p,".txt",sep=""),header=TRUE);
			totE1= totE1 + sum(x$E_corr[which(x$Cext==state1)]);
			totE2= totE2 + sum(x$E_corr[which(x$Cext==state2)]);
			totE3= totE3 + sum(x$E_corr[which(x$Cext==state3)]);
			N1 = N1+ length(x$E_corr[which(x$Cext==state1)]);
			N2 = N2+ length(x$E_corr[which(x$Cext==state2)]);
			N3 = N3+ length(x$E_corr[which(x$Cext==state3)]);
		}
		m[p+1,"Estate1"] = totE1/(N1*100.0)
		m[p+1,"Estate2"] = totE2/(N2*100.0)
		m[p+1,"Estate3"] = totE3/(N2*100.0)
		m[p+1,"temp"] = x[1,]$T
		print(m[p+1,]);
	}
	print(m)
	return(as.data.frame(m));
}

GetEnthalpO <-function(){
	for (i in 1:length(IDlist)){
		getEnthalpyM(IDlist[i])
	}
}

getFreeEnergy <-function(ID,dataDir="", state1 = 70, state2 = 91,state3=84,
													Umbrella = c(70,75,80,85,90), nProc=24){
		cnames=c("Gstate1","Gstate2","Gstate3")
		ncol = length(cnames)
		m <- matrix(rep(0,ncol*nProc),ncol=ncol,nrow=nProc)
		colnames(m) <- cnames
		for(p in 0:(nProc-1)){
			tryCatch({
			x=read.table(paste(dataDir,ID,"/WhamFiles/WhamOutput_",p,ID,".txt",sep=""))
			# pick out the correct state from V1
			m[p+1,"Gstate1"] = x$V2[which(abs(x$V1-state1-0.5) < 0.001)];
			m[p+1,"Gstate2"] = x$V2[which(abs(x$V1-state2-0.5) < 0.001)];
			m[p+1,"Gstate3"] = x$V2[which(abs(x$V1-state3-0.5) < 0.001)];
			},error = function(err) {
			m[p+1,"Gstate1"] = Inf
			m[p+1,"Gstate2"] = Inf
			m[p+1,"Gstate3"] = Inf
			})
		}
	print(m);
	return(as.data.frame(m));
}

getPstate <-function(ID,dataDir="", state1 = 70, state2 = 91,state3=84,
													state2L = 86,state3L=81,
													Umbrella = c(70,75,80,85,90), nProc=24){
		cnames=c("Pstate1","Pstate2","Pstate3")
		ncol = length(cnames)
		m <- matrix(rep(0,ncol*nProc),ncol=ncol,nrow=nProc)
		colnames(m) <- cnames
		for(p in 0:(nProc-1)){
			tryCatch({
			x=read.table(paste(dataDir,ID,"/WhamFiles/WhamOutput_",p,ID,".txt",sep=""));
			# pick out the correct state from V1
			# may need to define states more broadly, with min and max
			m[p+1,"Pstate1"] = x$V4[which(abs(x$V1-state1-0.5) < 0.001)];
			#m[p+1,"Pstate2"] = x$V4[which(abs(x$V1-state2-0.5) < 0.001)];
			m[p+1,"Pstate2"] = sum(x$V4[which((x$V1-0.6) < state2 & (x$V1-0.6) > state2L )]);
			#m[p+1,"Pstate3"] = x$V4[which(abs(x$V1-state3-0.5) < 0.001)];
			m[p+1,"Pstate3"] = sum(x$V4[which((x$V1-0.6) < state3 & (x$V1-0.6) > state3L )]);
			},error = function(err) {
			m[p+1,"Pstate1"] =0.0;
			m[p+1,"Pstate2"] =0.0;
			m[p+1,"Pstate3"] =0.0;
			})
		}
		print(m);
		return(as.data.frame(m));
}



TestIt <-function(){
	x=read.table(paste(dataDir,"alpha_20_long_LowT","/",70,"/statsTable4.txt",sep=""),header=TRUE)
	print(head(x))
	s <- simulation("simulation",id="alpha_20_long_LowT", description= "alpha", data=NULL)
	d1 <- GetEnthalpyD(ID="alpha_20_long_LowT",dataDir=dataDir)
	#d1 <- as.dataframe(m1)
	plot(0,xlim=c(0,1.0),ylim=c(-50,25),type="n")
	lines(d1$temp,d1$Estate2 - d1$Estate1,lty=1)
	lines(d1$temp,Ehydr(d1$temp,alpha=20,Ebase=-18),lty=2)
}
