
# source("HeatMap_SA.R")

#dataDir <- "/home2/DataErik/"
library(latex2exp)


# idea:
# first need to gather number of sampling points for s(h,c)
# calculate P(h|c) from this statsTable
# calculate P(c) from WHAM estimates
# finally calculate p(h,c)=p(h union c)=P(c)*P(h|c)
# get free energy per square: F(h,c) = -kT log(p(h,c))
# in free energies this becomes:
# -kT log(p(h,c)) = -kT log(P(c)*P(h|c)) =-kT(log(P(c))+log(P(h|c))
# be careful when to normalise -> precision may get lost



## First Load data for figureHeatMap
## Note that the probabilities do not contain enough precision for this task,
## free energies will need to be used.

## Free energies for contact bins
getFreeEnergyContacts <-function(ID,process=6,dataDir="",
													Umbrella = c(70,75,80,85,90)){
		cnames=c("Gstate1","Gstate2","Gstate3")

	x=read.table(paste(dataDir,ID,"/WhamFiles/WhamOutput_",process,ID,".txt",sep=""))
  # select rows
  out <- x[which(x$V1 < 92),]
	#print(x);
  # select columns
  out <- out[c("V1","V2","V4")]
  # set column names
  colnames(out) <- c("Cext","F.cext","p.cext")
	return(as.data.frame(out));
}

## Test

CF <- getFreeEnergyContacts("alpha_60_long_LowT",process=6,dataDir=dataDir)

## Sampling for Hydrogen bonds

getSamplingHydrogenBonds <- function(ID,process=6,dataDir="",Umbrella = c(70,75,80,85,90)){
  C <- seq(from=70,to=91)
  H <- seq(from=30,to=40)
  ncol = length(C)
  nrow = length(H)
  m <- matrix(rep(0,ncol*nrow),nrow=nrow,ncol=ncol)
  colnames(m) <- C
  rownames(m) <- H
  for(u in Umbrella){
     x=read.table(paste(dataDir,ID,"/",u,"/","statsTable",process,".txt",sep=""),header=TRUE);
     k <- matrix(rep(0,ncol*nrow),nrow=nrow,ncol=ncol)
     colnames(k) <- C
     rownames(k) <- H
     for(c in C){
      cs <- toString(c)
      tC <- sum(x$Cext==c)
      for(h in H){
        hs <- toString(h)
        m[hs,cs] = m[hs,cs] + sum(x$Cext==c & x$Hext ==h);
        k[hs,cs] = sum(x$Cext==c & x$Hext ==h)/tC;
        #print (m[hs,cs]);
      }
    }
    # check stability between umbrellas in k
    #print(k);
    #print(m);
  }
  return(m);
}

# Test
sampling <- getSamplingHydrogenBonds("alpha_60_long_LowT",process=6,dataDir=dataDir)


# calculate free energies, as described above
calculateFreeEnergies <- function(sampling,CF){
 C <- as.numeric(colnames(sampling))
 H <- as.numeric(rownames(sampling))
 ncol = length(C)
 nrow = length(H)
 Fch <- matrix(rep(0,ncol*nrow),nrow=nrow,ncol=ncol)
 colnames(Fch) <- C
 rownames(Fch) <- H
 fch <- matrix(rep(0,ncol*nrow),nrow=nrow,ncol=ncol)
 colnames(fch) <- C
 rownames(fch) <- H
 for(c in C){
  cs <- toString(c)
  tC <- sum(sampling[,cs])
  for(h in H){
    hs <- toString(h)
    fch[hs,cs]=-log(sampling[hs,cs]/tC)
    Fch[hs,cs]=-log(sampling[hs,cs]/tC) + CF$F.cext[CF$Cext==(c+0.5)]
    if(is.nan(Fch[hs,cs]) | is.infinite(Fch[hs,cs])){Fch[hs,cs]=50}
  }
 }
 Fch=Fch - min(Fch)
 return(Fch);
}

# Test
Fch <- calculateFreeEnergies(sampling,CF)


figureHeatMap <-function(){

  pdf(paste(figDir,"HeatMap_T.pdf",sep=""), width=12,height=4)
  layout(matrix(1:4, ncol = 4), widths = c(3,3,3,1),heights = c(1,1,1,1), respect = FALSE)
        # mar = c(bottom, left, top, right)
  #par(mar=c(2, 4, 2, 1))
	par(cex.lab=1.5, mar=c(5, 5, 5, 1))
  dataDir <- "/DataErik/AggregationSimulations/"

  s <- "alpha_60_long_LowT"
  iL <- "17"
	LT ="T = 0.23"
  iM <- "14"
	MT = "T = 0.30"
  iH <- "6"
  HT =	"T = 0.47"
	cutoff <-6


  my.colors = colorRampPalette(c("dark red","red","orange", "yellow", "light blue", "white"),bias=1.5)
  #my.colors = colorRampPalette(c("red","orange", "yellow", "light blue", "white"),bias=2)
	my.colors = colorRampPalette(c("dark blue","blue","cyan", "yellow", "white"),bias=1.5)
	cl <- my.colors(100)
  zl <- c(0,15);
	xlab <- "external contacts"
	ylab <- "hydrogen bonds"


  ld = TRUE

	#getData
	if(ld){
		LCF <- getFreeEnergyContacts(s,process=iL,dataDir=dataDir)
		MCF <- getFreeEnergyContacts(s,process=iM,dataDir=dataDir)
		HCF <- getFreeEnergyContacts(s,process=iH,dataDir=dataDir)

		Lsampling <- getSamplingHydrogenBonds(s,process=iL,dataDir=dataDir)
		Msampling <- getSamplingHydrogenBonds(s,process=iM,dataDir=dataDir)
		Hsampling <- getSamplingHydrogenBonds(s,process=iH,dataDir=dataDir)

		# remove seed hydrogens and external contacts
		Cn <- as.numeric(colnames(Lsampling)) -70
		Hn <- as.numeric(rownames(Lsampling)) - 30
	}

  #iL
  LFch <- calculateFreeEnergies(Lsampling,LCF)
  #image(Cn,Hn,t(LFch),col=cl,xlab=xlab,ylab=ylab,zlim=zl,main=LT);
	image(Hn,Cn,(LFch),col=cl,xlab=ylab,ylab=xlab,zlim=zl,main=LT);

  #iM
  MFch <- calculateFreeEnergies(Msampling,MCF)
  #image(Cn,Hn,t(MFch),col=cl,xlab=xlab,ylab=ylab,zlim=zl,main=MT);
	image(Hn,Cn,(MFch),col=cl,xlab=ylab,ylab=xlab,zlim=zl,main=MT);

  #iH
  HFch <- calculateFreeEnergies(Hsampling,HCF)
  #image(Cn,Hn,t(HFch),col=cl,xlab=xlab,ylab=ylab,zlim=zl,main=HT);
	image(Hn,Cn,(HFch),col=cl,xlab=ylab,ylab=xlab,zlim=zl,main=HT);

  #colorbar
  bar <- seq(0,75)/5
  image(1,bar,matrix(bar,nrow=1),col=cl,xaxt="n",xlab="",ylab=TeX("$\\Delta G  (k_{B}T)"),zlim=zl);
  dev.off()

  # todo: margins + fast load
  # nice labels
}

figureHeatMap()