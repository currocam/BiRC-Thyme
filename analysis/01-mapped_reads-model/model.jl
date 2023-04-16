# Load libraries
println("Load libraries...")
using Distributions, StatsPlots, Turing, CSV, DataFrames, ProgressBars

println("Defining the model...")
# MODEL
# Define generative model
function generate_data(n, pzero, λ)
    d1 = Bernoulli(pzero)
    d2 = Poisson(λ)
    y = zeros(UInt32, n)
    y .= rand(d1,n).*rand(d2, n)
    y
end


# Define ZIP 
ZeroInflated(dist, pzero) = MixtureModel([Dirac(0), dist], [pzero, 1 - pzero])


# Define Bayesian ZIP regression
@model function zip(y)
    α = 1
    θ = mean(y)
    λ ~ Gamma(α, θ)
    pzero ~ Uniform(0, 1)
    y ~ ZeroInflated(Poisson(λ), pzero)
end;

println("Simulating fake data according the generative model ...")
# SIMULATION
size_of_window = 1000
size_of_chr_one_binned = 17917393 ÷ size_of_window
y = generate_data(size_of_chr_one_binned, 0.5, 10)

# Inspect theoretical data and ZeroInflated
d = ZeroInflated(Poisson(10), 0.5)
plot(d; components=false, legend=false)
savefig("analysis/01-mapped_reads-model/01_zero_inflated.svg")
histogram(y)
savefig("analysis/01-mapped_reads-model/02_generated_data.svg")

println("Fitting the model to fake data ...")
# sample from posterior for a small subset
x = "subset_fake_data"
y = sample(y, 10000)
m = zip(y)
chain = sample(m, NUTS(200, 0.65), 500) #Small number of iter
chains_new = chain[201:end, :, :]
CSV.write("analysis/01-mapped_reads-model/chains/$x.csv", chains_new)
data_sm = summarize(chains_new, mean, median, var, std, t -> quantile(t, 0.05), t -> quantile(t, 0.95))
CSV.write("analysis/01-mapped_reads-model/04-summary-$x.csv", data_sm)
plot(chains_new)
savefig("analysis/01-mapped_reads-model/04-summary-$x.svg")

println("Reading data ...")
# DATA MODELLING
# Read data
data = CSV.read("results/aligned_stats/binned_coverage.txt", DataFrame)
filter!(row -> occursin("CM", row.chrom), data)

histogram(data.reads_all)
savefig("analysis/01-mapped_reads-model/03_reads_all_histogram.svg")

println("Fitting the model to each chromosome independently ...")
# Now, we are going to fit each chromosome independently
chroms = unique(data.chrom)
# Sampling from the posterior
for i in ProgressBar(1:13)
    x = chroms[i]
    y = data.reads_all[data.chrom .== x]
    m = zip(y)
    chain = sample(m, NUTS(200, 0.65), 500) #Small number of iter
    chains_new = chain[201:end, :, :]
    CSV.write("analysis/01-mapped_reads-model/chains/$x.csv", chains_new)
    data_sm = summarize(chains_new, mean, median, var, std, t -> quantile(t, 0.05), t -> quantile(t, 0.95))
    CSV.write("analysis/01-mapped_reads-model/04-summary-$x.csv", data_sm)
    plot(chains_new)
    savefig("analysis/01-mapped_reads-model/04-summary-$x.svg")
end
println("Process finished!")
