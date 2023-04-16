bioawk -c fastx \
    '$name ~ /RagTag/ { print $name, length($seq) }' \
    < results/ragtag_scaffold/scaffold_10k_q30_GCA_024222315_infergaps/ragtag.scaffold.fasta \
    > analysis/02-compare_genome_sizes/ragtag_assembly_sizes.csv