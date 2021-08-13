#!/usr/bin/env nextflow
 

params.in = "/data01/nextflow_test/beginner/sample.fa"
 
/*
 * copy a fasta file into another fasta file 
 */
process newSeqFile {
 
    input:
    path 'input.fa' from params.in
 
    output:
    path 'new.fa' into records1
 
    """
    cat input.fa >new.fa
    """
}
 
/*
 * Count the number of sequences in each assembly
 */
process count {
 
    input:
    path x from records1
     
    output:
    stdout into result1
 
    """
    grep -c '>' $x 
    """
}
 
/*
 * print the channel content
 */
result1.subscribe { println it }

/*
 * Calculate genome size from assembly
 */
process calculate {
 
    input:
    path x from records1
     
    output:
    stdout into result2
 
    """
    grep -v '>' $x | wc -c
    """
}
 
/*
 * print the channel content
 */
result2.subscribe { println it }
