## Load library shiny
library(shiny)
library(plotly)

## Begin ui

CovidTable <- read.csv("covid_19_clean_complete.csv")

shinyUI(navbarPage(title = "Covid-19 Analysis",
                   tabPanel("About",
                            h1("About the Project"),
                            hr(),
                            img(src = "covid.jpg", height = 450, width = 750, align = "center"),
                            h4("Since the COVID-19 pandemic had a huge impact on 
                            everyone’s life, we are interested statistics of COVID-19 
                            worldwidely."),
                            h4("In this project, we will focus on the number of 
                            confirmed cases in different countries and in 
                            different regions and the spread of COVID-19 at 
                            the beginning of this epidemic."),
                            br(),
                            h5("The dataset we use is the COVID-19 Dataset on Kaggle,"),
                            h5("which is collected by Devakumar kp, from January 22nd 2020 to July 27th 2020."),
                            code("The data set could be access from the website:", a("https://www.kaggle.com/imdevskp/corona-virus-report")),
                            br(),
                            br(),
                            h2("Plot 1&2", style = "color:Purple"),
                            h3("Offers abilities to"),
                            h4("- Choice the start and end Month"),
                            h4("- Select the country you want to look at"),
                            h4("- Top graph shows the monthly death rate and the
                               Bottom graph shows the monthly recover rate"),
                            br(),
                            h2("Bar Plot", style = "color:Purple"),
                            h3("Offers abilities to"),
                            h4("- View in a bar plot form"),
                            h4("- Select data between Confirmed, Deaths, and Recovered rate"),
                            h4("- Different colors on the bar plot shows the 
                            data on different WHO.Region"),
                            br(),
                            h2("Table", style = "color:Purple"),
                            h3("Offers abilities to"),

                            h4("- select what variables to present"),
                            h4("- View in a data table form"),
                            h4("- Look at the specific data by searching key words at the search bar"),
                            h4("- Return the rank of differenct categories"),
                            
                            hr(),
                            h1("App Creators"),
                            img(src = "team.jpg", height = 450, width = 750, align = "left"),
                            h4("- Qirui Wang"),
                            br(),
                            h4("- Ruibo Chen"),
                            br(),
                            h4("- Wendy Huang"),
                            br(),
                            h4("- Jieyun Xie"),
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
                                          mainPanel(
                                                    h3("Pandemic around the world in 2020"),
                                                    h4("These two graphs show the monthly death rate and monthly recover rate versus"),
                                                    h4("the time which is measured in month. With line graphs, we could easily compare"),
                                                    h4("the different situations and strategies each country uses in the pandemic."),
                                                    
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
                                          mainPanel(
                                                    h3("Pandemic around the world in 2020"),
                                                    h4("This bar plot shows the total confirmed cases, total death cases, and total recovered cases"),
                                                    h4("of each WHO.Region in each month. With this plot, we can compare the situations in each WHO.Region."),
                                                    h4("Thus, we could have a insight into the methods different region uses to cope with this pandemic."),
                                            
                                                    ## Plot the bar plot
                                                    plotlyOutput("barPlot")
                                                    )
                                          )
                            ),
                   tabPanel("Table",
                            
                            sidebarLayout(
                                          sidebarPanel(
                                                       ## Widget that allows users to select what variables of the obserations to present
                                                       checkboxGroupInput("checkColumn", label = h3("Choose what data to present"), 
                                                                          choices = list("Confirmed" = "Confirmed", "Deaths" = "Deaths", "Recovered" = "Recovered",
                                                                                         "Active" = "Active", "total confirmed" = "tot_confirmed", "total deaths" = "tot_death",
                                                                                         "total active" = "tot_active", "monthly death rate" = "monthly_death_rate", 
                                                                                         "monthly recover rate" = "monthly_recover_rate"),
                                                                          selected = "Confirmed")
                                                       ),
                                          mainPanel(
                                                    h3("This table shows the data we used to create our plots and get conclusions"),
                                                    h4("You can select what you interested data and table will present what you selected"),
                                                    
                                                    dataTableOutput("data")
                                          )
                            )
                            
                            ),
                   tabPanel("Conclusion",
                            img(src = "question.jpg", height = 450, width = 750, align = "center"),
                            
                            h1("Conclusion/Analysis"),
                            p("- From plot1, we found that on the first and month, 
                               there are not a lot of countries that had death 
                               cases. However, since the thrid month, the death 
                               rate started occurring in a lot of countries. And 
                               we think this phenomenon is related to the feature 
                               of Covid-19 virus has a terribly long incubation period.
                               Because the incubation period cause people hard to realized
                               that they got affected, and still went out meeting people, 
                               which spreads the virus out more, therefore, since 
                               more people got affcted, more deaths will happen."),
                            br(),
                            p("- From plot2, we found that the recover rate was
                               higher than the death rate in all the countries,
                               this phenomenon proved that the case fatality rate of
                               Covid-19 virus is not very high."),
                            br(),
                            p("- From the bar plot, we found that the WHO.Region that has most obvious changes on the", 
                              span("Confirmed rate", style = "color:Red"),
                              "is American, which is increasing dramatically
                               since month 4, and the second WHO.Region that has most changes is 
                               Europe, however, on the seventh month, the confirmed rate of Europe
                               is less than a half of American."),
                            br(),
                            p("- From the bar plot, we found that both American and Europe has very high", 
                              span("Deaths rate", style = "color:Red"),
                              "compared to other WHO.Regions. Especially American had
                              reached over 8000000 Death cases."),
                            p("- From the bar plot, we found that the American has the highest", 
                              span("Recovered rate", style = "color:Red"),
                              "comparing to other WHO.Regions, and this might becuase that
                              American has the highest Comfirmed rate, which also will lead to a
                              hiest recovered rate"),
                            p("- From the table, we found that Sudan has the highest",
                              span("Death rate", style = "color:Red"),
                              "even though it only has 53 cases in total. And we indicate that the reason why Sudan has such a high death rate for small amout of cases is due to the poverty."),
                            br(),
                            p("- We believe that the quality of the initial data set is reasonable. 
                              The conclusions drawn from the data set are fair because, in the initial data set, 
                              the data are about four kinds of data for all countries in the same period. 
                              So the initial data set does not have a special bias against any particular data."),
                            br(),
                            p("- For advancing the project, 
                              the initial data set can be collected continuously and the duration of the initial data can be extended. 
                              When the epidemic is completely over, a new data set can be generated, 
                              to better study the attitude and means of each country towards epidemic prevention. 
                              The data sets can also be combined with GDP to investigate the relationship between GDP and epidemic prevention."),
                            )
                   
                   )
        )

