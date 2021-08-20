(Most latest nextflow script on top - Earliest scripts go bottom)

### minipipeline-sr3.nf

This Nextflow pipeline does 
1) FastQC 
2) Trims adapters and quality filtering on Illumina reads 
3) Runs short read Spades assembly

```
$ time nextflow minipipeline-sr3.nf 
N E X T F L O W  ~  version 21.04.3
Launching `minipipeline-sr3.nf` [determined_bose] - revision: 73d0117dc7
executor >  local (12)
[c6/02f475] process > fastqc (null)                                 [100%] 6 of 6 ✔
[80/8823d3] process > bbduk (N16003_DDMS210004241-1a_HFMWLDSX2_L2)  [100%] 3 of 3 ✔
[09/8692af] process > spades (N16003_DDMS210004241-1a_HFMWLDSX2_L2) [100%] 3 of 3 ✔
Completed at: 16-Aug-2021 16:04:23
Duration    : 2h 42m 50s
CPU hours   : 7.2
Succeeded   : 12



real	162m52.445s
user	434m33.407s
sys	7m49.247s
```


### toyPipeline1.nf

The first version of the nextflow script take a single fasta file
1) counts the number of sequences in a fasta file
2) calculates the genome size of fasta

```
$ time nextflow toyPipeline1.nf

N E X T F L O W  ~  version 21.04.3
Launching `toyPipeline1.nf` [silly_montalcini] - revision: a2aeb90791
executor >  local (3)
[85/bd7b64] process > newSeqFile [100%] 1 of 1 ✔
[83/13c256] process > count      [100%] 1 of 1 ✔
[61/070271] process > calculate  [100%] 1 of 1 ✔
3

5281967

real	0m3.757s
user	0m6.669s
sys	0m1.052s
```

