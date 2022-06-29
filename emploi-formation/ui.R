#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)




shinyUI(fluidPage(
  
  # Application title
  titlePanel("Répartition des individus selon l'activité et le diplôme"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("ages",
                  "Ages:",
                  min = 1,
                  max = 100,
                  value = c(15,30))),
      
        sidebarPanel(
    sliderInput("annees",
                "Années:",
                min = 1971,
                max = 2020,
                value = c(1971,2020)))
    
  ),
  
  # Show a plot of the generated distribution
  
  
  mainPanel(
    plotOutput("activitePlot"), plotOutput("activitePlot2"), plotOutput("diplomePlot"), plotOutput("diplomePlot2"), plotOutput("apprentisPlot")
  )
)
)




