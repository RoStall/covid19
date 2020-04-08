# International Comparisons

library(tidyverse)


source('common_functions.R')

global_confirmed = get_global_confirmed()
global_deaths = get_global_deaths()

coun1 = c('china', 'us', 'italy', 'france', 'iran', 'united kingdom', 'germany', 'egypt')
coun2 = c('china', 'us', 'italy', 'united kingdom', 'iran')

# stacked area chart of selected countries -- remember to use per 1000

# animated stacked area chart of selected countries, updating every day, with governing decisions?

# line/point plots for selected countries
