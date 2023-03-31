
rule pysamstats_coverage_binned:
    input:
        bamfile="results/aligned/chr_aln_best_5_perc_primary_only.bam",
        fastafile="results/reference/GCA_024222315.1_ASM2422231v1_genomic.fasta.gz",
    output:
        "results/aligned_stats/binned_coverage.txt",
    conda:
        "envs/pysamstats.yaml"
    shell:
        "pysamstats --type coverage_binned "
        "--window-size 1000 "
        "--fasta {input.fastafile} "
        "{input.bamfile} > {output}"


rule pysamstats_coverage_subsample_minimap2:
    input:
        bamfile="results/aligned/sub_sample_1000.sorted.bam",
        fastafile="results/reference/GCA_024222315.1_ASM2422231v1_genomic.fasta.gz",
    output:
        "results/aligned_stats/coverage_subsample_minimap2.txt",
    conda:
        "envs/pysamstats.yaml"
    shell:
        "pysamstats --type coverage "
        "--fasta {input.fastafile} "
        "{input.bamfile} > {output}"


rule pysamstats_coverage_subsample_bwa:
    input:
        bamfile="results/bwa/subsample_1000.bam",
        fastafile="results/reference/GCA_024222315.1_ASM2422231v1_genomic.fasta.gz",
    output:
        "results/aligned_stats/coverage_subsample_bwa.txt",
    conda:
        "envs/pysamstats.yaml"
    shell:
        "pysamstats --type coverage "
        "--fasta {input.fastafile} "
        "{input.bamfile} > {output}"


rule pysamstats_coverage_binned_big:
    input:
        bamfile="results/aligned/chr_aln_best_5_perc_primary_only.bam",
        fastafile="results/reference/GCA_024222315.1_ASM2422231v1_genomic.fasta.gz",
    output:
        "results/aligned_stats/binned_coverage_big.txt",
    conda:
        "envs/pysamstats.yaml"
    shell:
        "pysamstats --type coverage_binned "
        "--window-size 25000 "
        "--fasta {input.fastafile} "
        "{input.bamfile} > {output}"
