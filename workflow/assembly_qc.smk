rule run_busco_euk_ragtag:
    input:
        f"{RAGTAG_OUTDIR}/hifiasm_10k_q30_GCA_024222315_default_all/ragtag.scaffold.fasta",
    output:
        out_dir=directory("results/assembly_quality/txome_busco/hifiasm_10k_q30_GCA_024222315_default_all"),
        dataset_dir=directory("resources/busco_downloads"),
    log:
        "logs/busco/hifiasm_10k_q30_GCA_024222315_default_all.log",
    params:
        mode="genome",
        # optional parameters
        extra="--auto-lineage-euk",
    threads: 8
    wrapper:
        "v1.25.0/bio/busco"

rule run_busco_euk_hifiasm:
    input:
        "input/hifiasm_10k_q30.asm.bp.p_ctg.gfa.fasta",
    output:
        out_dir=directory("results/assembly_quality/txome_busco/hifiasm_10k_q30"),
        dataset_dir=directory("resources/busco_downloads"),
    log:
        "logs/busco/hifiasm_10k_q30.log",
    params:
        mode="genome",
        # optional parameters
        extra="--auto-lineage-euk",
    threads: 8
    wrapper:
        "v1.25.0/bio/busco"

