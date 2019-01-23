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

flarray1=numpy.loadtxt("110803_monfib2_Data1RAW_40C.txt")
flarray2=numpy.loadtxt("110803_monfib5_Data1RAW_50C.txt")
flarray3=numpy.loadtxt("110804_monfib2_Data1RAW_35C.txt")

flarray4=numpy.loadtxt("20171117_Data1RAW_50C.txt")
flarray5=numpy.loadtxt("20171120_Data1RAW_30C.txt")
flarray6=numpy.loadtxt("20171201_Data1RAW_40C.txt")

flarray7=numpy.loadtxt("gluc_monfib1_Data1RAW_20C.txt")
flarray8=numpy.loadtxt("gluc_monfib2_Data1RAW_30C.txt")
flarray9=numpy.loadtxt("gluc_monfib3_Data1RAW_47C.txt")


ax = plt.subplot(131)

plot(flarray1[:,0]/60,flarray1[:,1]+0.07, color = reds(0.7), linewidth = 2, markersize = 10, label=r"40$^{\circ}$C")
plot(flarray2[:,0]/60,flarray2[:,1]+0.15, color = reds(0.9), linewidth = 2, markersize = 10, label=r"50$^{\circ}$C")
plt.tick_params(axis='both', which='major', labelsize=20)
xlabel('Time [min]', fontsize = 20)
ylabel(r'Differential heating rate [$\mu$cal/s]', fontsize = 20)
legend(loc=0)
ylim([10,10.6])
xlim([0,90])

ax = plt.subplot(132)
plot(flarray5[:,0]/60-2,flarray5[:,1]+0.45, color = reds(0.5), linewidth = 2, markersize = 10, label=r"30$^{\circ}$C")
plot(flarray6[:,0]/60-10,flarray6[:,1]+0.45, color = reds(0.7), linewidth = 2, markersize = 10, label=r"40$^{\circ}$C")
plot(flarray4[:,0]/60-2,flarray4[:,1]-0.1, color = reds(0.9), linewidth = 2, markersize = 10, label=r"50$^{\circ}$C")
plt.tick_params(axis='both', which='major', labelsize=20)
xlabel('Time [min]', fontsize = 20)
ylabel(r'Differential heating rate [$\mu$cal/s]', fontsize = 20)
xlim([0,30])
ylim([5,5.6])
legend(loc=0)

ax = plt.subplot(133)
#plot(flarray7[:,0]/60,flarray7[:,1]-0.3, color = reds(0.3), linewidth = 2, markersize = 10, label=r"20$^{\circ}$C")
plot(flarray8[:,0]/60,flarray8[:,1]-0.18, color = reds(0.5), linewidth = 2, markersize = 10, label=r"30$^{\circ}$C")
plot(flarray9[:,0]/60,flarray9[:,1]+0.3, color = reds(0.85), linewidth = 2, markersize = 10, label=r"47$^{\circ}$C")
plt.tick_params(axis='both', which='major', labelsize=20)
xlabel('Time [min]', fontsize = 20)
ylabel(r'Differential heating rate [$\mu$cal/s]', fontsize = 20)
xlim([0,100])
ylim([10,10.6])
legend(loc=0)

show()
