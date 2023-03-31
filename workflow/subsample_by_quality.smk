rule filtlong:
    input:
        "results/trimmed/{sample}.fastq",
    output:
        "results/filtered/{sample}_best_{percentage}_perc.fastq.gz",
    conda:
        "envs/filtlong.yaml"
    benchmark:
        "benchmarks/filtlong/{sample}_{percentage}.log"
    shell:
        "filtlong --keep_percent {wildcards.percentage} {input} | gzip > {output}"


rule subsample:
    input:
        "results/filtered/THYME_607L_hifi_best_1_perc.fastq.gz",
    output:
        "results/filtered/subsample_1000.fastq.gz",
    params:
        num_sequences=1000 * 4,  # Replace with the desired number of sequences
    shell:
        "zcat {input} | head -n {params.num_sequences} | gzip > {output}"
