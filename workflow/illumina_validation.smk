rule bwa_index_scaffold_assembly_infergaps:
    input:
        "results/ragtag_scaffold/scaffold_10k_q30_GCA_024222315_infergaps/ragtag.scaffold.fasta",
    output:
        idx=multiext(
            "results/bwa_illumina/ragtag/assembly_infergaps",
            ".amb",
            ".ann",
            ".bwt",
            ".pac",
            ".sa",
        ),
    log:
        "logs/bwa_index/assembly_infergaps.log",
    params:
        algorithm="bwtsw",
    wrapper:
        "v1.24.0/bio/bwa/index"


rule bwa_mem_illumina:
    input:
        reads=["input/illumina/{sample}_r1.fq.gz", "input/illumina/{sample}_r2.fq.gz"],
        idx=multiext(
            "results/bwa_illumina/ragtag/assembly_infergaps",
            ".amb",
            ".ann",
            ".bwt",
            ".pac",
            ".sa",
        ),
    output:
        temporary("results/bwa_illumina/{sample}.bam"),
    log:
        "logs/bwa_mem/{sample}.log",
    params:
        extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
        sorting="none",  # Can be 'none', 'samtools' or 'picard'.
        sort_order="queryname",  # Can be 'queryname' or 'coordinate'.
        sort_extra="",  # Extra args for samtools/picard.
    threads: 4
    wrapper:
        "v1.25.0/bio/bwa/mem"


rule bwa_mem_illumina_flagstat:
    input:
        "results/bwa_illumina/{sample}.bam",
    output:
        "results/bwa_illumina/{sample}.bam.flagstats",
    threads: 1
    shell:
        "samtools flagstat {input} > {output}"


rule bwa_mem_illumina_stat:
    input:
        "results/bwa_illumina/{sample}.bam",
    output:
        "results/bwa_illumina/{sample}.bam.stats",
    threads: 1
    conda:
        "envs/samtools.yaml"
    shell:
        "samtools stats {input} > {output}"


rule bwa_mem_illumina_sort:
    input:
        "results/bwa_illumina/{sample}.bam",
    output:
        "results/bwa_illumina/{sample}_sorted.bam",
    threads: 1
    conda:
        "envs/samtools.yaml"
    shell:
        "samtools sort -o {output} {input}"


rule bwa_mem_illumina_index:
    input:
        "results/bwa_illumina/{sample}_sorted.bam",
    output:
        "results/bwa_illumina/{sample}_sorted.bam.bai",
    conda:
        "envs/samtools.yaml"
    threads: 1
    shell:
        "samtools index {input}"


rule count_mapped_to_references:
    input:
        bam="results/bwa_illumina/{sample}_sorted.bam",
        index="results/bwa_illumina/{sample}_sorted.bam.bai",
    output:
        "analysis/03-count_illumina_reads_assembly/counts/{sample}.csv",
    conda:
        "envs/seqkit.yaml"
    shell:
        "seqkit bam -C {input.bam} 2> {output}"
