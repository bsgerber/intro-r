# R Cafe intro to tidyverse

# Make sure to have the following packages installed (tidyverse includes multiple packages like dplyr)
install.packages("nycflights13")
install.packages("tidyverse")

# Then load libraries
library(tidyverse)
library(nycflights13)

# Note tidyverse will mask some functions

# Check out the flights data using glimpse (instead of str)
glimpse(flights)

# This package contains information about all flights that departed from NYC (e.g. EWR, JFK and LGA) 
# to destinations in the United States, Puerto Rico, and the American Virgin Islands) in 2013: 336,776 flights in total.
# To help understand what causes delays, it also includes a number of other useful datasets.

# Want to see the different airline abbreviations?
airlines

# Using filter, show only American Airlines
filter(flights, carrier == "AA")

# Combine with showing destination of Seattle
filter(flights, carrier == "AA" & dest == "SEA")

# Show flights in December
filter(flights, month == 12)

# Show flights in bunch of locations
filter(flights, dest %in% c("SEA", "SFO", "PDX"))

# Let's try summarize
summarize(flights, mean_delay = mean(arr_delay))

# Why NA?
filter(flights, is.na(arr_delay))

# We can say remove NA for mean
summarize(flights, mean_delay = mean(arr_delay, na.rm = T))

# What about combining both filter and summarize? Use a pipe!

# What is the pipe operator? (Ctrl-shift-M)

flights %>%
  filter(carrier == "AA") %>%
  summarize(mean_delay = mean(arr_delay, na.rm = T))

# If using R version > 4.1, can use |> which is similar though not exactly the same

flights |>
  filter(carrier == "AA") |>
  summarize(mean_delay = mean(arr_delay, na.rm = T))

# How to do this for all airlines? Use group_by

flights %>%
  group_by(carrier) %>%
  summarize(mean_delay = mean(arr_delay, na.rm = T))

# Can include multiple variables in group_by (and show number of flights too!)
flights %>%
  group_by(carrier, month) %>%
  summarize(mean_delay = mean(arr_delay, na.rm = T),
            n = n())

# Select variables
flights %>%
  select(dep_delay, arr_delay)

# Mutate to create new variables
flights %>%
  select(dep_delay, arr_delay) %>%
  mutate(gain = dep_delay - arr_delay)

# Sorting with arrange
flights %>% 
  group_by(dest) %>% 
  summarize(num_flights = n()) %>%
  arrange(num_flights)

# Or descending
flights %>% 
  group_by(dest) %>% 
  summarize(num_flights = n()) %>%
  arrange(desc(num_flights))

# Joining tables
airlines

# Inner join includes results where rows are in both data.frames
inner_join(flights, airlines, by = "carrier")

# Coding categories from numeric data
flights %>%
  select(dep_delay, arr_delay) %>%
  mutate(gain = dep_delay - arr_delay,
         is_good = case_when(
           gain > 0 ~ "yeah good",
           gain == 0 ~ "doesn't matter",
           gain < 0 ~ "horrible experience"
         )) %>%
  print(n=100)

# Bonus!

# pivot_wider to put into wide format of data
fish_encounters %>%
  pivot_wider(names_from = station, values_from = seen)

# pivot_longer to put into long format of data
billboard %>% 
  pivot_longer(
    cols = starts_with("wk"), 
    names_to = "week", 
    values_to = "rank",
    values_drop_na = T
  )
