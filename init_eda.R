# initial exploration

library(tidyverse)
library(lubridate)
# load time series data from CSSEGIS johns hopkins folks
# https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series

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

ggplot(ky_conf, aes(date, value)) + geom_col()


