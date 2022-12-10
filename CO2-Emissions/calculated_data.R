library(tidyverse)
library(dplyr)
library(ggplot2)
library(scales)

CO2_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")


#Amount of the most cumulative CO2 Emissions

Cumulative_most_CO2 <- CO2_df %>%
  select(year, cumulative_co2) %>%
  filter(cumulative_co2 == max(cumulative_co2, na.rm = TRUE)) %>%
  filter(year == max(year, na.rm = TRUE)) %>%
  pull(cumulative_co2)

#Amount of the most cumulative Oil CO2 Emissions

Cumulative_most_oil_CO2 <- CO2_df %>%
  select(year, cumulative_oil_co2) %>%
  filter(cumulative_oil_co2 == max(cumulative_oil_co2, na.rm = TRUE)) %>%
  filter(year == max(year, na.rm = TRUE)) %>%
  pull(cumulative_oil_co2)

# Amount of the most cumulative gas CO2 Emissions

Cumulative_most_gas_CO2 <- CO2_df %>%
  select(year, cumulative_gas_co2) %>%
  filter(cumulative_gas_co2 == max(cumulative_gas_co2, na.rm = TRUE)) %>%
  filter(year == max(year, na.rm = TRUE)) %>%
  pull(cumulative_gas_co2)

# Table of the emission values calculated

vec_emission_data <- c(Cumulative_most_CO2, Cumulative_most_oil_CO2, Cumulative_most_gas_CO2)

labels = c("Cumulative CO2","Cumulative Oil CO2","Cumulative Gas CO2")

emissions_df <- data.frame(labels, vec_emission_data)

colnames(emissions_df) <- c("Emission Type", "Total Emissions (Million Tonnes)", colnames(emissions_df)[-c(1, 2)])

view(emissions_df)

#Country Cumulative Oil CO2 Emissions Bar Graph

get_year_cumulative_oil_CO2 <- function() {
  country_cumulative <- filter(CO2_df, year >= 2000, year <= 2022) %>%
    group_by(year) %>%
    filter(cumulative_oil_co2 != "NA") %>%
    summarize(cumulative_oil_co2 = sum(cumulative_oil_co2))
  return(country_cumulative)   
}

plot_year_cumulative_oil_CO2 <- function() {
  ggplot(get_year_cumulative_oil_CO2(), aes(x = year, y = cumulative_oil_co2)) +
  geom_col(mapping = aes(x = year, y = cumulative_oil_co2)) +
  labs(x = "Year", title = "Cumulative Oil CO2 Emissions By Year (2000-2021)") +
  scale_y_continuous("Cumulative Oil CO2 Emissions (Million Tonnes)", labels = comma)
}

plot_year_cumulative_oil_CO2()
