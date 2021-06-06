## Load libraries
library(dplyr)
library(ggplot2)
library(shiny)
## This is a new package needed for this code
## The function of this package is to show values when mouse over the ggplot
## The under code is for install the package
## install("plotly")
library(plotly)

## Load the data from  file
data <- read.csv("covid_19_clean_complete.csv")
## Change the data into the form we wanted
new_data <- data %>%
    ## Rule out the Lat and Long
    select(Country.Region, Province.State, Date,
           Confirmed, Deaths, Recovered, Active, WHO.Region) %>%
    ## Give each date a month
    mutate(month = ifelse(Date %in% as.character(seq(from = as.Date("2020-01-01"), to = as.Date("2020-01-31"), by = "days")),"1",
                          ifelse(Date %in% as.character(seq(from = as.Date("2020-02-01"), to = as.Date("2020-02-29"), by = "days")),"2",
                                 ifelse(Date %in% as.character(seq(from = as.Date("2020-03-01"), to = as.Date("2020-03-31"), by = "days")),"3",
                                        ifelse(Date %in% as.character(seq(from = as.Date("2020-04-01"), to = as.Date("2020-04-30"), by = "days")),"4",
                                               ifelse(Date %in% as.character(seq(from = as.Date("2020-05-01"), to = as.Date("2020-05-31"), by = "days")),"5",
                                                      ifelse(Date %in% as.character(seq(from = as.Date("2020-06-01"), to = as.Date("2020-06-30"), by = "days")),"6",
                                                             ifelse(Date %in% as.character(seq(from = as.Date("2020-07-01"), to = as.Date("2020-07-31"), by = "days")),"7","non")))))))) %>%
    ## Group by country first, then within the country, group by month
    group_by(Country.Region, month) %>%
    ## Compute monthly total confirmed, death, recover, and active
    mutate(tot_confirmed = sum(Confirmed, na.rm = TRUE)) %>%
    mutate(tot_death = sum(Deaths, na.rm = TRUE)) %>%
    mutate(tot_recover = sum(Recovered, na.rm = TRUE)) %>%
    mutate(tot_active = sum(Active, na.rm = TRUE)) %>%
    ## Compute monthly death and recover rates
    mutate(monthly_death_rate = tot_death / tot_confirmed) %>%
    mutate(monthly_recover_rate = tot_recover / tot_confirmed)

## bar graph related data set
barData <- new_data %>% 
    ## group by WHO region first and then within the region, group by month
    group_by(WHO.Region, month) %>% 
    ## generate the total death, recover, and active number
    summarize(totalDeaths = sum(Deaths), totalConfirmed = sum(Confirmed), totalRecovered = sum(Recovered))



## Begin server
shinyServer(function(input, output) {
    ## create a function to manipulate raw data
    sample <- reactive({
        ## Use if/else function to render the data when changing countries
        if(is.null(input$country)){
            new_data %>%
                ## To filter the time range with entered number
                filter(month %in% input$num1:input$num2)
        }else{
            new_data %>%
                filter(month %in% input$num1:input$num2) %>%
                ## The only difference from above is to filter the country with selected
                filter(Country.Region %in% input$country)
        }
    })
    ## Create a ui in server file due to the number of countries is large
    output$country <- renderUI({
        checkboxGroupInput(inputId = "country", label = "Select countries",
                           choices = unique(new_data$Country.Region))
    })
    ## Generate the line graph of the selected data
    output$graph1 <- renderPlotly({
        ggplot(sample())+
            ## Change the color of the line related to the selected countries
            geom_line(aes(x = month, y = monthly_death_rate,
                          group = Country.Region, color = Country.Region, na.rm = TRUE))+
            labs(x = "Month", y = "Monthly Death Rate")
    })
    output$graph2 <- renderPlotly({
        ggplot(sample())+
            ## Change the color of the line related to the selected countries
            geom_line(aes(x = month, y = monthly_recover_rate,
                          group = Country.Region, color = Country.Region, na.rm = TRUE))+
            labs(x = "Month", y = "Monthly Recover Rate")
    })
    
    ## Generate the bar plot of the statistics of Covid in different WHO.Region
    output$barPlot <- renderPlotly({
        argument <- rlang::sym(input$category)
        ggplot(barData, 
               mapping = aes(x = month, y = !!argument, fill = WHO.Region)) +
            geom_bar(stat = "identity", position = "dodge")
    })
    
    ## Generate the data table
    output$data <- renderDataTable({
        new_data
    })
})
