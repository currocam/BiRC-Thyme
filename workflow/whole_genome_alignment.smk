rule minimap2_paf:
    input:
        target="external_data/GCA_024222315.1_ASM2422231v1_genomic.fna",  # can be either genome index or genome fasta
        query="results/ragtag_scaffold/scaffold_10k_q30_GCA_024222315_infergaps/ragtag.scaffold.fasta",
    output:
        "whole_genome_alignment/scaffold_10k_q30_GCA_024222315_infergaps_aln.paf",
    log:
        "logs/minimap2/scaffold_10k_q30_GCA_024222315_infergaps.log",
    params:
        extra="",  # optional
        sorting="coordinate",  # optional: Enable sorting. Possible values: 'none', 'queryname' or 'coordinate'
        sort_extra="",  # optional: extra arguments for samtools/picard
    threads: 3
    wrapper:
        "v1.25.0/bio/minimap2/aligner"
