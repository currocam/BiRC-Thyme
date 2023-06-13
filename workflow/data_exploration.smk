# Filter long reads by quality
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



# Align long reads to reference
rule minimap2_bam_sorted_best_5_perc:
    input:
        target=T_QUINQUECOSTATUS_GENOME,  # can be either genome index or genome fasta
        query="results/filtered/THYME_607L_hifi_best_5_perc.fastq.gz",
    output:
        "results/aligned/chr_aln_best_5_perc.sorted.bam",
    log:
        "logs/minimap2/chr_aln_best_5_perc.log",
    params:
        extra="-x map-hifi",  # optional
        sorting="coordinate",  # optional: Enable sorting. Possible values: 'none', 'queryname' or 'coordinate'
        sort_extra="",  # optional: extra arguments for samtools/picard
    benchmark:
        "benchmarks/minimap2/chr_aln_best_5_perc.log"
    threads: 3
    wrapper:
        "v1.23.1/bio/minimap2/aligner"

# Filter bam file only primary alignments
rule samtools_view:
    input:
        "results/aligned/chr_aln_best_5_perc.sorted.bam",
    output:
        bam="results/aligned/chr_aln_best_5_perc_primary_only.bam",
        idx="results/aligned/chr_aln_best_5_perc_primary_only.bam.bai",
    log:
        "logs/minimap2/chr_aln_best_5_perc_samtools_view.log",
    params:
        extra="-F 1796",  # exclude read unmapped (0x4), not primary alignment (0x100), read fails platform/vendor quality checks (0x200), read is PCR or optical duplicate (0x400)
    threads: 2
    wrapper:
        "v2.0.0/bio/samtools/view"

# Compute windows
rule pysamstats_coverage_binned:
    input:
        bamfile="results/aligned/chr_aln_best_5_perc_primary_only.bam",
        fastafile=T_QUINQUECOSTATUS_GENOME,
    output:
        "results/aligned_stats/binned_coverage.txt",
    conda:
        "envs/pysamstats.yaml"
    shell:
        "pysamstats --type coverage_binned "
        "--window-size 1000 "
        "--fasta {input.fastafile} "
        "{input.bamfile} > {output}"