## This Nextflow pipeline does 1) FastQC 2) Trims adapters and quality filtering on Illumina reads 3) Runs Spades assembly



#!/usr/bin/env nextflow
 
params.reads = "/data01/nextflow_test/shortReads_fastq_file_processing/Illumina_data/*_{1,2}.fq.gz"
params.in = "/data01/nextflow_test/shortReads_fastq_file_processing/Illumina_data/*.fq.gz"
sequences = file(params.in)


/*
 * do a fastqc on the reads
 */
 
process fastqc{
	tag "$id"
	publishDir '/data01/nextflow_test/shortReads_fastq_file_processing/rawFastQC'
	
	input:
	file reads from sequences
	
	output:
	file '*_fastqc_logs' into fastqc_output
		
script:
	"""
	mkdir ${reads.baseName}_fastqc_logs
	fastqc -o ${reads.baseName}_fastqc_logs -f fastq -q ${reads}
	"""
}


Channel 
    .fromFilePairs( params.reads )
    .ifEmpty { error "Cannot find any reads matching: ${params.reads}"  }
    .set { read_pairs } 
 

//process 1: Adapter and quality trimming

process bbduk {
        tag {pair_id}
        publishDir 'bbduk'

        input:
        set pair_id, file(reads) from read_pairs

        output:
        set pair_id, file("*.bbmap_adaptertrimmed.fastq") into fastqc_input, spades_input
        file "${pair_id}.stats.txt"


        script:
        """
         /home/prakki/sw/bbmap/bbduk.sh -Xmx6g in1=${reads[0]} in2=${reads[1]} out1=${reads[0].baseName}.bbmap_adaptertrimmed.fastq  out2=${reads[1].baseName}.bbmap_adaptertrimmed.fastq ref=/home/prakki/sw/bbmap/resources/adapters.fa stats=${pair_id}.stats.txt ktrim=r k=23 mink=11 hdist=1 qtrim=rl trimq=10 minavgquality=10
         """
}

//process 2: Spades assembly

process spades {
        tag {pair_id}
        publishDir 'spades_output'

        input:
        set pair_id, file(reads) from spades_input

        output:
        set pair_id, file("spades_output/contigs.fasta") into spades_output
        file "spades_output/contigs.fasta"


        script:
        """
        /home/prakki/sw/SPAdes-3.13.0/bin/spades.py  --careful --threads ${task.cpus} --pe1-1 ${reads[0]} --pe1-2 ${reads[1]} -o spades_output
         """
}
