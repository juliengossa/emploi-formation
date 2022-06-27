#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggcpesrthemes)
library(dplyr)
library(ggplot2)
library(gtsummary)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("ages",
                        "Ages:",
                        min = 1,
                        max = 100,
                        value = c(15,29))
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("activitePlot")
        )
    )
))
