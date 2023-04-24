library(pafr)
library(tidyverse)
source("analysis/00-miscellaneous/format.R")
ali <- "analysis/05-candidates_assembly_visualization/ragtag.scaffold.asm.paf" |>
  read_paf()|>  
  arrange(-mapq, -alen) |>
  # Global alignment
  distinct(qname, .keep_all = TRUE)


plot_chromosome <- function(chrom, n = 6){
  subset <- ali |>
    filter(tname == chrom)|>
    slice_max(alen,n = n) |>
    select(qname, tname) |>
    as.data.frame()
  plots <- pmap(subset, ~plot_synteny(ali,q_chrom = ..1, t_chrom = ..2))
  plot_grid(plotlist = plots)

}

chromosomes <- ali$tname |> unique() |> head(13)
plots <- map(chromosomes, plot_chromosome)

filenames <- paste0("analysis/05-candidates_assembly_visualization/", chromosomes, ".pdf")
walk2(plots, filenames, ~ggsave(.x, filename = .y, width = fig.witdh, height=fig.height, units = "mm"))
