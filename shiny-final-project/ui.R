## Load library shiny
library(shiny)
library(plotly)

## Begin ui
shinyUI(navbarPage(title = "Covid-19 Analysis",
                   tabPanel("About",
                            h4("This app uses navbar for layout"),
                            ),
                   
                   tabPanel("plot1&2",
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
                            ),
                   
                   tabPanel("bar plot",
                            
                            sidebarLayout(
                                          sidebarPanel(
                                                       ## Widget that allow users to select which category to plot
                                                       radioButtons("category", label = h3("Confirmed/Deaths/Recovered"),
                                                                    choices = list("Confirmed" = "totalConfirmed", "Deaths" = "totalDeaths", Recovered = "totalRecovered"), 
                                                                    selected = "totalConfirmed")
                                                       ),
                                          mainPanel("Pandemic around the world in 2020",
                                                    ## Plot the bar plot
                                                    plotlyOutput("barPlot")
                                                    )
                                          )
                            ),
                   tabPanel("Table",
                     
                            )
                   
                   )
        )

