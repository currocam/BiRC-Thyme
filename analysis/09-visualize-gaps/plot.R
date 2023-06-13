library(tidyverse)

df <- "results/ragtag_scaffold/scaffold_10k_q30_GCA_024222315_infergaps/ragtag.scaffold.agp" |>
    read_tsv(comment = '#', col_names = c("scaffold", "start", "end", "part_number", "type", "gap_length", "gap_type", "linkage", "evidence"))

# Let's check if gaps of unknown size (type == u)
# are always in the middle of the scaffold
df |> filter(type == 'U') |> pull(start) |> summary()

# Compute the amount of unknown gaps per scaffold in windows of 1000 bp
df |>
    filter(type == 'U') |>
    filter(str_detect(scaffold, "^CM")) |>
    mutate(scaffold = as.factor(scaffold)) |>
    group_by(scaffold) |> 
    mutate(window = floor(start / 10^7)) |> 
    group_by(scaffold, window, type) |> 
    summarize(n = n()) |>
    ggplot(aes(x = window, y = n, color = scaffold)) +
    geom_point() -> p1

ggsave("analysis/09-visualize-gaps/gaps_per_scaffold_window_10000.pdf", p1, width = 10, height = 10, units = "cm", dpi = 300)