rule all: 
    input: 
        "results/qc/fastqc/THYME_607L_hifi.html",
        "results/qc/longqc/THYME_607L_hifi"

rule fastqc:
    input:
        "reads/{sample}.fastq.gz"
    output:
        html="results/qc/fastqc/{sample}.html",
        zip="results/qc/fastqc/{sample}_fastqc.zip" # the suffix _fastqc.zip is necessary for multiqc to find the file. If not using multiqc, you are free to choose an arbitrary filename
    params: "--quiet"
    log:
        "logs/fastqc/{sample}.log"
    threads: 1
    wrapper:
        "v1.22.0/bio/fastqc"


rule longqc:
    input: 
        "reads/{sample}.fastq.gz"
    output:
        qc = directory("results/qc/longqc/{sample}"),
        trimmed = "results/trimmed/{sample}.fastq"
    params: "-x pb-hifi"
    log:
        "logs/longqc/{sample}.log"
    benchmark: 
        "benchmarks/longqc/{sample}.log"
    threads: 4
    container:
        "docker://grpiccolils/longqc"
    shell:
        "longQC sampleqc {input} "
        "-p {threads} {params} "
        "-o {output.qc} -c {output.trimmed} 2> {log}"