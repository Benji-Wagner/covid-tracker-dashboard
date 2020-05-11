sidebar_module_ui_fn <- function(id) {
  ns <- NS(id)
  
  sidebar_module_ui <- sidebarPanel(width = 2,
                                    selectInput(inputId = "variable_select", 
                                                label = "Choose a view:",
                                                choices = c("Total Cases", 
                                                            "New Cases", 
                                                            "Total Deaths",
                                                            "New Deaths",
                                                            "Total Cases Per Million",
                                                            "New Cases Per Million",
                                                            "Total Deaths Per Million",
                                                            "New Deaths Per Million",
                                                            "Total Tests",
                                                            "New Tests")
                                    ),
                                    
                                    selectInput(inputId = "location_select", 
                                                label = "Choose a location", 
                                                choices = c())
  )
  
  return(sidebar_module_ui)
}

sidebar_module_fn <- function(input, output, session, covid_data) {
  
  observe({
    req(reac_covid)
    
    updateSelectInput(session = session, 
                      inputId = "location_select", 
                      choices = covid_data %>% select(location) %>% pull,
                      selected = "United States")
  })
  
  
  
}