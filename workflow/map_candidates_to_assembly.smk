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


rule bwa_index_hifiasm_assembly:
    input:
        "input/hifiasm_10k_q30.asm.bp.p_ctg.gfa.fasta",
    output:
        idx=multiext(
            "results/bwa/hifiasm_10k_q30_index/hifiasm_10k_q30",
            ".amb",
            ".ann",
            ".bwt",
            ".pac",
            ".sa",
        ),
    log:
        "logs/bwa_index/hifiasm_10k_q30.log",
    params:
        algorithm="bwtsw",
    wrapper:
        "v1.24.0/bio/bwa/index"


rule map_bwa_candidates_hifiasm_assembly:
    input:
        reads=["external_data/candidates_filtered_contigs.fasta"],
        idx=multiext(
            "results/bwa/hifiasm_10k_q30_index/hifiasm_10k_q30",
            ".amb",
            ".ann",
            ".bwt",
            ".pac",
            ".sa",
        ),
    output:
        "results/bwa/candidates_hifiasm_10k_q30.sam",
    log:
        "logs/bwa_mem/candidates_hifiasm_10k_q30.log",
    params:
        extra=r"-R '@RG\tID:candidates_hifiasm_10k_q30\tSM:candidates_hifiasm_10k_q30' -x intractg",
        sorting="samtools",  # Can be 'none', 'samtools' or 'picard'.
        sort_order="coordinate",  # Can be 'queryname' or 'coordinate'.
        sort_extra="",  # Extra args for samtools/picard.
    threads: 8
    wrapper:
        "v1.24.0/bio/bwa/mem"
