#!/usr/bin/env nextflow


/* Run Prokka Roary */


params.seqs = "/data01/nextflow_test/2022_test/play2/Folder4/assembled_contigs/*_spades/*.fasta"

println "$params.seqs"


fasta_files = Channel
				.fromPath(params.seqs)
                .map { file -> tuple(file.baseName, file) }


process Prokka{

	cpus 32

	input:
	set id, file(inputfasta) from fasta_files

	output:
	publishDir 'roary_gff_files'
	set id, file("${id}_prokka_out/${id}.gff") into roary_gff
	file("${id}_prokka_out/${id}.gff") into roary_gff2


	script:
	"""
	prokka --cpus $task.cpus --outdir "${id}_prokka_out" --prefix "${id}" $inputfasta >>prokka_log 2>>prokka_error
	
	"""
}


process Roary{

	cpus 32

	input:
	file gff from roary_gff2.collect()

	output:
	publishDir 'roary_output_files'
	file("*") into roary


	script:
	"""
	roary $gff
	
	"""
}
