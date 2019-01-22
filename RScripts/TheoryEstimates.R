
# source("TheoryEstimates.R")

Ehydr <- function(t,Nh=-6,alpha=40,T0=0.4,Ebase=0){
	result = -alpha * Nh *(T0^2 - t^2) + Ebase
	return(result)
}

Fhydr <- function(t,Nh=-6,alpha=40,T0=0.4,Ebase=0){
	result = Ebase  - alpha * Nh *(t - T0)^2
	return(result)
}

TdShydr <- function(t,Nh=-6,alpha=40,T0=0.4,Ebase=0){
	result = Ehydr(t,Nh=Nh,alpha=alpha,T0=T0,Ebase=Ebase) - Fhydr(t,Nh=Nh,alpha=alpha,T0=T0,Ebase=Ebase);
	return(result)
}


TE0estimate <- function(alpha=20,Ebase = -16.3, T0=0.4,Nh=-6){
	Td = 	sqrt(-Ebase/(alpha*Nh) + T0^2)
	return(Td)
}

Tdestimate <- function(alpha=20,Ebase = - 16.3, T0=0.4,Nh=-6,dS=0){
	Td =  (2*alpha*Nh*T0 + dS - sqrt(4*alpha*Nh*T0*dS + 4*alpha*Nh*Ebase + dS^2))/2*alpha*Nh
	Tm = (2*alpha*Nh*T0 + dS + sqrt(4*alpha*Nh*T0*dS + 4*alpha*Nh*Ebase + dS^2))/2*alpha*Nh
	return( c(Td,Tm))
}

TdestimateNOs <- function(alpha=20,Ebase = - 16.3, T0=0.4,Nh=-6,dS=0){
	Td = T0 - sqrt(Ebase/Nh*alpha)
	Tm = T0 + sqrt(Ebase/Nh*alpha)
	return( c(Td,Tm))
}
