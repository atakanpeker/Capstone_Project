library(tidyverse)
library(lubridate)
library(ggplot2)


getwd()
setwd("C:/Users/lenovo/Desktop/Google Data Analytics Certificate/My Capstone Project/Cyclistic_tripdata/Cyclistic_tripdata_csv")

m11_2020 <- read.csv("202011-divvy-tripdata.csv")
m12_2020 <- read.csv("202012-divvy-tripdata.csv")
m01_2021 <- read.csv("202101-divvy-tripdata.csv")
m02_2021 <- read.csv("202102-divvy-tripdata.csv")
m03_2021 <- read.csv("202103-divvy-tripdata.csv")
m04_2021 <- read.csv("202104-divvy-tripdata.csv")
m05_2021 <- read.csv("202105-divvy-tripdata.csv")
m06_2021 <- read.csv("202106-divvy-tripdata.csv")
m07_2021 <- read.csv("202107-divvy-tripdata.csv")
m08_2021 <- read.csv("202108-divvy-tripdata.csv")
m09_2021 <- read.csv("202109-divvy-tripdata.csv")
m10_2021 <- read.csv("202110-divvy-tripdata.csv")

#inspect columns to look for different column names
colnames(m11_2020)
colnames(m12_2020)
colnames(m01_2021)
colnames(m02_2021)
colnames(m03_2021)
colnames(m04_2021)
colnames(m05_2021)
colnames(m06_2021)
colnames(m07_2021)
colnames(m08_2021)
colnames(m09_2021)
colnames(m10_2021)
#all column names are the same.

#inspect data frames to find inconsistency
str(m11_2020)
str(m12_2020)
str(m01_2021)
str(m02_2021)
str(m03_2021)
str(m04_2021)
str(m05_2021)
str(m06_2021)
str(m07_2021)
str(m08_2021)
str(m09_2021)
str(m10_2021)

#change data format of m11_2020 to make it consistent with other data

m11_2020$started_at <- strptime(m11_2020$started_at, format = "%d/%m/%Y %H:%M")
m11_2020$started_at <- format(m11_2020$started_at, "%Y-%m-%d %H:%M:%S")

m11_2020$ended_at <- strptime(m11_2020$ended_at, format = "%d/%m/%Y %H:%M")
m11_2020$ended_at <- format(m11_2020$ended_at, "%Y-%m-%d %H:%M:%S")

# "start_station_id" and "end_station_id" of m11_2021 dataframe are classified
# as integers, so we should convert them as character.

m11_2020 <- mutate(m11_2020, start_station_id = as.character(start_station_id),
                   end_station_id = as.character(end_station_id))

#now we can stack all data frames into a single big data frame called all_trips.

all_trips <- bind_rows(m11_2020, m12_2020, m01_2021, m02_2021, m03_2021, m04_2021,
                       m05_2021, m06_2021, m07_2021, m08_2021, m09_2021, m10_2021)

#inspect the new data frame.

colnames(all_trips)
nrow(all_trips)
dim(all_trips)
str(all_trips)
head(all_trips)
summary(all_trips)

#Using lubridate package to find the ride_length

starttime <- ymd_hms(all_trips$started_at)
endtime <- ymd_hms(all_trips$ended_at)

#add "ride_length" into our data frame by using difftime, values indicates seconds.

all_trips$ride_length <- difftime(endtime, starttime, units = "secs")
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))

#add "day_of_week" column into our data frame

all_trips$day_of_week <- format(as.Date(as.Date(all_trips$started_at)), "%A")

#inspect negative ride_length values and delete them from our dataframe by
#creating a new version of our dataframe (v2)
negative_ride_length <- filter(all_trips, ride_length < 0)

all_trips_v2 <- filter(all_trips, ride_length >= 0)

#descriptive analysis on ride_length

summary(all_trips_v2$ride_length)

#compare members and casual users

aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)

#run the average time by each day members vs casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + 
            all_trips_v2$day_of_week, FUN = mean)

#data is not ordered by day_of_week, order the whole data frame to fix it.

all_trips_v2$day_of_week <- factor(all_trips_v2$day_of_week,
                                   levels = c("Sunday", "Monday", "Tuesday", "Wednesday",
                                              "Thursday", "Friday", "Saturday"), ordered = TRUE)

#run the aggregate function again to see it as ordered.

aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + 
            all_trips_v2$day_of_week, FUN = mean)

#analyze ridership data by type of riders and weekday

all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(),
            average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday)

#Let's visualize this analysis, the number of rides by rider type

all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(),
            average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) %>%
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  labs(title = "Number of Rides by Rider Type",
       x = "Weekday", y = "Number of Rides",
       fill = "Rider Type") +
  theme(plot.title = element_text(hjust = 0.5))

#Also, let's visualize average ride duration by rider type

all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(),
            average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) %>%
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("#009E73", "#CC79A7")) +
  labs(title = "Average Duration by Rider Type",
       x = "Weekday", y = "Average Duration",
       fill = "Rider Type") +
  theme(plot.title = element_text(hjust = 0.5))

#Finally, create a csv file that is used to visualize

aggregate_data <- aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual +
                      all_trips_v2$day_of_week, FUN = mean)

write.csv(aggregate_data, file = "C:/Users/lenovo/Desktop/Google Data Analytics Certificate/My Capstone Project/avg_ride_length.csv")


