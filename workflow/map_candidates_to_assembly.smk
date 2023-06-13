rule minimap_candidates_vulgaris_assembly:
    input:
        target="input/hifiasm_10k_q30.asm.bp.p_ctg.gfa.fasta",  # can be either genome index or genome fasta
        query="external_data/candidates_filtered_contigs.fasta",
    output:
        "results/aligned_hifiasm/candidates_filtered_contigs.sorted.bam",
    log:
        "logs/minimap2/hifiasm_candidates_filtered_contigs.log",
    params:
        extra="-x sr --eqx",  # optional
        sorting="coordinate",  # optional: Enable sorting. Possible values: 'none', 'queryname' or 'coordinate'
        sort_extra="",  # optional: extra arguments for samtools/picard
    benchmark:
        "benchmarks/minimap2/hifiasm_candidates_filtered_contigs.log"
    threads: 3
    wrapper:
        "v1.23.1/bio/minimap2/aligner"


