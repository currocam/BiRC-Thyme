library(tidyverse)
indir <- 'analysis/01-mapped_reads-model/chains/'
chr_files <- indir |>
    list.files()
infiles <- paste0(indir, head(chr_files, 13))
names(infiles) <- chr_files |> head(13)

pzero_samples <- map(infiles, \(x) read_csv(x, show_col_types = FALSE) |> pull(pzero))
lambda_samples <- map(infiles, \(x) read_csv(x, show_col_types = FALSE) |> pull(λ))

map(pzero_samples, quantile, c(0.025, 0.975)) |>
    bind_cols()

map(lambda_samples, quantile, c(0.025, 0.975)) |>
    bind_cols() |> View()

# Concatenate all list into one vector
pzero_samples |> unlist() |> as.numeric() |> quantile(c(0.025, 0.975))

lambda_samples |> unlist() |> as.numeric() |> quantile(c(0.025, 0.975))

# Savage-Dickey method aplies to nested model such as Poisson and Zero-inflated Poisson
#\begin{align*}
#\frac{P(D \mid M_0)}{P(D \mid M_1)}  & = 
#\frac{P(\phi = \phi_0 \mid D, M_1)}{P(\phi = \phi_0 \mid M_1)}
#\end{align*}
# As the $P(\phi = \phi_0 \mid D, M_1)$ is zero, then Bayes factor is also zero

# Based on book https://michael-franke.github.io/intro-data-analysis/
# estimating the posterior density at delta = 0 with polynomial splines
get_posterior_pzero_null <- function(x){
    fit.posterior <- polspline::logspline(x)
    polspline::dlogspline(0, fit.posterior)
}

posterior_pzero_nulls <- map(pzero_samples, get_posterior_pzero_null) |>
    as.numeric()

prior_pzero_null <- dunif(0) # Just one

map()
posterior_pzero_nulls/prior_pzero_null
