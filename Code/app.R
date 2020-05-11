# Author: Benji Wagner
# Date Created: 4/24/2020
# 
# This shiny application is intended to visualize the number of COVID-19 cases 

file_path <- "./Code/modules/"
sapply(list.files(file_path), source, .GlobalEnv)

library(shiny)
library(tidyverse)


# UI ----
ui <- fluidPage(
  sidebar_module_ui_fn("sidebar")
    
)

# Server ----
server <- function(input, output, session) {
  
  # Reactives ----
  reac_covid <- reactiveValues(df = NULL)
  
  
  # Download the updated data from URL
  reac_covid$df <- read_csv(file = "https://covid.ourworldindata.org/data/owid-covid-data.csv")
  # Note from the data masters:
  # Our complete COVID-19 dataset is a collection of the COVID-19 data maintained by Our World in Data.
  # It is updated daily and includes data on confirmed cases, deaths, and testing, as well as 
  # other variables of potential interest.
  
  callModule(sidebar_module, "sidebar", reac_covid$df)
  
}

# Run the application 
shinyApp(ui = ui, server = server)
