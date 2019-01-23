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

flarray1=numpy.loadtxt("GNNQQNY_30C_both.csv")
flarray2=numpy.loadtxt("120322_20C_conc_dep_corrected_without_last_point.txt")
flarray3=numpy.loadtxt("120327_30C_conc_dep_corrected_without_last_point.txt")

## Plot data

ax = plt.subplot(121)

plot(flarray1[:,0]/60, flarray1[:,1], linewidth = 3, color = reds(0.8), markersize = 10, label="crystals injected")
plot(flarray1[:,2]/60, flarray1[:,3]-0.05, linewidth = 3, color = reds(0.4), markersize = 10, label="monomer injected")
plt.tick_params(axis='both', which='major', labelsize=20)
xlabel(r'Time [min]', fontsize = 20)
ylabel('Differential heating rate [$\mu$cal/s]', fontsize = 20)
legend(loc=0)
ylim([8,11])
xlim([0,40])

ax = plt.subplot(122)

plot(flarray2[:,0],flarray2[:,1], marker = 'o', color = blues(0.8), linewidth = 0, markersize = 10)
x = arange(0, 200, 1)
plot(x, 4.207*x, linewidth = 3, color = blues(0.8), label="20$^{\circ}$C")
plot(flarray3[:,0],flarray3[:,1], marker = 'o', color = reds(0.8), linewidth = 0, markersize = 10)
y = arange(0, 164.81, 1)
plot(y, 10.305*y, linewidth = 3, color = reds(0.8), label="30$^{\circ}$C")
plt.tick_params(axis='both', which='major', labelsize=20)
xlabel(r'Final peptide concentration [$\mu$M]', fontsize = 20)
ylabel('Enthalpy of crystal dissolution [$\mu$cal]', fontsize = 20)
legend(loc=2)
ylim([0,1200])
xlim([0,150])

show()


