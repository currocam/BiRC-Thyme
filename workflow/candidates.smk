# Map candidates to raw reads
rule bwa_index_long_reads:
    input:
        "input/THYME_607L_hifi.fastq.gz",
    output:
        idx=multiext("input/THYME_607L_hifi", ".amb", ".ann", ".bwt", ".pac", ".sa"),
    log:
        "logs/bwa_index/THYME_607L_hifi.log",
    params:
        algorithm="bwtsw",
    wrapper:
        "v1.24.0/bio/bwa/index"


rule map_bwa_candidates_loci:
    input:
        reads=["external_data/candidates_filtered_contigs.fasta"],
        idx=multiext("input/THYME_607L_hifi", ".amb", ".ann", ".bwt", ".pac", ".sa"),
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

# Map candidates to de novo assembly
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

# Map candidates to the novo assembly

rule bwa_index_scaffold_assembly:
    input:
        "results/ragtag_scaffold/hifiasm_10k_q30_GCA_024222315_default/ragtag.scaffold.fasta",
    output:
        idx=multiext(
            "results/bwa/ragtag/hifiasm_10k_q30", ".amb", ".ann", ".bwt", ".pac", ".sa"
        ),
    log:
        "logs/bwa_index/ragtag_hifiasm_10k_q30.log",
    params:
        algorithm="bwtsw",
    wrapper:
        "v1.24.0/bio/bwa/index"


rule map_bwa_candidates_scaffold_assembly:
    input:
        reads=["external_data/candidates_filtered_contigs.fasta"],
        idx=multiext(
            "results/bwa/ragtag/hifiasm_10k_q30", ".amb", ".ann", ".bwt", ".pac", ".sa"
        ),
    output:
        "results/bwa/candidates_hifiasm_10k_q30_ragtag.sam",
    log:
        "logs/bwa_mem/candidates_hifiasm_10k_q30_ragtag.log",
    params:
        extra=r"-R '@RG\tID:candidates_hifiasm_10k_q30_ragtag\tSM:candidates_hifiasm_10k_q30_ragtag' -x intractg",
        sorting="samtools",  # Can be 'none', 'samtools' or 'picard'.
        sort_order="coordinate",  # Can be 'queryname' or 'coordinate'.
        sort_extra="",  # Extra args for samtools/picard.
    threads: 8
    wrapper:
        "v1.24.0/bio/bwa/mem"


rule bwa_index_scaffold_assembly_all:
    input:
        "results/ragtag_scaffold/hifiasm_10k_q30_GCA_024222315_default_all/ragtag.scaffold.fasta",
    output:
        idx=multiext(
            "results/bwa/ragtag/hifiasm_10k_q30_all",
            ".amb",
            ".ann",
            ".bwt",
            ".pac",
            ".sa",
        ),
    log:
        "logs/bwa_index/hifiasm_10k_q30_GCA_024222315_default_all.log",
    params:
        algorithm="bwtsw",
    wrapper:
        "v1.24.0/bio/bwa/index"


rule map_bwa_candidates_scaffold_assembly_all:
    input:
        reads=["external_data/candidates_filtered_contigs.fasta"],
        idx=multiext(
            "results/bwa/ragtag/hifiasm_10k_q30_all",
            ".amb",
            ".ann",
            ".bwt",
            ".pac",
            ".sa",
        ),
    output:
        "results/bwa/candidates_hifiasm_10k_q30_ragtag_all.sam",
    log:
        "logs/bwa_mem/candidates_hifiasm_10k_q30_ragtag_all.log",
    params:
        extra=r"-R '@RG\tID:candidates_hifiasm_10k_q30_ragtag_all\tSM:candidates_hifiasm_10k_q30_ragtag_all' -x intractg",
        sorting="samtools",  # Can be 'none', 'samtools' or 'picard'.
        sort_order="coordinate",  # Can be 'queryname' or 'coordinate'.
        sort_extra="",  # Extra args for samtools/picard.
    threads: 8
    wrapper:
        "v1.24.0/bio/bwa/mem"
