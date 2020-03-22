# initial exploration

library(tidyverse)
library(lubridate)
# load time series data from CSSEGIS johns hopkins folks
# https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series

# TODO is time series data cumulative or total as of the day?
# TODO comparative rates with other states
# TODO comparative rates with lagged data based on onset of confirmed cases... other states, perhaps countries
# CONSIDER what might a shiny app look like? For the whole deal.
# TODO when reporting, show a differential? maybe ?
t_series_url = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series'

confirmed_url = paste0(t_series_url, '/time_series_19-covid-Confirmed.csv')
deaths_url = paste0(t_series_url, '/time_series_19-covid-Deaths.csv')
recovered_url = paste0(t_series_url, '/time_series_19-covid-Recovered.csv')

confirmed = read_csv(confirmed_url)
deaths = read_csv(deaths_url)
recovered = read_csv(recovered_url)

ky_conf = confirmed %>% 
  filter(`Province/State` == 'Kentucky') %>%
  pivot_longer(cols = c(-`Province/State`, -`Country/Region`, -Lat, -Long), 
               names_to = 'date', 
               values_to = 'confirmed') %>%
  select(-Lat, -Long) %>%
  mutate(date = mdy(date)) %>%
  arrange(date)

ky_recovered = recovered %>% 
  filter(`Province/State` == 'Kentucky') %>%
  pivot_longer(cols = c(-`Province/State`, -`Country/Region`, -Lat, -Long), 
               names_to = 'date', 
               values_to = 'recovered') %>%
  select(-Lat, -Long) %>%
  mutate(date = mdy(date)) %>%
  arrange(date)

ky_deaths = deaths %>% 
  filter(`Province/State` == 'Kentucky') %>%
  pivot_longer(cols = c(-`Province/State`, -`Country/Region`, -Lat, -Long), 
               names_to = 'date', 
               values_to = 'deaths') %>%
  select(-Lat, -Long) %>%
  mutate(date = mdy(date)) %>%
  arrange(date)

ky_merged = inner_join(ky_conf, ky_deaths) %>% 
  inner_join(ky_recovered) %>% 
  select(date, confirmed, deaths, recovered) %>%
  pivot_longer(cols = -date)

ggplot(ky_merged, aes(date, value, fill = name)) + 
  geom_col(position = 'fill') +
  scale_x_date(limits = c(Sys.Date() - 15, NA))
  
ggplot(ky_merged, aes(date, value, color = name)) + 
  geom_line() +
  scale_x_date(limits = c(Sys.Date() - 15, NA))





