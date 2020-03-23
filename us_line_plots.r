# point/line plots US States

library(tidyverse)
library(ggthemes)

source('common_functions.R')

us_confirmed = get_us_confirmed()
us_deaths = get_us_deaths()

