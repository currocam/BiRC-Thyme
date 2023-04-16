library(tidyverse)
source("analysis/00-miscellaneous/format.R")
assembly_report <- "https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/024/222/315/GCA_024222315.1_ASM2422231v1/GCA_024222315.1_ASM2422231v1_assembly_report.txt"
col_names <- c(
  "Sequence-Name",	"Sequence-Role",	"Assigned-Molecule",
  "Assigned-Molecule-Location/Type",	"chrom",
  "Relationship",	"RefSeq-Accn",	"Assembly-Unit",
  "length_tq", "UCSC-style-name"
)

chromosomes <- c(
  "CM044164.1", "CM044165.1", "CM044166.1",
  "CM044167.1", "CM044168.1", "CM044169.1",
  "CM044170.1", "CM044171.1", "CM044172.1",
  "CM044173.1", "CM044174.1", "CM044175.1",
  "CM044176.1"
)

reference <- assembly_report |>
  read_tsv(comment = "#",col_names = col_names, show_col_types = FALSE) |>
  select(chrom, length_tq) |>
  mutate(chrom = fct_other(chrom, keep = chromosomes, other_level = "chr0")) |>
  group_by(chrom) |>
  summarise(n = n(), length_tq = sum(length_tq))

query <- read_tsv(
  "analysis/02-compare_genome_sizes/ragtag_assembly_sizes.csv",
  col_names = c("chrom", "length_tv"), show_col_types = FALSE
  ) |>
  mutate(
    chrom = chrom |> str_remove("_RagTag") |> 
      fct_other(keep = chromosomes, other_level = "chr0")
    ) |>
  group_by(chrom) |>
  summarise(n = n(), length_tv = sum(length_tv))

data <- inner_join(reference, query, by = "chrom") 

data$ratio <- data$length_tv / data$length_tq

tq_size <- 528675121
dna_amount_in_pg <- 0.77	#https://cvalues.science.kew.org/search
tv_size_exp <- dna_amount_in_pg * 1000000000

data$expected_ratio <- tv_size_exp / tq_size

p1 <- data |>
  rename(Observed = ratio, Expected = expected_ratio) |>
  pivot_longer(
    cols = c("Observed", "Expected"),
    values_to = "Ratio", names_to = "Type") |>
  ggplot(aes(y = chrom, x = Ratio, color = chrom))+
  geom_line(aes(group = chrom)) +
  geom_point(aes(shape = Type)) +
  scale_color_manual(values = c(chrom_hues, "gray"))+
  guides(color = FALSE)+
  theme(legend.position="bottom")

ggsave(
  p1, filename="analysis/02-compare_genome_sizes/genome_size_ratio.svg",
  width = fig.witdh, height=fig.height, units = "mm"
)

# Expected ratio (using apprx)
tv_size_exp / tq_size
# Observed ratio
sum(data$length_tv) / sum(data$length_tq)
# Observed ratio not taking into account chr0
sum(data$length_tv[1:13]) / sum(data$length_tq[1:13])
