#!/usr/bin/env nextflow

/* https://www.nextflow.io/docs/latest/faq.html */


params.seqs ="/data01/nextflow_test/2022_test/play2/Folder4/assembled_contigs/*_spades/*.fasta"

println "params.seqs has $params.seqs"


/* Since we have multiples files to process - we create a channel 

Each of the files in the data directory can be made into a channel. 
The best way to manage this is to have the channel emit a tuple containing both the file base name (E307) and the full file path (_spades/E307.fa):*/

fasta_files = Channel
                .fromPath(params.seqs)
                .map { file -> tuple(file.baseName, file) }

process assemblyStats {

	input:
	set datasetID, file(inputfasta) from fasta_files 

	output:
	publishDir 'assemblyStats'
	set datasetID, file("${datasetID}_bbstats.txt") into bbstats


	script:
	"""
	stats.sh in=$inputfasta >"${datasetID}_bbstats.txt"
	"""

}