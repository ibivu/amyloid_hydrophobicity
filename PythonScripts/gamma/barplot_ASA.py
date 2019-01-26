#!/usr/bin/python
import os
from sys import argv
import matplotlib.pyplot as plt
#import matplotlib.axes as ax

# Synuclein sequence
asyn_2n0a_trunc = 'LYVGSKTKEGVVHGVATVAEKTKEQVTNVGGAVVTGVTAVAQKTVEGAGSIAAATGFVKK'

# Read the ASA per aa
#os.chdir(os.path.dirname(argv[0]))
with open('AccUnfold.data','r') as ASA:
	aa_values = {}
	for line in ASA:
		read_aminoacids = line.strip().split()
		aa_values[read_aminoacids[0]] = int(read_aminoacids[2])
		
# List of hydrophobic amino acids
AA_h = ['A', 'C', 'F', 'I', 'L', 'M', 'V', 'W', 'Y']

# Create list with values of contributions to the total hydrophobic surface area in the sequence
ASA_h = []
for i in range(len(asyn_2n0a_trunc)):
	res = asyn_2n0a_trunc[i]
	if res in AA_h:
		ASA_h.append(aa_values[res])
	else:
		ASA_h.append(0)
		
# Make barplot of the contributions
plt.figure(figsize=(15,1.5))
plt.bar(range(len(asyn_2n0a_trunc)), ASA_h)
plt.xticks([])
plt.ylabel(r'ASA$_{hydr}$ $\left( \.A^2 \right)$')
plt.savefig('sequence_bar.png')
plt.show()
