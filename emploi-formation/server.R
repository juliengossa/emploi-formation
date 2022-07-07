#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(shinyWidgets)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
    source("ef-functions.R", encoding = "UTF-8")
    theme_set(theme_minimal())
    
    output$categoriePlot <- renderPlot({
      plot_categorie(input$categorie, input$ages[1], input$ages[2], input$annees[1], input$annees[2], input$cb_position, input$cb_na)
    })

    output$categorieSlicePlot <- renderPlot({
      plot_categorie_slice(input$categorie, input$ages[1], input$ages[2], input$annees[1], input$annees[2], input$cb_position, input$cb_na)
    })

    output$categorieSlicePonctuel <- renderPlot({
      plot_categorie_ponctuel(input$categorie, input$ages[1], input$ages[2], input$annees[1], input$annees[2], input$cb_position, input$cb_na)
    })
    
})


