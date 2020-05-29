mainpanel_module_ui_fn <- function(id) {
  ns <- NS(id)
  
  mainpanel_module_ui <- mainPanel(width = 12,
                                   # box(
                                     title = "Metrics Plot",
                                     solidHeader = TRUE,
                                     
                                     plotOutput(outputId = ns("plot_view"), 
                                                hover = hoverOpts(id = ns("plot_hover"), 
                                                                  delay = 0),
                                                height = "800px"),
                                     htmlOutput(ns("hover_info"))
                                   # ) # end box
  ) # end mainPanel
  
  return(mainpanel_module_ui)
}

mainpanel_module_fn <- function(input, output, session, covid_df, var_selections) {
  ns <- session$ns
  plot_fill <- "#2a52be"
  # Reactives ----
  reac_inputs <- reactiveValues(df = NULL)
  
  # Observe Events ----
  observe({
    req(var_selections$var,
        var_selections$country, 
        covid_df)
    
    reac_inputs$df <- covid_df %>%
      filter(location == var_selections$country) %>%
      select(date, !!as.name(var_selections$var))
    
  })
  
  output$plot_view <- renderPlot({
    req(reac_inputs$df)
    
    reac_inputs$df %>%
      ggplot(mapping = aes(x = date, y = !!as.name(var_selections$var))) +
      geom_col(width = 1, fill = plot_fill) +
      geom_smooth(method = "loess", formula = 'y ~ x', color = 'red', se = FALSE) + 
      scale_x_date(labels = date_format("%b-%d-%Y"), date_breaks = "1 month") +
      scale_y_continuous(labels = comma) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            text = element_text(size = 20)) +
      xlab(label = "Date") +
      ylab(label = str_to_title(str_replace_all(var_selections$var, "_", " "))) +
      ggtitle(var_selections$country)
    
  })
  
  output$hover_info <- renderUI({
    req(input$plot_hover)
    
    HTML("<b>",
        "Value: ",
        format(round(input$plot_hover$y), big.mark = ","),
        "</b>")
  })
}