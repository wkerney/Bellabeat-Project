#Find and Load Packages
install.packages("dplyr")
install.packages("ggplot2")
install.packages("tidyverse")
install.packages("tidyr")
install.packages("readr")
install.packages("lubridate")
library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)
library(lubridate)

#Import and Rename Tables

daily_activity <-read_csv("dailyActivity_merged - dailyActivity_merged.csv")
heart_rate <- read_csv("heartrate_seconds_merged.csv")
daily_calories <- read_csv("dailyCalories_merged - dailyCalories_merged.csv")
weight_data <- read_csv("weightLogInfo_merged -  weightLogInfo_merged Clean.csv")  
sleep_data <- read_csv("sleepDay_merged - sleepDay_merged.csv")

#Using Head() to get a better view of the data sources
head(daily_activity)
head(heart_rate)
head(daily_calories)
head(weight_data)
head(sleep_data)

#Using str() to get a view of the structures of the dataframes
str(daily_activity)
str(heart_rate)
str(daily_calories)
str(weight_data)
str(sleep_data)

#Cleaning and formatting dates to be consistent
daily_activity$ActivityDate <- as.Date(daily_activity$ActivityDate, format = "%m/%d/%Y")
sleep_data$SleepDay <- as.Date(sleep_data$SleepDay, format = "%m/%d/%Y")
heart_rate$Time <- as.Date(heart_rate$Time, format = "%m/%d/%Y")
daily_calories$ActivityDay <- as.Date(daily_calories$ActivityDay, format = "%m/%d/%Y")
weight_data$Date <- as.Date(weight_data$Date, format = "%m/%d/%Y")

#Data exploration through summazing
#Daily Activity
daily_activity %>% 
  select(TotalSteps, VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes, Calories) %>%
  summary()
#Sleep Data
sleep_data %>% 
  select(TotalMinutesAsleep, TotalTimeInBed) %>%
  summary()
#Heart Rate
heart_rate %>%
  select(Value) %>%
  summary()
#Weight Data
weight_data %>% 
  select(WeightKg, WeightPounds, Fat, BMI) %>%
  summary()
#Daily Calories
daily_calories %>% 
  select(Calories) %>%
  summary()

#Merging data
merged_data <- merge(daily_activity, sleep_data, by=c('Id'))
head(merged_data)

#Vizzes to reinforce our findings after exploration

#Total steps vs. Calories

ggplot(data=daily_activity, aes(x=TotalSteps, y=Calories)) + 
  geom_point() + geom_smooth() + labs(title="Total Steps vs. Calories")

#Total steps taken over time

ggplot(data = daily_activity, aes(x = ActivityDate, y = TotalSteps)) +
  geom_line() +
  labs(title = "Trends in Total Steps Over Time",
       x = "Date",
       y = "Total Steps") +
  theme_minimal()

#Total Steps Distribution

ggplot(data = daily_activity, aes(x = TotalSteps)) + 
  geom_histogram(binwidth = 1000, fill = "green", color = "brown") + 
  labs(title = "Distribution of Total Steps",
       x = "Total Steps",
       y = "Frequency")
