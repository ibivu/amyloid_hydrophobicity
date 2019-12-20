# -*- coding: utf-8 -*-
"""
Created on Fri Sep 27 14:42:03 2019

@author: Alessia
"""
# Import packages
import matplotlib.pyplot as plt
import numpy as np# Color maps
blues = plt.get_cmap('Blues')
reds = plt.get_cmap('Reds')oranges = plt.get_cmap('Oranges')greens = plt.get_cmap('Greens')# Load data
df=np.loadtxt('340_330deltag_fitted.txt')
# x range
x=df[:, 0]
x_new=np.linspace(0,28,28)  #####the new x for the fitting, creates 200 values between 0 and 5
# Curve labels
labels=[r'20 $\mu$M PBS-urea', r'60 $\mu$M PBS-urea', r'20 $\mu$M PB-urea', '60 $\mu$M PB-urea']# Make plot
colors=[oranges(0.6), oranges(0.9), greens(0.6), greens(0.9)]
z = -1
i_y = -1
i_yerr = 0
inc=1/8
for i in range(1,5):
    i_y = i_y+2
    i_yerr= i_yerr+2
    y= df[:,i_y]
    z = z+1    if i%2 == 0:
	#    slope, intercept, r_value, p_value, std_err = stats.linregress(x, y)
		plt.plot(x, y, marker='o', label=labels[z], linewidth= 2, color=colors[z])
	#    plt.plot(x_new, intercept + slope*x_new, color=colors[z], linewidth=3)
		plt.errorbar(x, y, yerr=df[:, i_yerr], color=colors[z], fmt='o')
	#    print("slope: %f    intercept: %f" % (slope, intercept))
	#    print("R-squared: %f" % r_value**2)
plt.ylabel('$\Delta G_{app}$ (kJ/mol)', fontsize=18)
plt.yticks(fontsize=18)
plt.xlabel('Time (d)', fontsize=18)
plt.xticks(fontsize=18)
#plt.ylim(-42, -22.5)
#plt.xlim(-0.5, 30)
#ax.set_xticklabels(labels, fontsize=18)
#ax.set_title('Monomers binding on bsyn fibrils', fontsize=10)
#ax.yaxis.grid(False)
plt.title('$\Delta G_{app}$ from FI 340/330', fontsize=18)
plt.legend(loc=4)
plt.savefig('kinetic_g_denat340_330.pdf', dpi=500)
plt.show()
    




















