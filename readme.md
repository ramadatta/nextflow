### Simple script version 1

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

### Simple script version 2
