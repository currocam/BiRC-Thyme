library(tidyverse)
source("analysis/00-miscellaneous/format.R")
infiles <- "analysis/01-mapped_reads-model/chains/" |>
  list.files(pattern = "*.csv",full.names = TRUE)
names(infiles) <- sub('\\.csv$', '', basename(infiles))
data <- map(infiles, read_csv, show_col_types = FALSE) |>
  bind_rows(.id = "chrom") |>
  filter(startsWith(chrom, "CM"))

chrom_hues <- get_wants_hue(13)
p1 <- data |>
  pivot_longer(cols = c("λ", "pzero"))|>
  ggplot(aes(x = value, color = chrom))+
  geom_density()+
  scale_color_manual(values = chrom_hues)+
  facet_wrap(~name,ncol = 1,scales = "free")+
  theme(legend.position="bottom")

ggsave(
  p1, filename="analysis/01-mapped_reads-model/05-posterior_var.svg",
  width = fig.witdh, height=fig.height, units = "mm"
  )

p2 <- data |>
  pivot_longer(cols = c("λ", "pzero"))|>
  ggplot(aes(x = iteration, y = value, color = chrom))+
  geom_line()+
  scale_color_manual(values = chrom_hues)+
  facet_wrap(~name,ncol = 1,scales = "free")+
  theme(legend.position="bottom")
p2

ggsave(
  p2, filename="analysis/01-mapped_reads-model/05-posterior_iterations.svg",
  width = fig.witdh, height=fig.height, units = "mm"
)
