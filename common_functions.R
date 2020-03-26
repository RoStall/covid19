# common functions for covid data

library(tidyverse)

data("df_pop_state")


t_series_url = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series'

confirmed_url = paste0(t_series_url, '/time_series_19-covid-Confirmed.csv')
deaths_url = paste0(t_series_url, '/time_series_19-covid-Deaths.csv')


global_confirmed_url = paste0(t_series_url, '/time_series_covid19_confirmed_global.csv')
global_deaths_url = paste0(t_series_url, '/time_series_covid19_deaths_global.csv')

confirmed = read_csv(confirmed_url)
deaths = read_csv(deaths_url)


global_confirmed = read_csv(global_confirmed_url)
global_deaths = read_csv(global_deaths_url)

get_us_confirmed = function() {
  us_confirmed = confirmed %>%
    rename('state' = `Province/State`) %>%
    mutate(state = stringr::str_to_lower(state)) %>%
    inner_join(df_pop_state, by = c('state' = 'region')) %>%
    rename('state_pop' = value) %>%
    pivot_longer(cols = c(-state, -`Country/Region`, -Lat, -Long, -state_pop), 
                 names_to = 'date', 
                 values_to = 'confirmed') %>%
    select(-Lat, -Long) %>%
    mutate(date = mdy(date)) %>%
    arrange(date) %>%
    mutate(confirmed_1000 = confirmed/state_pop*1000)
}

get_us_deaths = function() {
  us_deaths = deaths %>%
    rename('state' = `Province/State`) %>%
    mutate(state = stringr::str_to_lower(state)) %>%
    inner_join(df_pop_state, by = c('state' = 'region')) %>%
    rename('state_pop' = value) %>%
    pivot_longer(cols = c(-state, -`Country/Region`, -Lat, -Long, -state_pop), 
                 names_to = 'date', 
                 values_to = 'deaths') %>%
    select(-Lat, -Long) %>%
    mutate(date = mdy(date)) %>%
    arrange(date) %>%
    mutate(deaths_100000 = deaths/state_pop*100000)
  # as I understand it, per 1e5 is common for deaths metric
}


get_global_confirmed = function() {
  global_confirmed_long = global_confirmed %>%
    mutate(`Province/State` = stringr::str_to_lower(`Province/State`)) %>%
    mutate(`Country/Region` = stringr::str_to_lower(`Country/Region`)) %>%
    pivot_longer(cols = c(-`Province/State`, -`Country/Region`, -Lat, -Long),
                 names_to = 'date',
                 values_to = 'confirmed') %>%
    mutate(date = mdy(date)) %>%
    arrange(date)
}

get_global_deaths = function() {
  global_deaths_long = global_deaths %>%
    mutate(`Province/State` = stringr::str_to_lower(`Province/State`)) %>%
    mutate(`Country/Region` = stringr::str_to_lower(`Country/Region`)) %>%
    pivot_longer(cols = c(-`Province/State`, -`Country/Region`, -Lat, -Long),
                 names_to = 'date',
                 values_to = 'deaths') %>%
    mutate(date = mdy(date)) %>%
    arrange(date)
}
