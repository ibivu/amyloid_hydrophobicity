#!/usr/bin/python

"""
Created on Tue Oct 22 15:11:29

@Author: Juami
"""

import numpy as np
from scipy.optimize import curve_fit
import matplotlib.pyplot as plt

T = 277.15		# Temperature in Kelvin
# Curve to fit through the data points
def sigmoid(x, g, m):
	""" Sigmoidal function """
	r = 8.314		# Gas constant in J/(K mol)
	mt = 0.00006	# 60 uM fibrils
	return (((2*(np.exp((-(g+m*x))/(r*(T)))*(mt)))+1-np.sqrt(4*(np.exp((-(g+m*x))/(r*(T)))*(mt))+1))/(2*np.power((np.exp((-(g+m*x))/(r*(T)))*(mt)),2)))

# Load data
df_PB = np.loadtxt('norm_ratio_60uM_PB.txt')
df_PBS = np.loadtxt('norm_ratio_60uM_PBS.txt')

### Plotting
# Colors
blues = plt.get_cmap('Blues')
reds = plt.get_cmap('Reds')
colors = [reds(0.4), reds(0.9), blues(0.4), blues(0.9)]

# Legend labels
labels = ['PB room temperature', r'PB 4$^{\circ}$C', 'PBS room temperature', r'PBS 4$^{\circ}$C']

# PB data
x1 = df_PB[:,0]
y11 = df_PB[:,1]
y12 = df_PB[:,5]

# PB data
x2 = df_PBS[:,0]
y21 = df_PBS[:,1]
y22 = df_PBS[:,5]

x_plot = np.linspace(0,5,100)

y_fitted = []
def plot_sigmoid(x, y, color, label):
	""" fit sigmoid through through data points and add to plot """
	popt, pcov = curve_fit(sigmoid, x, y, bounds=([-50000, 0], [-100, 10000]))
	plt.plot(x, y, 'o', color=color)
	plt.plot(x_plot, sigmoid(x_plot, *popt), '-', linewidth=2, color=color, label=label)
	y_fitted.append(sigmoid(x_plot, *popt))

# Make plot
fig = plt.figure()

# 'PB'
T = 303.15		# Temperature in Kelvin 30C
plot_sigmoid(x1, y11, colors[0], labels[0])

# 'PB'
T = 277.15		# Temperature in Kelvin 4C
plot_sigmoid(x1, y12, colors[1], labels[1])

# 'PBS'
T = 303.15   	# Temperature in Kelvin 30C
plot_sigmoid(x2, y21, colors[2], labels[2])

# 'PBS'
T = 277.15		# Temperature in Kelvin 4C
plot_sigmoid(x2, y22, colors[3], labels[3])

diff_PB = y_fitted[1] - y_fitted[0]
diff_PBS = y_fitted[3] - y_fitted[2]
#plt.plot(x_plot, diff_PB, color='red')
#plt.plot(x_plot, diff_PBS, color='blue')

#plt.title(r'$\alpha$-synuclein denaturation at different temperatures')
plt.xlabel('Urea concentration (M)', fontsize=14)
plt.ylabel('Fraction monomeric', fontsize=14)
plt.legend(loc=0)
plt.savefig('salt_urea_denaturation.pdf')
plt.show()

#print y_fitted