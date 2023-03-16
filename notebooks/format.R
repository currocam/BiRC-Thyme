# This scripts will set some formatting values for R that will affect both 
# figures and outputs. It is mainly based on Palle Villesen's scrip to adjust
# the values of R to the requirements of nature to elaborate figures. 
# It also prepares the ggplot palette to use I want hue 
# and a function to generate the color codes to make the coding easier. 
# https://pure.au.dk/portal/da/persons/palle-villesen(c1c4bd28-befd-4150-bbbb-10138e528d53).html
# https://medialab.github.io/iwanthue/

# Check dependencies

if (!require("tidyverse")){install.packages("tidyverse")}
if (!require("cowplot")){install.packages("cowplot")}
if (!require("rwantshue")){devtools::install_github("hoesler/rwantshue")}

# Load libraries
library(cowplot)
library(tidyverse)

# Text formatting

options(digits = 3)        # number of digits printed by R default (vectors, data.frames, lists)
options(pillar.sigfig = 3) # number of digits printed by tibbles default.

text_base_size   <- 16   # in pt
fig.witdh        <- 180  # in mm
fig.height       <- 125  # in mm

# Set all text in plots to same size
theme_set(
  theme_cowplot(
  font_size = text_base_size, rel_small = 1,
  rel_tiny = 1, rel_large = 1
  )
  )

# Setting output sizes for plots in knitted html 
knitr::opts_chunk$set(fig.width = fig.witdh/25.4)
knitr::opts_chunk$set(fig.height = fig.height/25.4)
knitr::opts_chunk$set(dpi = 108) # You need to find your minotors dpi yourself.

# Setting text size inside plots (geom_text, geom_label etc.)
ggplot_text_size <- text_base_size / ggplot2::.pt
# Now use: geom_text(..., size = ggplot_text_size)

# For saving plots!
# Use: ggsave(plot1, filename="myplot.png", width = fig.witdh, height=fig.height, units = "mm")
# Use: ggsave(plot1, filename="myplot.pdf", width = fig.witdh, height=fig.height, units = "mm")

save_default <- function(...){
  ggsave(..., width = fig.witdh, height=fig.height, units = "mm")
}

# Set locale if you want danish month names etc.
#Sys.setlocale(locale = "Danish_Denmark")  # For danish axes on plot
Sys.setlocale(locale = "English_Denmark") # For english axes on plot


# I want hue pallete

library(rwantshue)
get_wants_hue <- function(n, seed = 1, palette = "colorblind_friendly"){
  scheme <- iwanthue(seed = seed, force_init = TRUE)
  scheme$hex(n,color_space = hcl_presets[[palette]])
}
# Now use: get_wants_hue(5)

# Changing default ggplot colours
# see ?scale_fill_continuous
# https://ggplot2.tidyverse.org/reference/scale_colour_continuous.html
# https://ggplot2.tidyverse.org/reference/scale_colour_discrete.html 
#
options(ggplot2.continuous.colour = scale_colour_viridis_c)
options(ggplot2.discrete.fill     = list(get_wants_hue(7)))
options(ggplot2.discrete.colour   = list(get_wants_hue(7)))