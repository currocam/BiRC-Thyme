rule ragtag_correct:
    input:
        reference="external_data/GCA_024222315.1_ASM2422231v1_genomic.fna",
        query="input/hifiasm_10k_q30.asm.bp.p_ctg.gfa.fasta",
        exclude="external_data/non_chromosomes_GCA_024222315.1.txt",
    conda:
        "envs/ragtag.yaml"
    log:
        "logs/ragtag/corrected/hifiasm_10k_q30_GCA_024222315.log",
    output:
        directory("results/ragtag_corrected/hifiasm_10k_q30_GCA_024222315"),
    params:
        extra="-u",  #  add suffix to unplaced sequence headers
    threads: 3
    shell:
        "ragtag.py correct {input.reference} {input.query} "
        "-t {threads} -e {input.exclude} {params.extra} "
        "-o {output} 2> {log}"


rule ragtag_scaffold_all:
    input:
        reference="external_data/GCA_024222315.1_ASM2422231v1_genomic.fna",
        query="input/hifiasm_10k_q30.asm.bp.p_ctg.gfa.fasta",
    conda:
        "envs/ragtag.yaml"
    log:
        "logs/ragtag/hifiasm_10k_q30_GCA_024222315_default_all.log",
    output:
        directory("results/ragtag_scaffold/hifiasm_10k_q30_GCA_024222315_default_all"),
    params:
        extra="-u",  #  add suffix to unplaced sequence headers
    threads: 3
    shell:
        "ragtag.py scaffold {input.reference} {input.query} "
        "-t {threads} {params.extra} "
        "-o {output} 2> {log}"


rule ragtag_scaffold:
    input:
        reference="external_data/GCA_024222315.1_ASM2422231v1_genomic.fna",
        query="input/hifiasm_10k_q30.asm.bp.p_ctg.gfa.fasta",
        exclude="external_data/non_chromosomes_GCA_024222315.1.txt",
    conda:
        "envs/ragtag.yaml"
    log:
        "logs/ragtag/scaffold_hifiasm_10k_q30_GCA_024222315.log",
    output:
        directory("results/ragtag_scaffold/hifiasm_10k_q30_GCA_024222315_default"),
    params:
        extra="-u",  #  add suffix to unplaced sequence headers
    threads: 3
    shell:
        "ragtag.py scaffold {input.reference} {input.query} "
        "-t {threads} -e {input.exclude} {params.extra} "
        "-o {output} 2> {log}"

rule ragtag_scaffold_final:
    input:
        reference="external_data/GCA_024222315.1_ASM2422231v1_genomic.fna",
        query="input/hifiasm_10k_q30.asm.bp.p_ctg.gfa.fasta",
    conda:
        "envs/ragtag.yaml"
    log:
        "logs/ragtag/scaffold_10k_q30_GCA_024222315_infergaps.log",
    output:
        directory("results/ragtag_scaffold/scaffold_10k_q30_GCA_024222315_infergaps"),
    params:
        extra="-r",  # infer gap sizes
    threads: 3
    shell:
        "ragtag.py scaffold {input.reference} {input.query} "
        "-t {threads} {params.extra} "
        "-o {output} 2> {log}"
