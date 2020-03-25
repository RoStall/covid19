# point/line plots US States

library(tidyverse)
library(ggthemes)
library(directlabels)
library(ggrepel)

source('common_functions.R')

us_confirmed = get_us_confirmed()
us_deaths = get_us_deaths()

cols <- c("california" = "#1b9e77", 
          "district of columbia" = "#d95f02", 
          "kentucky" = "#7570b3", 
          "new jersey" = "#a8144d",
          "new york" = "#66a61e",
          "tennessee" = "#e6ab02",
          "washington" = "#1425a8",
          'louisiana' = '#14a8a3',
          "indiana" = '#77238c',
          "other" = "#666666")

highlight_states = c('kentucky', 'tennessee', 'new york', 'washington', 'california',
                     'new jersey', 'district of columbia', 'louisiana', 'indiana')

us_confirmed_highlights = us_confirmed %>%
  mutate(state_highlight = if_else(state %in% highlight_states, state, 'other'))

us_deaths_highlights = us_deaths %>%
  mutate(state_highlight = if_else(state %in% highlight_states, state, 'other'))

ggplot(us_confirmed_highlights, aes(date, confirmed_1000, group = state, color = state_highlight)) + 
  geom_line(alpha = 0.7, size = 1) +
  geom_point() +
  scale_x_date(expand = c(0,0), limits = c(as.Date('2020-03-08'), NA)) +
  scale_color_manual(values = cols) +
  theme_tufte() +
  labs(title = 'Confirmed COVID-19 Cases, per 1000 People',
       color = ' State',
       x = 'Date',
       y = 'Confirmed per 1000',
       caption = 'Source: CSSE Data | Figure by R. Stallard')

ggplot(us_confirmed_highlights %>% filter(state %in% highlight_states), 
       aes(date, confirmed_1000, color = state)) +
  geom_line(size = 1) + geom_point() +
  # geom_text(data = us_confirmed_highlights %>% 
  #             filter(state %in% highlight_states,
  #                    date == last(date)),
  #           aes(label = state, 
  #                x = date + 2, 
  #                y = confirmed_1000, 
  #                color = state)) + 
  guides(color = FALSE) +
  scale_x_date(expand = c(0,3), limits = c(as.Date('2020-03-08'), NA), breaks = scales::pretty_breaks(5)) +
  scale_color_manual(values = cols) +
  theme_tufte() +
  labs(title = 'Confirmed COVID-19 Cases, per 1000 People',
       subtitle = 'Selected States',
       color = 'State',
       x = 'Date',
       y = 'Confirmed per 1000 as of Date',
       caption = 'Source: CSSE Data | Figure by R. Stallard')

ggplot(us_confirmed_highlights %>% 
         filter(state %in% highlight_states), 
       aes(date, confirmed_1000, color = state)) +
  geom_line(size = 1) + geom_point() + 
  # geom_text(data = us_confirmed_highlights %>%
  #             filter(state %in% highlight_states,
  #                    date == last(date)),
  #           aes(label = state,
  #                x = date + 2,
  #                y = confirmed_1000,
  #                color = state)) +
  geom_text_repel(data = us_confirmed_highlights %>%
                    filter(state %in% highlight_states,
                           date == last(date)),
                  aes(label = state,
                      x = date + 2,
                      y = confirmed_1000,
                      color = state),
                  direction = 'y') +
  guides(color = FALSE) +
  scale_x_date(expand = c(0,3), limits = c(as.Date('2020-03-08'), NA), breaks = scales::pretty_breaks(5)) +
  scale_color_manual(values = cols) +
  theme_tufte() +
  labs(title = 'Confirmed COVID-19 Cases, per 1000 People',
       subtitle = 'Selected States',
       color = 'State',
       x = 'Date',
       y = 'Confirmed per 1000 as of Date',
       caption = 'Source: CSSE Data | Figure by R. Stallard')


ggplot(us_deaths_highlights, aes(date, deaths_100000, group = state, color = state_highlight)) + 
  geom_line(alpha = 0.7, size = 1) +
  geom_point() +
  scale_x_date(expand = c(0,0), limits = c(as.Date('2020-03-08'), NA)) +
  scale_color_manual(values = cols) +
  theme_tufte() +
  labs(title = 'COVID-19 Related Deaths, per 100,000 People',
       color = ' State',
       x = 'Date',
       y = 'Deaths per 100,000 as of Date',
       caption = 'Source: CSSE Data | Figure by R. Stallard')


ggplot(us_deaths_highlights %>% filter(state %in% state_highlight),
       aes(date, deaths_100000, group = state, color = state_highlight)) + 
  geom_line(alpha = 0.7, size = 1) +
  geom_point() +
  scale_x_date(expand = c(0,0), limits = c(as.Date('2020-03-08'), NA)) +
  scale_color_manual(values = cols) +
  theme_tufte() +
  labs(title = 'COVID-19 Related Deaths, per 100,000 People',
       color = ' State',
       x = 'Date',
       y = 'Deaths per 100,000 as of Date',
       caption = 'Source: CSSE Data | Figure by R. Stallard')
