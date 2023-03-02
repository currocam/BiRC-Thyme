## Quality control

- [FastQC Report](results/qc/fastqc/THYME_607L_hifi.html) -> results/qc/fastqc/THYME_607L_hifi.html
- [LongQC Report](https://github.com/yfukasawa/LongQC) -> results/qc/longqc/THYME_607L_hifi/web_summary.html . This step was ran using PacBio HiFi mode. 

## Trimmed reads

Trimmed reads were obtained using [LongQC Report](https://github.com/yfukasawa/LongQC). This step was ran using PacBio HiFi mode. -> results/trimmed/THYME_607L_hifi.fastq

## Filtered reads

Trimmed reads were filtered by quality using [LongQC Report](https://github.com/yfukasawa/LongQC). This step was ran using PacBio HiFi mode. -> results/trimmed/THYME_607L_hifi.fastq

## Aligned reads

Filtered reads were mapped to GCA_024222315.1_ASM2422231v1_genomic.fna.gz (*Thymus quinquecostatus* genome) using Minimap2 with PacBio HiFi mode. -> results/aligned/*

## Summary

Different summary csv files for counts, coverage and zeros (work in progress). Inspect workflow/notebooks to learn more. 