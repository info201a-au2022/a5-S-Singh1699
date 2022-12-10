library(shiny)
library(plotly)

#Source File
source("calculated_data.R")


introPage <- tabPanel(
  "Introduction",
  p("Placeholder"),
)

barPage <- tabPanel(
  "Bar Chart",
  mainPanel(
    plotlyOutput("barChart"),
    p(""),
    p("Placeholder")
  )
)

# Define UI for application
ui <- fluidPage(
  tabsetPanel(
    introPage,
    barPage,
  )
)


# Define server logic

server <- function(input, output) {
    output$barChart <- renderPlotly({
      plot_year_cumulative_oil_CO2()
    })
}

# Run the application 

shinyApp(ui = ui, server = server)
