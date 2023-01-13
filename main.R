#Libraries
library(tidyverse)
library(stringr)
library(forcats)
library(readxl)
library(lubridate)

#Import weather data and clean
weather_raw <- read.csv("weather_data.csv") |> filter(!is.na(TMAX) & !is.na(TMIN)) |> mutate(
  DATE = mdy(DATE)
) |> 
  gather("TMAX", "TMIN", key = "min_or_max", value = "Temperature") |> 
  filter(DATE >= ymd(20080101))

#Grouping by month and summarizing high and low temperature data
weather_grouped <- weather_raw |> 
  mutate(
    year = year(DATE),
    month = month(DATE)
  ) |> 
  group_by(year, month, min_or_max) |> 
  summarize(avg_temp = mean(Temperature)) |> 
  mutate(
    date = make_date(year, month)
  ) |> 
  ungroup() |> 
  select(date, min_or_max, avg_temp)

ggplot(weather_grouped, aes(date, avg_temp, color = min_or_max)) +
  geom_line() +
  geom_hline(yintercept = 16.8, color = "Blue") +
  geom_hline(yintercept = 25.2, color = "Red") +
  geom_point(data = filter(weather_grouped, month(date) == 12), aes(date, avg_temp, color = min_or_max)) +
  geom_point(data = filter(weather_grouped, month(date) == 1), aes(date, avg_temp), color = "Black") +
  labs(color = "Temp Max or Min", title = "Average Monthly Temperatures - Grand Haven, MI", caption = "Source: National Oceanic and Atmospheric Administration \n Average daily high and low temperature data was grouped by month. \n Points represent the month of December for each year. \n Horizontal lines mark the average daily high and low for Dec 2022.") +
  xlab("Date") +
  ylab("Temperature (F)")

ggsave(filename = "Temperature_Plot.pdf")
