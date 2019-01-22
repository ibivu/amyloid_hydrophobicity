#!/usr/bin/python
import pylab
import scipy
import numpy
from pylab import *
from numpy import *
from matplotlib import rc

reds = plt.get_cmap('Reds')
blues = plt.get_cmap('Blues')
greens = plt.get_cmap('Greens')

flarray1=numpy.loadtxt("110824_alac_Bradford2.txt")
flarray2=numpy.loadtxt("110815_glucagon_denaturants_42C_eq_RT_181126_analysis.csv")


a = -58324.4
b = 11561.8
c = -52464.7
d = 10464.7


ax = plt.subplot(121)
## Plot data
plot(flarray1[:,0],flarray1[:,3], marker = 'o', linewidth = 0, markersize = 8, color = reds(0.7) )
x = arange(0, 6, 0.1)
plot(x, (exp(-(c+d*x)/(2477))*6.3e-5+0.5-sqrt(exp(-(c+d*x)/(2477))*6.3e-5+0.25))/(exp(-(c+d*x)/(2477))*6.3e-5*(exp(-(c+d*x)/(2477))*6.3e-5)), linewidth = 3, color = reds(0.9), label="alpha-lactalbumin")
plt.tick_params(axis='both', which='major', labelsize=20)
xlabel(r'[GndSCN]', fontsize = 20)
ylabel('Fraction of soluble protein', fontsize = 20)
legend(loc=0)
ylim([-0.1,1.2])
xlim([0,5.2])


ax = plt.subplot(122)
## Plot data
plot(flarray2[:,0],flarray2[:,1], marker = 'o', linewidth = 0, markersize = 8, color = blues(0.7))
x = arange(0, 7, 0.1)
plot(x, (exp(-(a+b*x)/(2477))*7.2e-5+0.5-sqrt(exp(-(a+b*x)/(2477))*7.2e-5+0.25))/(exp(-(a+b*x)/(2477))*7.2e-5*(exp(-(a+b*x)/(2477))*7.2e-5)), linewidth = 3, color = blues(0.9), label="glucagon")
plt.tick_params(axis='both', which='major', labelsize=20)
xlabel(r'[GndHCl]', fontsize = 20)
ylabel('Fraction of soluble protein', fontsize = 20)
legend(loc=0)
ylim([-0.1,1.2])
xlim([0,4])

show()
