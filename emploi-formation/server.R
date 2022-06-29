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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
   load("../emploi.RData")
   load("../emploiact.RData")
   load("../sansemploi.RData")
   load("../NEET.RData")
   load("../popjeunes.RData")
   load("../Jeunes_census.RData")
   load("../emploichom.RData")
   load("../Jeunes_Actifs_Etudiants.RData")
  
    source("../emploi-formation.R", encoding = "UTF-8")
    
    output$activitePlot <- renderPlot({
        plot_activite(input$ages[1], input$ages[2], input$annees[1], input$annees[2])

    })
    output$diplomePlot <- renderPlot({
      plot_activite3(input$ages[1], input$ages[2], input$annees[1], input$annees[2])
      
    })
    output$apprentisPlot <- renderPlot({
      plot_Apprentis(input$ages[1], input$ages[2], input$annees[1], input$annees[2])
      
    })
    output$activitePlot2 <- renderPlot({
      plot_activite7(input$ages[1], input$ages[2], input$annees[1], input$annees[2])
      
    })
    
    output$diplomePlot2 <- renderPlot({
      plot_activite8(input$ages[1], input$ages[2], input$annees[1], input$annees[2])
      
    })
})



