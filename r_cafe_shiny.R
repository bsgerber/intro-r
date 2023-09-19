# R Cafe - introduction to shiny

# If not installed, uncomment the line below and install the shiny package
# install.packages("shiny")

# Load the shiny library
library(shiny)

# Try an example
runExample("01_hello")

# Based on Old Faithful data (eruption time, and waiting time between eruptions, both in minutes)
head(faithful)

# Try to open in browser
# Try adjusting slider

# 11 built in examples here:
# https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/#Go%20Further

# Let's make a simple shiny app from scratch

# Shiny apps are contained in an "app.R" script, and run by runApp function
# app.R has 3 components: user interface, server (instructions to build app), call to shinyApp function

# Make a new shiny app

# Try just: "shinyapp" for a code snippet

library(shiny)

ui <- fluidPage(
  
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)

# Create a ui
# fluidpage function adjusts to dimensions of browser window

ui <- fluidPage(
  titlePanel("title panel"),
  sidebarLayout(
    sidebarPanel("sidebar panel"),
    mainPanel("main panel")
  )
)

# Widgets (gallery)
# https://shiny.posit.co/r/gallery/widgets/widget-gallery/

# Example with iris data of kmeans clustering

iris

plot(iris$Sepal.Length, iris$Sepal.Width, col = iris$Species)

km <- kmeans(iris[, c("Sepal.Length", "Sepal.Width")], 3)
km

plot(iris$Sepal.Length, iris$Sepal.Width, col = km$cluster)

# Make into shiny app

ui <- fluidPage(
  headerPanel('Iris k-means clustering'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(iris)),
    selectInput('ycol', 'Y Variable', names(iris)),
    numericInput('clusters', 'Cluster count', 3, min = 1, max = 9)
  ),
  mainPanel(
    plotOutput('plot1')
  )
)

server <- function(input, output, session) {
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })
  
  # Determine the clusters using kmeans
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  # Render the plot
  output$plot1 <- renderPlot({
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })
  
}

shinyApp(ui, server)
