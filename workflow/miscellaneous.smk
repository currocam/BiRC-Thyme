rule subset_reference_genome:
    input:
        "external_data/GCA_024222315.1_ASM2422231v1_genomic.fna.gz",
    output:
        "results/reference/GCA_024222315.1_ASM2422231v1_genomic_chromosomes.fna.gz",
    params:
        awk="""awk '/^>/ {P=index($0,"JANAFA0")==0} {if(P) print}'""",
    shell:
        """gunzip -c {input} | {params.awk} | gzip > {output}"""


rule filtered_distribution:
    input:
        "results/filtered/THYME_607L_hifi_best_5_perc.fastq.gz",
    output:
        "results/filtered/sequence_length_dist.txt",
    shell:
        "gunzip -c {input} | "
        "awk 'NR%4 == 2 {lengths[length($0)]++} END "
        "{for (l in lengths) {print l, lengths[l]}}' "
        "> {output}"


rule reference_bgzip:
    input:
        "external_data/GCA_024222315.1_ASM2422231v1_genomic.fna",
    output:
        "results/reference/GCA_024222315.1_ASM2422231v1_genomic.fasta.gz",
    conda:
        "envs/htslib.yaml"
    shell:
        "bgzip < {input} > {output}"
