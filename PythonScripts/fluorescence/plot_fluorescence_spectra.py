# -*- coding: utf-8 -*-
"""
Created on Thu Jan  3 15:30:11 20.7

@author: Alessia
"""

### Import modules
import pylab
import scipy
from pylab import *
from numpy import *
from matplotlib import rc
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from lmfit.models import ExponentialModel, GaussianModel    

### Initialize figure
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(17, 7.5))

### Plot Gaussian fits
##fit F94W 
greens = plt.get_cmap('Greens')
oranges = plt.get_cmap('Oranges')


df1_spectra = np.loadtxt('60uM_PBS_PB.txt')

fit_data1= pd.DataFrame(np.copy(df1_spectra[:,1:]) ,index=np.copy(df1_spectra[:,0]), dtype=float)
fit_pars1= list(range(10))

labellist = [r'0 M PBS', r'5 M PBS', r'0 M PB', r'5 M PB']

n=4

colors = [oranges(0.8), oranges(0.6), greens(0.8), greens(0.6)] 
#plt.cm.Reds(np.linspace(0.5,0.9, n))

x= df1_spectra [:,0]
#fig = plt.figure()

z = -1

inc=1/4
for i in range(1,5):
    y= df1_spectra [:,i]
    z = z+1

    exp_mod = ExponentialModel(prefix='exp_')
    pars = exp_mod.guess(y, x=x)
        
    gauss1 = GaussianModel(prefix='g1_')
    pars.update(gauss1.make_params())
        
    pars['g1_center'].set(340, min=339, max=343)
    pars['g1_sigma'].set(10, min=1)
    pars['g1_amplitude'].set(1000, min=1)
    gauss2 = GaussianModel(prefix='g2_')
        
    pars.update(gauss2.make_params())
        
    pars['g2_center'].set(330, min=325, max=3333)
    pars['g2_sigma'].set(10, min=1)
    pars['g2_amplitude'].set(1000, min=1)
        
    mod = gauss1 +  gauss2 + exp_mod
                   
    init = mod.eval(pars, x=x)
        
    out = mod.fit(y, pars, x=x)

    fit_data1.iloc[:,i-1] = out.best_fit
    fit_pars1[i-1] = out.best_values
          
    ax1.plot(x, out.best_fit, linewidth= 3, color=colors[z], label=labellist[z])
    ax1.scatter(x, y, marker= 'o', color=colors[z])
ax1.set_xlabel('Wavelength (nm)', fontsize=18)
ax1.set_ylabel('Fluorescence Intensity (a.u.)', fontsize=18)
#ax1.title('60 µM 6 days equilibration RT PBS-urea', fontsize=18)
xlabs = [int(x) for x in ax1.get_xticks()]
ylabs = [int(y) for y in ax1.get_yticks()]
#ax1.set_xticks(xlabs)
ax1.set_xticklabels(xlabs, fontsize=18)
ax1.set_yticklabels(ylabs, fontsize=18)
ax1.legend(loc=0)
#plt.ylim(10,1400)
#ax1.title('spectra in 60 µM PBS 6d equil')


### Plot ratios
df=np.loadtxt('ratio_PBS_PB.txt')

colors=[oranges (0.9), greens(0.9), oranges (0.6), greens(0.6)]

data=df[:, 1]

#legendlabels=['PBS', 'PB']
#labels=['0 M', '0 M', '5 M', '5 M']
labels = ['PBS', 'PB', 'PBS', 'PB']

z = -1
for k in range(1,2):
    y= df [:,k]
    z = z+1
    
    x_pos = np.arange(len(labels))
    #fig, ax = plt.subplots()
    ax2.bar(x_pos, data,
           align='center',
           #alpha=0.5,
           ecolor='black',
		   color=colors,
           capsize=5, 
           width=0.6)
#color=colors[k-1])
    ax2.set_ylabel('FI 340/330 nm', fontsize=18)
    ax2.set_xlabel('0 M             5 M', fontsize=18)
    plt.yticks(fontsize=18)
    ax2.set_xticks(x_pos)
    ax2.set_xticklabels(labels, fontsize=18)
    #ax2.set_title('Monomers binding on bsyn fibrils', fontsize=10)
    ax2.yaxis.grid(False)
    plt.ylim(0,1.2)
    
#ax2.legend(['PBS', 'PB'], fontsize=18)
plt.savefig('fluorescence.pdf', dpi=500)
plt.show()