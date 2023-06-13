rule scaffold:
    input:
        query="input/THYME_607L_hifi.fastq.gz",
        ref=T_QUINQUECOSTATUS_GENOME,
    output:
        fasta=f"{RAGTAG_OUTDIR}/ragtag.scaffold.fasta",
        agp=f"{RAGTAG_OUTDIR}/ragtag.scaffold.agp",
        stats=f"{RAGTAG_OUTDIR}/ragtag.scaffold.stats",
    params:
        extra="-r",  # infer gap sizes
    threads: 3
    log:
        "logs/ragtag/scaffold_10k_q30_GCA_024222315_infergaps.log",
    wrapper:
        "v2.0.0/bio/ragtag/scaffold"