#!/usr/bin/python

from sys import argv
import scipy
from matplotlib.pyplot import *
import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import *
from scipy.interpolate import *
import configparser
import os

#os.chdir(os.path.dirname(argv[0]))

#coord_dict = {}
xcoords = []
ycoords = []
with open('fits_combined.txt', 'r') as f:
	for line in f:
		if not line.startswith('Protein') and not line.startswith('#'):
			line = line.strip().split()
			#coord_dict[float(line[1])] = float(line[2])
			xcoords.append(float(line[1]))
			ycoords.append(float(line[2]))
			
def y(x, a):
	return a*x
	
x_sorted = sorted(xcoords)
indeces = []
for x in x_sorted:
	idx = xcoords.index(x)
	if not idx in indeces:
		indeces.append(idx)
	else:
		while idx in indeces:
			idx = xcoords.index(x, idx+1)
		indeces.append(idx)
	
	
y_sorted = [ycoords[i] for i in indeces]
print xcoords
print ycoords
print x_sorted
print y_sorted
params, cov = curve_fit(y, x_sorted, y_sorted)
a_fit = params[0]

print 'a, b', a_fit

x_avg = np.mean(x_sorted)
y_avg = y(x_avg, a_fit)
print 'x, y avg', x_avg, y_avg

plt.figure()
# plot phenylalanine
plt.plot(x_sorted[0], y_sorted[0], 'o')#, label='L-phe')
# plot di-phenylalanine
plt.plot(x_sorted[2], y_sorted[2], 'o')#, label='di-phe')
# plot glucagon
plt.plot(x_sorted[3], y_sorted[3], 'o')#, label=r'Gluc$^1$')
plt.plot(x_sorted[4], y_sorted[4], 'o', color='g')#, label=r'Gluc$^2$')
plt.plot(x_sorted[5], y_sorted[5], 'o', color='C8')#, label=r'Gluc$^3$')
# plot alpha-synuclein
plt.plot(x_sorted[6], y_sorted[6], 'o')#, label=r'$\alpha$-syn')
# plot beta-2-microglobulin
plt.plot(x_sorted[7], y_sorted[7], 'o')#, label='b-2-mic')
# plot alpha-lactalbumin
plt.plot(x_sorted[8], y_sorted[8], 'o')#, label=r'$\alpha$-lac')
# plot GNNQQNY
plt.plot(x_sorted[1], y_sorted[1], 'o')#, label=r'$\alpha$-lac')
# plot alpha fit
plt.plot([0]+x_sorted, y(np.array([0]+x_sorted), a_fit), 'b', label=r'fit: $\alpha$=%.2E' % a_fit)
plt.xlabel(r'Hydrophobic Surface Area $\left(\.A^2\right)$')
plt.ylabel(r'$\gamma \left(\frac{kJ}{K^2 \.A^2 mol}\right)$')
plt.xlim(0, 6000)
plt.ylim(0, 1e-2)
plt.ticklabel_format(style='sci', axis='y', scilimits=(0,0))
plt.legend(loc=4)#, ncol=2)
plt.savefig('fit_alpha.png')
plt.show()