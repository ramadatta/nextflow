
### 1. Speed up the nextflow process using cpus

```
process index {

    cpus 64  /* added cpu to the original script */ 

    input:
    path transcriptome from params.transcript
     
    output:
    path 'index' into index_ch

    script:       
    """
    salmon index --threads $task.cpus -t $transcriptome -i index
    """
}
```
