library(tidyverse)
source("analysis/00-miscellaneous/format.R")
df <- read_csv("analysis/03-count_illumina_reads_assembly/samtools_stats.csv")|>
  mutate(Hyb = as.factor(Hyb))
df |>
  ggplot(aes(
    x = `Properly paired`, y = `error rate`,
    color = Hyb, shape = Sample)
    )+
  geom_point(size = 4)+
  xlab("Percentage of properly paired mapped reads")+
  ylab("N. of mismatches / N. of mapped nucleotides")+
  scale_color_discrete(name = "Hybridization condition")+
  guides(shape=guide_legend(ncol=2, fill=guide_legend(ncol=2)))+
  theme(legend.position="bottom")-> p1

ggsave(
  p1, filename="analysis/03-count_illumina_reads_assembly/mapped_vs_error_rate.pdf",
  width = fig.witdh, height=fig.height, units = "mm"
)
