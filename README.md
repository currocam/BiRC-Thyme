## BiRC-Thyme: Project in Bioinformatics

This repository contains all code used during the Project in Bioinformatics I did as part of my MSc in Bioinformatics at Aarhus University.

The main objective of this project was to explore the use Homology-Scaffolding to obtain a Chromosome-level assembly of Thymus vulgaris.

## Slides of my PiB presentation

You can find the slides of my [presentation here (GitHub Pages)](https://currocam.github.io/BiRC-Thyme/).

## Run the pipeline

This project is managed using [snakemake](https://snakemake.readthedocs.io/en/stable/) and makes use of [Conda](https://docs.conda.io/en/latest/) and [Singularity](https://sylabs.io/docs/) to run the different parts of the project in isolated environments. Scripts intended to be run interactively are located in the `analysis/` directory.

To run the whole pipeline, follow the steps below:

### Set up

Install snakemake and Mamba using conda:

``` bash
conda create -c conda-forge -c bioconda -n snakemake snakemake mamba
```

Activate the enviroment and check all programs are installed:

``` bash
conda activate snakemake
snakemake -v && mamba -V && singularity version
```

Run the following line to make sure you have all the necessary input files:

``` bash
snakemake check -c1
```

We will rely on conda or container environments to run the pipeline to execute the different steps. Use the -n option to see a dry-run (what will be done without running it if any of the files are not up to date)

``` bash
snakemake -n --use-conda --use-singularity
```

And add the maximum number of cores allowed when you want to run it:

``` bash
snakemake -c10 --use-conda --use-singularity
```

## Project structure

We distinguish between source files (input directory), external data, and work results. See the corresponding README file for each directory for more information.
