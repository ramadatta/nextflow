#!/usr/bin/env nextflow

/* split fasta files and count the bases for each fasta */

params.in="$PWD/in.fasta"

println "filename is $params.in"

process splitFasta {

	input:
	path 'input.fa' from params.in /* copying the fasta filepath into variable 'input.fa'*/

	output:
	path 'seq_*' into individualFastas /*seq files are passed to a channel individualFastas which can be used as an input to other process*/

	script: /* the below line takes variable 'input.fa' and generates 'seq_' files, these are passed to a channel individualFastas */
	"""
	awk '/^>/{f="seq_"++d} {print > f}' < input.fa 
	""" 
}

process combineFasta {

	input:
	path temp from individualFastas /* receive the seq_ files from channel individualFastas into variable temp - not using single quotes because multiple files are inputted */

	output:
	path 'CombinedFasta_files.fasta'  into mergedFastas /*CombinedFasta_files.fasta file is passed to a channel mergedFastas which can be used as an input to other process*/

	script: 
	"""
	cat $temp >CombinedFasta_files.fasta 
	""" 
}

process assemblySize {

	input:
	path 'temp' from mergedFastas /* receive the merged files from channel mergedFastas into variable temp - using single quotes because input is single file*/

	output:
	path 'assemblySize' into genomeSize /*genomeSize output is passed to a channel genomeSize which can be used as an input to other process*/

	script: /* the below line takes variable 'input.fa' and generates 'seq_' files, these are passed to a channel individualFastas */
	"""
	cat $temp | grep -v '>' | wc -c >assemblySize
	""" 
}