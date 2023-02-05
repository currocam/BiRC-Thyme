## BiRC- Thyme Project in Bioinformatics

This project aims to assemble the genome of *Thymus vulgaris*. 

![Thymus_vulgaris](https://upload.wikimedia.org/wikipedia/commons/9/96/Planta_de_tomillo.jpg)

This project is managed using [snakemake](https://snakemake.readthedocs.io/en/stable/) and makes use of [Conda](https://docs.conda.io/en/latest/) and [Singularity](https://sylabs.io/docs/) to run the different parts of the project in isolated environments. To run the whole pipeline follow the steps 
below: 

## Set up

Install snakemake and mamba using conda: 

```bash
conda create -c conda-forge -c bioconda -n snakemake snakemake mamba
```

Activate enviroment and check all programs are installed:

```bash
conda activate snakemake
snakemake -v && mamba -V && singularity version
```

## Run the pipeline

To run the pipeline we will rely on conda or container environments to execute the different steps. Use the -n option to see a dry-run (what will be done without running it if any of the files are not up to date)

```bash
snakemake -n --use-conda --use-singularity
```

and add the maximum number of cores allowed when you really want to run it:

```bash
snakemake -c10 --use-conda --use-singularity
```

## Project structure

You will find a summary of intermediate results in the [results README file](results/README)

You can find more about
- Complete log files in [log directory](logs/README).
- Input data in [reads directory](reads/README).
- Runtime information in [benchmarks directory](benchmarks/README).

