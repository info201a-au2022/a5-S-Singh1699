library(shiny)
library(plotly)

#Source File
source("calculated_data.R")


introPage <- tabPanel(
  "Introduction",
  p("This website will be a brief yet important look into the emissions of our world.
     Most of us accept the existence of climate change and we all know our current production
     of oil/gas from fossil fuels are very damaging for our planet. This dataset that's being referenced
     shows us a number of variables such as emissions as cunulative, emissions cuased from oil, gas and even methane.
     For a quick summary, we've calculated a couple of summary variables that help us grasp the true nature of this problem.
    "),
  h4("Cumulative CO2 Emissions"),
  p("Variable 1 (in million tonnes):"),
  textOutput("Cumulative_CO2"),
  p(""),
  p("This first number represents the cumulative CO2 emissions from 1850 to 2021.
    This number is measured not in thousands or hundreds of thousands, rather it is in million tonnes.
    When we see this number, we can understand how it was expected to be this high but, when we really dwell upon it, we realize just how much that is.
    The next variable we'll be looking at will be the cumulative CO2 emissions caused from oil production as this will allow us to understand how much of a contribution it truly plays. 
    "),
  p(""),
  h4("Cumulative Oil Produced CO2 Emissions"),
  p("Variable 2 (in million tonnes):"),
  textOutput("Cumulative_Oil_CO2"),
  p(""),
  p("The next variable is a look at the oil produced CO2 emissions.
    We can see from the number that it is nearly half of the total cumulative CO2 emissions over a span of 170 years!
    Although oil is a common understanding of many to be one of the main casues of CO2 in our environment, people tend to disregard gas.
    Both gas and oil are made from the burning of fossil fuels and are one in the same (in a sense).
    The next variable is a look at the cumulative gas produced CO2 emissions and we'll be looking at how that adds up.
    "),
  p(""),
  h4("Cumulative Gas Produced CO2 Emissions"),
  p("Variable 3 (in million tonnes):"),
  textOutput("Cumulative_Gas_CO2"),
  p(""),
  p("The last and final variable is nearly four hundred thousand less million tonnes than oil but, it is still fairly a lot.
    When we compare the two it may seem like gas is better for production but, the truth is that they are both partners in crime.
    Below, is a table to make it easier to take a look at all three of these variables pulled.
    "),
  tableOutput("emissions_table"),
  p(""),
  p("Now, when we see the table, we can see just how much of oil and gas produced CO2 emissions are a part of the total.
    If we do the math, we can see that there are about 860k million tonnes of CO2 emissions produced.
    That is just a little more than half of the cumulative CO2 emissions from 1850 to 2021.
    "),
  p("If we do not take caution or preventive actions with these detrimental yet simple calculations of our CO2 emissions then,
    this dataset will only get larger and larger.
    The visualization in the other page will continue it's linear trend. Which in this case, we do not want.
    ")
)

barPage <- tabPanel(
  "Emissions from 2000-2021",
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("countryType", "Country Type:", 
                  choices=CO2_df$country,),
      #multiple = TRUE),
      hr(),
      helpText("Choose the country you want to see")
    ),
  mainPanel(
    plotlyOutput("barChart"),
    p(""),
    p("The bar graph above shows us a look at the whole words cumulative CO2 emissions from each year.
      We've chosen to look at data from after 2000 because it is more relevant.
      But, we shouldn't mistake it as a new trend, this linear trend is apparent throughout the dataset because,
      as society advances, so does our use of the planet and resources like fossi fuels.
      "),
    plotlyOutput("barChart_V2")
    )
  )
)

# Define UI for application
ui <- fluidPage(
  "CO2 Emissions (1850-2021)",
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
    
    output$barChart_V2 <- renderPlotly({
      ggplotly(ggplot(country_2000_2021_cumulative <- filter(CO2_df, year >= 2000, year <= 2022) %>%
                        filter(country == input$countryType), 
                      aes(x=country, y=cumulative_oil_co2)) + 
                 geom_bar(stat = "identity", color="black", fill = "blue") +
                 labs(x = "Country", title = "Cumulative Oil Produced CO2 Emissions By Country (2000-2021)") +
                 scale_y_continuous("Oil Produced CO2 Emissions (Million Tonnes)", labels = comma)
      )
    })
    
    output$Cumulative_CO2 <-  renderText({Cumulative_most_CO2})
    output$Cumulative_Oil_CO2 <-  renderText({Cumulative_most_oil_CO2})
    output$Cumulative_Gas_CO2 <-  renderText({Cumulative_most_gas_CO2})
    output$emissions_table <- renderTable(emissions_df)
}

# Run the application 

shinyApp(ui = ui, server = server)
