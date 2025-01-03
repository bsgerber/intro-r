# Fun and helpful packages in R

# janitor

library(janitor)

# Create a data.frame with dirty names
test_df <- as.data.frame(matrix(ncol = 6))
names(test_df) <- c("firstName", "ábc@!*", "% successful (2009)",
                    "REPEAT VALUE", "REPEAT VALUE", "")
test_df

# Base R uses make.names to make syntactically valid names
make.names(names(test_df))

# janitor's version
clean_names(test_df)

# make a bit fancier table
table(mtcars$gear, mtcars$cyl)

mtcars %>%
  tabyl(gear, cyl) %>%
  adorn_totals("col") %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting(digits = 2) %>%
  adorn_ns() %>%
  adorn_title()

# Get duplicate records
get_dupes(mtcars, wt, cyl)

# skimr

library(skimr)

summary(iris)

# Show summary with skimr
skim(iris)

hist(iris$Petal.Width)

# Can also do grouped results

library(tidyverse)

iris |>
  group_by(Species) |>
  skim()

# tidylog in tidyverse

library(tidylog)

filtered <- filter(mtcars, cyl == 4)

mutated <- mtcars |>
  mutate(new_var = wt / 10)

summary <- mtcars %>%
  select(mpg, cyl, hp, am) %>%
  filter(mpg > 15) %>%
  mutate(mpg_round = round(mpg)) %>%
  group_by(cyl, mpg_round, am) %>%
  tally() %>%
  filter(n >= 1)

library(nycflights13)

joined <- left_join(flights, 
                    weather,
                    by = c("year", "month", "day", "origin", "hour", "time_hour"))

j <- drop_na(airquality)
j

library("crayon")  # for terminal colors

crayon <- function(x) cat(cyan$bold(x), sep = "\n")

options("tidylog.display" = list(crayon))

a <- filter(mtcars, mpg > 20)

# naniar, visdat for missing data

airquality

library(visdat)

vis_dat(airquality)

vis_miss(airquality)

library(naniar)

gg_miss_var(airquality)

# Grab data from the web rvest, or can consider httr2

library(rvest)

# Choose your website
link <- "https://www.nytimes.com/"

# Scrape the web page (HTTP request and parse HTML)
NYT_page <- read_html(link)
NYT_page

# Use CSS selector to get some data of interest
summaries_css <- NYT_page |>
  html_elements(css = ".summary-class")

# Show results
head(summaries_css)

# Get text from these results
html_text(summaries_css)

