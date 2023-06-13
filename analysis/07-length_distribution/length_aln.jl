using CSV
using DataFrames
using Statistics
using Plots

@time df = CSV.read(
    "results/aligned/chr_aln_best_5_perc.sorted.paf", DataFrame,
    header=false, delim='\t', select=[11]
    )

# Compute the median, mean, and maximum values
median_value = median(df.Column11)
mean_value = mean(df.Column11)
min_value = minimum(df.Column11)
max_value = maximum(df.Column11)

# Plot an histogram into a svg file
# Import histogram function from Plots

histogram(
    df.Column11,
    bins=100,
    label="",
    xlabel="Length of the alignment blocks",
    ylabel="Number of alignments",
    title="Length distribution of the alignment blocks",
    fillalpha=0.5,
    color=:red,
    fmt=:svg,
    output="analysis/07-length-distribution/histogram.svg"
    )