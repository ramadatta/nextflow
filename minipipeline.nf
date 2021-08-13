#!/usr/bin/env nextflow
 

params.reads = "/data01/nextflow_test/shortReads_fastq_file_processing/Illumina_data/*L2_{1,2}.fq.gz"

params.in = "/data01/nextflow_test/shortReads_fastq_file_processing/Illumina_data/*.fq.gz"
sequences = file(params.in)

/*
 * do a fastqc on the reads
 */
 
process fastqc{
input:
file reads from sequences

script:
	"""
	mkdir fastqc_logs
	fastqc -o fastqc_logs -f fastq -q ${reads}
	"""
}
