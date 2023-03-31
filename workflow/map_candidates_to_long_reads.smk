rule bwa_index_long_reads:
    input:
        "reads/THYME_607L_hifi.fastq.gz",
    output:
        idx=multiext("reads/THYME_607L_hifi", ".amb", ".ann", ".bwt", ".pac", ".sa"),
    log:
        "logs/bwa_index/THYME_607L_hifi.log",
    params:
        algorithm="bwtsw",
    wrapper:
        "v1.24.0/bio/bwa/index"


rule map_bwa_candidates_loci:
    input:
        reads=["external_data/candidates_filtered_contigs.fasta"],
        idx=multiext("reads/THYME_607L_hifi", ".amb", ".ann", ".bwt", ".pac", ".sa"),
    output:
        "results/bwa/candidates_THYME_607L_hifi.sam",
    log:
        "logs/bwa_mem/candidates_THYME_607L_hifi.log",
    params:
        extra=r"-R '@RG\tID:candidates_THYME_607L_hifi\tSM:candidates_THYME_607L_hifi' -x intractg",
        sorting="samtools",  # Can be 'none', 'samtools' or 'picard'.
        sort_order="coordinate",  # Can be 'queryname' or 'coordinate'.
        sort_extra="",  # Extra args for samtools/picard.
    threads: 8
    wrapper:
        "v1.24.0/bio/bwa/mem"
