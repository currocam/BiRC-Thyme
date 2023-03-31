rule bwa_index:
    input:
        "external_data/GCA_024222315.1_ASM2422231v1_genomic.fna",
    output:
        idx=multiext("results/bwa/GCA_024222315", ".amb", ".ann", ".bwt", ".pac", ".sa"),
    log:
        "logs/bwa_index/GCA_024222315.log",
    params:
        algorithm="bwtsw",
    wrapper:
        "v1.24.0/bio/bwa/index"


rule bwa_mem_subsample:
    input:
        reads=["results/filtered/subsample_1000.fastq.gz"],
        idx=multiext("results/bwa/GCA_024222315", ".amb", ".ann", ".bwt", ".pac", ".sa"),
    output:
        "results/bwa/subsample_1000.sam",
    log:
        "logs/bwa_mem/subsample.log",
    params:
        extra=r"-R '@RG\tID:subsample\tSM:subsample' -x intractg",
        sorting="samtools",  # Can be 'none', 'samtools' or 'picard'.
        sort_order="coordinate",  # Can be 'queryname' or 'coordinate'.
        sort_extra="",  # Extra args for samtools/picard.
    threads: 8
    wrapper:
        "v1.24.0/bio/bwa/mem"


rule minimap2_bam_sorted_subsample:
    input:
        target="results/minimap2_index/GCA_024222315.1_ASM2422231v1_genomic.mmi",  # can be either genome index or genome fasta
        query="results/filtered/subsample_1000.fastq.gz",
    output:
        "results/aligned/sub_sample_1000.sorted.bam",
    log:
        "logs/minimap2/subsample.log",
    params:
        extra="-x map-hifi",  # optional
        sorting="coordinate",  # optional: Enable sorting. Possible values: 'none', 'queryname' or 'coordinate'
        sort_extra="",  # optional: extra arguments for samtools/picard
    threads: 3
    wrapper:
        "v1.23.1/bio/minimap2/aligner"


rule bwa_mem:
    input:
        reads="results/filtered/THYME_607L_hifi_best_5_perc.fastq.gz",
        idx=multiext("results/bwa/GCA_024222315", ".amb", ".ann", ".bwt", ".pac", ".sa"),
    output:
        "results/bwa/best_5_perc_aligned.sam",
    log:
        "logs/bwa_mem/best_5_perc.log",
    params:
        extra=r"-R '@RG\tID:subsample\tSM:subsample' -x intractg",
        sorting="none",  # Can be 'none', 'samtools' or 'picard'.
        sort_order="queryname",  # Can be 'queryname' or 'coordinate'.
        sort_extra="",  # Extra args for samtools/picard.
    threads: 8
    wrapper:
        "v1.24.0/bio/bwa/mem"


rule minimap2_index_reference_genome:
    input:
        target="external_data/{input1}.fna.gz",
    output:
        "results/minimap2_index/{input1}.mmi",
    log:
        "logs/minimap2_index/{input1}.log",
    params:
        extra="",  # no optional additional args
    threads: 3
    wrapper:
        "v1.23.1/bio/minimap2/index"


rule minimap2_bam_sorted_best_1_perc:
    input:
        target="results/minimap2_index/{input1}.mmi",  # can be either genome index or genome fasta
        query="results/filtered/THYME_607L_hifi_best_1_perc.fastq.gz",
    output:
        "results/aligned/{input1}_aln_best_1_perc.sorted.bam",
    log:
        "logs/minimap2/{input1}.log",
    params:
        extra="-x map-hifi",  # optional
        sorting="coordinate",  # optional: Enable sorting. Possible values: 'none', 'queryname' or 'coordinate'
        sort_extra="",  # optional: extra arguments for samtools/picard
    threads: 3
    wrapper:
        "v1.23.1/bio/minimap2/aligner"


rule minimap2_bam_sorted_best_5_perc:
    input:
        target="external_data/GCA_024222315.1_ASM2422231v1_genomic.fna.gz",  # can be either genome index or genome fasta
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
