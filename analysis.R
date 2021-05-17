library(dplyr)
library(maps)
library(ggplot2)

data <- read.csv("covid_19_clean_complete.csv")

changed_data <- data %>%
  mutate(death_rate = Deaths / Confirmed) %>%
  filter(Country.Region == "China") %>%
  filter(Date %in% c("2020-02-01","2020-03-01","2020-04-01","2020-05-01","2020-06-01","2020-07-01")) %>%
  filter(Province.State %in% c("Hubei","Beijing","Sichuan")) %>%
  select(Province.State, Country.Region, Date, death_rate) 

point <- ggplot(changed_data) +
  geom_line(aes(Date, death_rate, group = Province.State, col = Province.State))

point
