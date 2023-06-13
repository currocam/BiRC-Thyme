## Quality control

- [FastQC Report](results/qc/fastqc/THYME_607L_hifi.html) 
- `results/qc/fastqc/THYME_607L_hifi.html`

- [LongQC Report](https://github.com/yfukasawa/LongQC) . This step was ran using PacBio HiFi mode. 
- `results/qc/longqc/THYME_607L_hifi/web_summary.html`

## Trimmed reads

Trimmed reads were obtained using [LongQC](https://github.com/yfukasawa/LongQC). This step was ran using PacBio HiFi mode. 

- `results/trimmed/THYME_607L_hifi.fastq`

## Filtered long reads

Trimmed reads were filtered by quality using [Filtlong](https://github.com/rrwick/Filtlong). This step was ran using PacBio HiFi mode. 

- `results/filtered/THYME_607L_hifi_best_1_perc.fastq.gz`
- `results/filtered/THYME_607L_hifi_best_5_perc.fastq.gz`

## Aligned reads to *T. quinquecostatus*

Filtered long reads were mapped to the genome assembly of *T. quinquecostatus* genome using [Minimap2](https://github.com/lh3/minimap2) with PacBio HiFi mode.

- `results/aligned/*`

## Statistics of aligned reads to *T. quinquecostatus*

We compute the number of mapped long reads pero window using [pysamstats](https://github.com/alimanfoo/pysamstats)

- `results/aligned_stats/*`

## Depths of aligned filtered long reads to *T. quinquecostatus*

The depths of certain locations of *T. quinquecostatus* genome when aliging the filtered long reads of *T. vulgaris* calculated using [samtools](https://github.com/samtools/samtools). 

- `results/depths/CM044164.1_minimap_5_perc_prim.txt` (pseudo-chromosome CM044164.1)
- `results/depths/JANAFA010000304.1` (unplaced contig JANAFA010000304)

## Homology-based scaffolded assembly of *T. vulgaris*

The scaffolded assembly of *T. vulgaris* using as reference *T. quinquecostatus*. Computed using [RagTag](https://github.com/malonge/RagTag). 

- `results/ragtag_scaffold/
hifiasm_10k_q30_GCA_024222315_default_all` (scaffolded using whole *T. quinquecostatus* assembly)
- `results/ragtag_scaffold/
scaffold_10k_q30_GCA_024222315_infergaps` (as before, but with inferred gap sizes)
 


## BUSCO analysis of *T. vulgaris* assembly

[BUSCO](https://busco.ezlab.org/) analysis of *de novo* and scaffolded genome assembly of *T. vulgaris*. 

- `results/assembly_quality/txome_busco/hifiasm_10k_q30` (*de novo* assembly)
- `results/assembly_quality/txome_busco/hifiasm_10k_q30_GCA_024222315_default_all` (scaffolded assembly)

## *Loci* candidates mapped to *T. vulgaris* assembly

Alignments of Thomas' *loci* candidates to *T. vulgaris* assembly using [BWA](https://github.com/lh3/bwa). 

- `results/bwa_candidates/candidates_hifiasm_10k_q30_ragtag_all.bam` (scaffolded assembly)
- `results/bwa_candidates/candidates_hifiasm_10k_q30.bam` (*de novo* assembly)

