# initial exploration

library(tidyverse)

# load time series data from CSSEGIS johns hopkins folks
# https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series

t_series_url = 'https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series'

confirmed_url = paste0(t_series_url, 'time_series_19-covid-Confirmed.csv')
deaths_url = paste0(t_series_url, 'time_series_19-covid-Deaths.csv')
recovered_url = paste0(t_series_url, 'time_series-19-covid-Recovered.csv')

confirmed = 


