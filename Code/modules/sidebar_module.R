sidebar_module_ui_fn <- function(id) {
  ns <- NS(id)
  
  sidebar_module_ui <- div(
    sidebarPanel(width = 12,
                 selectInput(inputId = ns("variable_select"), 
                             label = "Choose a view:",
                             choices = c()
                             ),
                 selectInput(inputId = ns("location_select"),
                             label = "Choose a location", 
                             choices = c()),
                 br(),
                 htmlOutput(outputId = ns("world_total"))
                 ), # end sidebarPanel
    dataTableOutput(outputId = ns("var_table"))
    ) # end div
  
  return(sidebar_module_ui)
}

sidebar_module_fn <- function(input, output, session, covid_data) {
  
  variable_select_vec <- covid_data %>% select(-c("iso_code", "location", "date", "tests_units")) %>% names
  names(variable_select_vec) <- variable_select_vec %>% 
    str_replace_all(pattern = "_", replacement = " ") %>% 
    str_to_title()
  
  country_select_vec <- covid_data %>% select(location) %>% distinct() %>% pull
  
  # Reactives ----
  reac_selections <- reactiveValues(var = NULL, country = NULL)
  
  # Observe Events ----
  observe({
    reac_selections$var <- input$variable_select
    reac_selections$country <- input$location_select
  })
  
  
  # Output ----
  output$var_table <- renderDataTable({
    req(reac_selections$var)
    
    covid_data %>% 
      filter(location != "World") %>%
      group_by(location) %>%
      slice(which.max(date)) %>%
      ungroup %>%
      select(location, !!as.name(reac_selections$var)) %>%
      arrange(desc(!!as.name(reac_selections$var))) %>%
      mutate(!!as.name(reac_selections$var) := format(!!as.name(reac_selections$var), big.mark = ",")) %>%
      rename_all(.funs = list(~ str_replace_all(., "_", " ") %>% str_to_title(.)))
  })
  
  output$world_total <- renderUI({
    req(reac_selections$var)
    
    HTML(
      "World ",
      reac_selections$var %>% str_replace_all("_", " ") %>% str_to_title,
      ": ",
      covid_data %>%
        filter(location == "World", date == max(covid_data$date, na.rm = TRUE)) %>%
        select(!!as.name(reac_selections$var)) %>%
        pull,
      "\n\n",
      "Last Updated: ",
      format(max(covid_data$date, na.rm = TRUE), format = "%b %d, %Y")
    )
    
  })
  
  updateSelectInput(session = session, 
                    inputId = "variable_select",
                    label = "Choose a view:",
                    choices = variable_select_vec)
  
  updateSelectInput(session = session, 
                    inputId = "location_select", 
                    choices = country_select_vec,
                    label = "Choose a location",
                    selected = "United States")
  
  
  
  return(reac_selections)
  
}