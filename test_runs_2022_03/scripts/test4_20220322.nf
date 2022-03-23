#!/usr/bin/env nextflow

params.reads="/data01/nextflow_test/2022_test/play2/Folder2/*/*_{1,2}.fastq"

println "This is the fastq files $params.reads variable"

/*
 * Create the `read_pairs_ch` channel that emits tuples containing three elements:
 * the pair ID, the first read-pair file and the second read-pair file
 */

Channel
    .fromFilePairs( params.reads )
    .ifEmpty { error "Cannot find any reads matching: ${params.reads}" }
    .set { read_pairs_ch } /* we will use this channel */

process spadesAssembly {

	cpus 48

	input:
	tuple val(pair_id), path(reads) from read_pairs_ch

	output:
	publishDir "assembled_contigs"
	path "${pair_id}_spades/contigs.fasta" into contigs1
	publishDir "assembled_contigs_absolute_files"
	file "${pair_id}_spades/contigs.fasta" into contigs2 /* using file or path command writes the symbolic link to the publishDir folders */


	script:
	"""
	spades.py --pe1-1 ${reads[0]} --pe1-2 ${reads[1]} -o "${pair_id}"_spades --careful -t $task.cpus >>"${pair_id}"_log_spades
	"""
}