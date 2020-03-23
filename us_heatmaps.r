# US Heatmaps

library(tidyverse)
library(ggthemes)
library(viridis)

source('common_functions.R')

us_confirmed = get_us_confirmed()
us_recovered = get_us_recovered()
us_deaths = get_us_deaths()


ggplot(us_confirmed, aes(date, state, fill = confirmed_1000)) +
  geom_tile(color = 'black') +
  scale_fill_viridis() +
  scale_x_date(expand = c(0,0), limits = c(as.Date('2020-03-08'), NA)) +
  scale_y_discrete(expand = c(0,0)) + 
  labs(title = 'Confirmed COVID-19 Cases by State, per 1000 People',
         fill = 'Confirmed per 1000',
         x = 'Date',
         y = 'State',
         caption = 'Source: CSSE Data | Figure by R. Stallard') +
  theme_tufte()

ggsave('graphics/us_states_confirmed_heatmap.png', height = 8, width = 8, units = 'in', dpi = 400)  
  
ggplot(us_deaths, aes(date, state, fill = deaths_100000)) +
  geom_tile(color = 'black') +
  scale_fill_viridis() +
  scale_x_date(expand = c(0,0), limits = c(as.Date('2020-03-08'), NA)) +
  scale_y_discrete(expand = c(0,0)) + 
  labs(title = 'COVID-19 Related Deaths: Cases by State, per 100,000 People',
       fill = 'Deaths per 100000',
       x = 'Date',
       y = 'State',
       caption = 'Source: CSSE Data | Figure by R. Stallard') +
  theme_tufte()

ggsave('graphics/us_states_deaths_heatmap.png', height = 8, width = 8, units = 'in')


ggplot(us_recovered, aes(date, state, fill = recovered_1000)) +
  geom_tile(color = 'black') +
  scale_fill_viridis() +
  scale_x_date(expand = c(0,0), limits = c(as.Date('2020-03-08'), NA)) +
  scale_y_discrete(expand = c(0,0)) + 
  labs(title = 'COVID-19 Recoveries: Cases by State, per 1000 People',
       fill = 'Recoveries per 1000',
       x = 'Date',
       y = 'State',
       caption = 'Source: CSSE Data | Figure by R. Stallard') +
  theme_tufte()
