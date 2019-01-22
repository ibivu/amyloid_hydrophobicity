#!/usr/bin/python

from sys import argv
import os

#os.chdir(os.path.dirname(argv[0]))

# Read FASTA sequences
seqs = {}
sequence = ''
with open('seqs.fasta', 'r') as f:
	for line in f:
		line = line.strip()
		if line.startswith('>'):
			if not sequence == '':
				seqs[label] = sequence
				sequence = ''
			label = line[1:]
		else:
			sequence += line
	seqs[label] = sequence
		
### Read values corresponding to each aminoacid from file into Dictionary 
### Set all non-hydrophobic aa values to zero 
### use definition from van Dijk Phys. Rev. Lett. 2016
with open('AccUnfold.data','r') as ASA:
	aa_values = {}
	for line in ASA:
		read_aminoacids = line.strip().split()
		aa_values[read_aminoacids[0]] = int(read_aminoacids[2])		

def calculate_ASA(seq):
	'''
	Calculates ASA of proteins based on the aminoacids in their FASTA sequences
	Input:
		- list of protein FASTA-sequences given as strings  
	Output:
		- list of ASA values 
	'''
	hydrophobic_aa = ["A","F","C","L","I","W","V","M","Y"]
	ASA_total = 0
	sum_total = 0
	for aminoacid in seq: 
		if aminoacid in hydrophobic_aa:
			ASA_total += aa_values[aminoacid]
		sum_total += aa_values[aminoacid]
		
	ASA_rel = float(ASA_total) / sum_total
	return ASA_total, ASA_rel

keys = ['alpha-lactalbumin', 'glucagon', 'alpha-synuclein', 'beta-2-microglobulin', 'L-phenylalanine', 'di-phenylalanine', 'GNNQQNY']
with open('hydr_ASA_fibrils.txt', 'w') as fout:
	for key in keys:
		asa_total, asa_rel = calculate_ASA(seqs[key])
		fout.write('%s\t%s\t%d\t%f\n' % (key, seqs[key], asa_total, asa_rel))