#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    
    load("../emploi.RData")
    
    source("../emploi-formation.R")
    
    output$activitePlot <- renderPlot({
        plot_activite(input$ages[1], input$ages[2])

    })

})
