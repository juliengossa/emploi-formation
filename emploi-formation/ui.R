#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

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
<<<<<<< HEAD
                        value = c(20,30))
=======
                        value = c(15,30)),
            sliderInput("annees",
                        "Anées:",
                        min = 1969,
                        max = 2020,
                        value = c(1969,2020))
>>>>>>> 25ee6e0f85785dc16b3634b1db84f50ee3d77ccf
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("activitePlot")
        )
    )
))
