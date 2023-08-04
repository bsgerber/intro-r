# R Cafe Update on R Medicine June 2023 Conference

# Schedule: https://events.linuxfoundation.org/r-medicine/program/schedule/

# gt Package 
# https://gt.rstudio.com/

library(gt)
library(tidyverse)

# Modify the `airquality` dataset by adding the year
# of the measurements (1973) and limiting to 10 rows
airquality_m <- 
  airquality |>
  mutate(Year = 1973L) |>
  slice(1:10)

# Create a display table using the `airquality`
# dataset; arrange columns into groups
gt_tbl <- 
  gt(airquality_m) |>
  tab_header(
    title = "New York Air Quality Measurements",
    subtitle = "Daily measurements in New York City (May 1-10, 1973)"
  ) |>
  tab_spanner(
    label = "Time",
    columns = c(Year, Month, Day)
  ) |>
  tab_spanner(
    label = "Measurement",
    columns = c(Ozone, Solar.R, Wind, Temp)
  )

# Show the gt table
gt_tbl

# Add html header labels
gt_tbl |>
  cols_move_to_start(
    columns = c(Year, Month, Day)
  ) |>
  cols_label(
    Ozone = html("Ozone,<br>ppbV"),
    Solar.R = html("Solar R.,<br>cal/m<sup>2</sup>"),
    Wind = html("Wind,<br>mph"),
    Temp = html("Temp,<br>&deg;F")
  )

# Also gt_summary available

library(gtsummary)

# Show summary statistics by treatment drug
tbl_summary(trial, by = "trt")

# Add p-values
tbl_summary(trial, by = "trt") |>
  add_p()

# Show regression results in table
m1 <- glm(response ~ trt + grade + age, data = trial, family = binomial)
m1
summary(m1)

tbl_regression(m1, exponentiate = TRUE)

# Workflowr
# https://workflowr.github.io/workflowr/

# Copy to new directory that's not already a git repository

###############################################################################

library("workflowr")

# Configure Git (only need to do once per computer)
wflow_git_config(user.name = "Ben Gerber", user.email = "ben.gerber@umassmed.edu")

# Start a new workflowr project
wflow_start("myproject")

# Build the site
wflow_build()

# Customize your site!
#   1. Edit the R Markdown files in analysis/
#   2. Edit the theme and layout in analysis/_site.yml
#   3. Add new or copy existing R Markdown files to analysis/

# Preview your changes
wflow_build()

# Publish the site, i.e. version the source code and HTML results
wflow_publish("analysis/*", "Start my new project")

wflow_use_github("bsgerber")

wflow_git_push()

###############################################################################

# epoxy: seamlessly use data in prose of reports and apps
library(epoxy)

# See r_med_2023.qmd

###############################################################################

# Shiny example

library(shiny)

# Global variables can go here
n <- 200

# Define the UI
ui <- bootstrapPage(
  numericInput('n', 'Number of observations', n),
  plotOutput('plot')
)

# Define the server code
server <- function(input, output) {
  output$plot <- renderPlot({
    hist(runif(input$n), main = "My Histogram", xlab = "Value")
  })
}

# Return a Shiny app object
shinyApp(ui = ui, server = server)

# Other shiny examples
# https://shiny.posit.co/r/gallery/

###############################################################################

# storyboardR (requires TimeWarp which was pulled from CRAN)

# devtools::install_github("TheMillerLab/StoryboardR")

library(StoryboardR)

dt <- StoryboardR::storyboard_dataset

View(dt)

StoryboardR::launch_StoryboardR(Data = dt)
