# Author: Benji Wagner
# Date Created: 4/24/2020
# 
# This shiny application is intended to visualize the number of COVID-19 cases

function_files <- list.files("./funcs/", pattern = "*.R", full.names = TRUE)
module_files <- list.files("./modules/", pattern = "*.R", full.names = TRUE)
sapply(function_files, source)
sapply(module_files, source)

library(shiny)
library(shinydashboard)
library(lubridate)
library(tidyverse)
library(scales)
library(shinythemes)
library(DT)


# UI ----
ui <- fluidPage(theme = shinytheme("cerulean"),
  headerPanel(title = "COVID-19 Metrics Dashboard"),
  column(width = 3,
         sidebar_module_ui_fn("sidebar")
  ),
  column(width = 9,
         mainpanel_module_ui_fn("main")
  )
) # end UI

# Server ----
server <- function(input, output, session) {
  
  # Globals ----
  covid_data <- read_covid_data_fn()
  
  # Reactives ----
  reac_select <- reactiveValues(var = NULL, country = NULL)
  
  var_selections <- callModule(sidebar_module_fn, "sidebar", covid_data) 
  callModule(mainpanel_module_fn, "main", covid_data, reac_select)
  
  observe({
    req(var_selections)
    
    reac_select$var <- var_selections$var
    reac_select$country <- var_selections$country
  })
  
  
} # end server

# Run the application 
shinyApp(ui = ui, server = server)
