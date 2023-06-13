rule scaffold_infer_gaps:
    input:
        query="input/THYME_607L_hifi.fastq.gz",
        ref=T_QUINQUECOSTATUS_GENOME,
    output:
        fasta=f"{RAGTAG_OUTDIR}/scaffold_10k_q30_GCA_024222315_infergaps/ragtag.scaffold.fasta",
        agp=f"{RAGTAG_OUTDIR}/scaffold_10k_q30_GCA_024222315_infergaps/ragtag.scaffold.agp",
        stats=f"{RAGTAG_OUTDIR}/scaffold_10k_q30_GCA_024222315_infergaps/ragtag.scaffold.stats",
    params:
        extra="-r",  # infer gap sizes
    threads: 3
    log:
        "logs/ragtag/scaffold_10k_q30_GCA_024222315_infergaps.log",
    wrapper:
        "v2.0.0/bio/ragtag/scaffold"

rule scaffold_default:
    input:
        query="input/THYME_607L_hifi.fastq.gz",
        ref=T_QUINQUECOSTATUS_GENOME,
    output:
        fasta=f"{RAGTAG_OUTDIR}/hifiasm_10k_q30_GCA_024222315_default_all/ragtag.scaffold.fasta",
        agp=f"{RAGTAG_OUTDIR}/hifiasm_10k_q30_GCA_024222315_default_all/ragtag.scaffold.agp",
        stats=f"{RAGTAG_OUTDIR}/hifiasm_10k_q30_GCA_024222315_default_all/ragtag.scaffold.stats",
    params:
        extra="-u",  #  add suffix to unplaced sequence headers
    threads: 3
    log:
        "logs/ragtag/hifiasm_10k_q30_GCA_024222315_default_all.log",
    wrapper:
        "v2.0.0/bio/ragtag/scaffold"