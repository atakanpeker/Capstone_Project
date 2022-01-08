# Cyclistic Project

This is my Capstone project of Google Data Analytics Professional Certificate program. 
This program gave me a data about a fictional company called "Cyclistic". 
It is a bike-share company that has casual riders and annual members.
My business task is to analyse previous 12 months of bike trip data of Cyclistic and identify trends to answer how annual members and casual riders differ.

This project includes the R file, R markdown file, github document, and two graph images.

To read my Capstone Project report, please click on the github document called "Cyclistic_Project_Github.md".

# Code and Resources Used

**R version:** 4.1.2
**Packages:** Tidyverse, Lubridate, ggplot2

## Data Wrangling

I have 12 months data and combine it to a single data frame. These are the columns:
* ride_id: Id of the ride
* rideable_type: type of the bikes
* started_at: when it is started
* ended_at: when it is ended
* start_station_name
* start_station_id: station Id where it is started
* end_station_name
* end_station_id: station Id where it is ended
* start_lat: latitude
* start_lng: longitude
* end_lat: latitude
* end_lng: longitude
* member_casual: whether the rider is a member or casual

"started_at" and "ended_at" data of November 2020 is different from rest of the data, so I changed it.

## Data Cleaning

To made an analysis, I need to clean the data and add columns.

* Made a column named "ride_length" which is the average duration that the riders used the bicycle. 
* Removed rows that has negative "ride_length" values which is impossible. 
* Made a column named "day_of_week" to analyse between weekdays and weekends.
* Include "number_of_rides" data which is how many times riders used the bicycles.

## EDA

![](https://github.com/atakanpeker/Google_Certificate_Capstone_Project/blob/main/unnamed-chunk-18-1.png)

![](https://github.com/atakanpeker/Google_Certificate_Capstone_Project/blob/main/unnamed-chunk-19-1.png)

