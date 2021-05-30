## Load library shiny
library(shiny)
library(plotly)

## Begin ui
shinyUI(fluidPage(
    ## Using layout to arrange sidebars and main panel
    sidebarLayout(
        sidebarPanel(
            ## Add numeric input to select the start month
            numericInput("num1", label = "Month start", value = 1),
            ## Add numeric input to select the end month
            numericInput("num2", label = "Month end", value = 7),
            ## Output the ui coded in the server file
            uiOutput("country")
        ),
        mainPanel("Pandemic around the world in 2020",
                  ## put two graphs in a line
                  plotlyOutput("graph1"), 
                  plotlyOutput("graph2")
        )
    )
))
