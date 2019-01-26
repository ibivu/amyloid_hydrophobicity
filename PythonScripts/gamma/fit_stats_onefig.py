#!/usr/bin/python
import sys
import scipy
import matplotlib.pyplot as plt
from matplotlib import gridspec
import numpy as np
from scipy.optimize import *
from scipy.interpolate import *
import configparser
import os
from sys import argv

#os.chdir(os.path.dirname(argv[0]))

def get_data(dirname):
	'''	Reads in data from all text files in the input directory
	format: 1. Column Temp, 2. Column Enthalpy
	Sorts data set with repect to temperature 
	Input:
		- directory with temperatures and measured enthalpies
	Output:
		- dictionary: dict[filename] = ([temperatures], [enthalpies]) to be used as numpy arrays '''
	
	TK_dict = {}
	for filename in [f for f in os.listdir(dirname)]:
		dataFile = open(os.path.join(dirname, filename), 'r')
		temperature = []
		enthalpy = []
		list_data_tuple = []
		for line in dataFile:
			splitline = line.strip().split()
			temperature.append(float(splitline[0]))
			enthalpy.append(float(splitline[1]))
		dataFile.close()
		TK_dict[filename.split('.')[0]] = (np.array(temperature), np.array(enthalpy))
	return TK_dict
	
def get_area(filename):
	""" Get the ASA from the sequences """
	ASA_dict = {}
	with open(filename, 'r') as f:
		for line in f:
			line = line.strip().split()
			ASA_dict[line[0]] = line[1:]
	return ASA_dict
	
def fit_H(xvals, yvals, fig, lab, col):
	""" fit eqn5 to estimate the value of gamma and the enthalpy offset """
	T_0 = 343.15	# Temperature with strongest hydrophobic effect
	xvals = [x+273.15 for x in xvals] # convert temperature from Celsius to Kelvin
	def Enthalpy(T, gamma, Eint):
		""" Equation 5 manuscript """
		return gamma *(T_0**2 - T**2) + Eint
	
	params, cov = curve_fit(Enthalpy, xvals, yvals)
	gamma = params[0]
	Eint = params[1]
	if 'syn' in lab:
		# Fibril into monomer
		fig.plot(xvals[3:], yvals[3:], 'o', color=col, label=lab + r'_fm: $\gamma$=%.2E' % gamma)
		# Monomer into fibril
		fig.plot(xvals[:3], yvals[:3], 'o', color='C7', label=lab + r'_mf: $\gamma$=%.2E' % gamma)
	else:
		fig.plot(xvals, yvals, 'o', color=col, label=lab + r': $\gamma$=%.2E' % gamma)
	
	if 'phenyl' in lab or 'GNN' in lab:
		plt.plot([280]+sorted(list(xvals))+[340], Enthalpy(np.array([280]+sorted(list(xvals))+[340]), gamma, Eint), 'b', color=col, dashes=[1, 2, 6, 2])
	elif 'syn' in lab:
		plt.plot([280]+sorted(list(xvals))+[340], Enthalpy(np.array([280]+sorted(list(xvals))+[340]), gamma, Eint), 'b', color=col)
		plt.plot([280]+sorted(list(xvals))+[340], Enthalpy(np.array([280]+sorted(list(xvals))+[340]), gamma, Eint), 'b', color='C7', dashes=[4, 4])
	else:
		plt.plot([280]+sorted(list(xvals))+[340], Enthalpy(np.array([280]+sorted(list(xvals))+[340]), gamma, Eint), 'b', color=col)

	return gamma, Eint, fig

def main():
	dir_in = 'TvsH_all'
	
	coord_dict = get_data(dir_in)
	ASA_dict = get_area('ASA\\hydr_ASA_fibrils.txt')
	
	f_out = open('Fits_combined.txt', 'w')
	f_out.write('Protein\tC_h\tgamma\tEint\n')
	
	labels = ['L-phenylalanine', 'di-phenylalanine', 'Glucagon', r'$\alpha$-synuclein', r'$\beta$-2-microglobulin', r'$\alpha$-lactalbumin', 'GNNQQNY']
	
	i = 0
	plt.figure(figsize=(6.67,7.5))
	gs = gridspec.GridSpec(2, 1, height_ratios=[1, 3])
	fig = plt.subplot(gs[1])
	fig.plot(range(280, 350, 10), [0]*len(range(280, 350, 10)), 'b', label=r'$\Delta H = 0$', color='black', dashes=[4, 2], linewidth=0.8)
	
	keys = coord_dict.keys()
	print keys
	order = ['L-phe', 'di-phe', 'gluc', 'syn', 'mic', 'lac', 'GNNQQNY']
	for i in range(len(order)):
		x = order[i]
		print x
		if x == 'gluc':
			gluc_keys = [v for v in keys if x in v or 'Data' in v]
			colors = ['C2', 'g', 'C8']
			newkey = 'glucagon'
			area = ASA_dict[newkey][1]
			for j in range(len(gluc_keys)):
				key = gluc_keys[j]
				gamma, Eint, fig = fit_H(coord_dict[key][0], coord_dict[key][1], fig, labels[i]+r'$^%d$'%(j+1), colors[j])
				f_out.write('%s\t%s\t%.2E\t%f\n' % (key, area, gamma, Eint))
		else:
			key = [v for v in keys if x in v][0]
			newkey = key
			area = ASA_dict[newkey][1]
			gamma, Eint, fig = fit_H(coord_dict[key][0], coord_dict[key][1], fig, labels[i], 'C' + `i`)
			f_out.write('%s\t%s\t%.2E\t%f\n' % (key, area, gamma, Eint))
		i += 1


	plt.xlabel('Temperature (K)')
	plt.ylabel(r'$\Delta H$ $\left(\frac{kJ}{mol}\right)$')	
	fig.legend(bbox_to_anchor=(0., 1.02, 1., .102), loc=3, borderaxespad=0., ncol=2)
	plt.savefig('Fits_combined.png')
	plt.show()

if __name__ == '__main__':
	main()