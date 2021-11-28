Cyclistic Project
================
Atakan Peker
28/11/2021

## Google Data Analytics Capstone Project

### About

This is my Capstone project of Google Data Analytics Professional
Certificate program. This program gave me a data about a fictional
company called “Cyclistic”. It is a bike-share company that has casual
riders and annual members. The team wants to design a new marketing
strategy to convert the casual riders into annual members because the
annual members are much more profitable than casual riders.

Cyclistic has 5824 bicycles and 692 stations across Chicago. The pricing
plans are single-ride passes, full-day passes for casual riders, and
annual memberships for cyclistic members. The company claims that the
key for future growth is maximizing the number of annual members.

My business task is to analyse previous 12 months of bike trip data of
Cyclistic and identify trends to answer how annual members and casual
riders differ. To do that, the case study gave me some bullet points,
such as finding the average duration and day of week as mentioned in the
below.

Using tidyverse, lubridate, and ggplot2 packages.

``` r
library(tidyverse)
```

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.3.5     v purrr   0.3.4
    ## v tibble  3.1.5     v dplyr   1.0.7
    ## v tidyr   1.1.4     v stringr 1.4.0
    ## v readr   2.0.2     v forcats 0.5.1

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(lubridate)
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

``` r
library(ggplot2)
```

Setting my working directory to read the csv files.

``` r
getwd()
setwd("C:/Users/lenovo/Desktop/Google Data Analytics Certificate/My Capstone Project/Cyclistic_tripdata/Cyclistic_tripdata_csv")
```

### Collecting the data

Reading and Assigning each csv files.

``` r
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
```

### Wrangle Data and Combine into a Single File

Inspecting the column names of each data.

``` r
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
```

Looking at the data types of each data.

``` r
str(m11_2020)
```

    ## 'data.frame':    259716 obs. of  13 variables:
    ##  $ ride_id           : chr  "BD0A6FF6FFF9B921" "96A7A7A4BDE4F82D" "C61526D06582BDC5" "E533E89C32080B9E" ...
    ##  $ rideable_type     : chr  "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : chr  "01/11/2020 13:36" "01/11/2020 10:03" "01/11/2020 00:34" "01/11/2020 00:45" ...
    ##  $ ended_at          : chr  "01/11/2020 13:45" "01/11/2020 10:14" "01/11/2020 01:03" "01/11/2020 00:54" ...
    ##  $ start_station_name: chr  "Dearborn St & Erie St" "Franklin St & Illinois St" "Lake Shore Dr & Monroe St" "Leavitt St & Chicago Ave" ...
    ##  $ start_station_id  : int  110 672 76 659 2 72 76 NA 58 394 ...
    ##  $ end_station_name  : chr  "St. Clair St & Erie St" "Noble St & Milwaukee Ave" "Federal St & Polk St" "Stave St & Armitage Ave" ...
    ##  $ end_station_id    : int  211 29 41 185 2 76 72 NA 288 273 ...
    ##  $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...
    ##  $ start_lng         : num  -87.6 -87.6 -87.6 -87.7 -87.6 ...
    ##  $ end_lat           : num  41.9 41.9 41.9 41.9 41.9 ...
    ##  $ end_lng           : num  -87.6 -87.7 -87.6 -87.7 -87.6 ...
    ##  $ member_casual     : chr  "casual" "casual" "casual" "casual" ...

``` r
str(m12_2020)
```

    ## 'data.frame':    131573 obs. of  13 variables:
    ##  $ ride_id           : chr  "70B6A9A437D4C30D" "158A465D4E74C54A" "5262016E0F1F2F9A" "BE119628E44F871E" ...
    ##  $ rideable_type     : chr  "classic_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : chr  "2020-12-27 12:44:29" "2020-12-18 17:37:15" "2020-12-15 15:04:33" "2020-12-15 15:54:18" ...
    ##  $ ended_at          : chr  "2020-12-27 12:55:06" "2020-12-18 17:44:19" "2020-12-15 15:11:28" "2020-12-15 16:00:11" ...
    ##  $ start_station_name: chr  "Aberdeen St & Jackson Blvd" "" "" "" ...
    ##  $ start_station_id  : chr  "13157" "" "" "" ...
    ##  $ end_station_name  : chr  "Desplaines St & Kinzie St" "" "" "" ...
    ##  $ end_station_id    : chr  "TA1306000003" "" "" "" ...
    ##  $ start_lat         : num  41.9 41.9 41.9 41.9 41.8 ...
    ##  $ start_lng         : num  -87.7 -87.7 -87.7 -87.7 -87.6 ...
    ##  $ end_lat           : num  41.9 41.9 41.9 41.9 41.8 ...
    ##  $ end_lng           : num  -87.6 -87.7 -87.7 -87.7 -87.6 ...
    ##  $ member_casual     : chr  "member" "member" "member" "member" ...

``` r
str(m01_2021)
```

    ## 'data.frame':    96834 obs. of  13 variables:
    ##  $ ride_id           : chr  "E19E6F1B8D4C42ED" "DC88F20C2C55F27F" "EC45C94683FE3F27" "4FA453A75AE377DB" ...
    ##  $ rideable_type     : chr  "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : chr  "2021-01-23 16:14:19" "2021-01-27 18:43:08" "2021-01-21 22:35:54" "2021-01-07 13:31:13" ...
    ##  $ ended_at          : chr  "2021-01-23 16:24:44" "2021-01-27 18:47:12" "2021-01-21 22:37:14" "2021-01-07 13:42:55" ...
    ##  $ start_station_name: chr  "California Ave & Cortez St" "California Ave & Cortez St" "California Ave & Cortez St" "California Ave & Cortez St" ...
    ##  $ start_station_id  : chr  "17660" "17660" "17660" "17660" ...
    ##  $ end_station_name  : chr  "" "" "" "" ...
    ##  $ end_station_id    : chr  "" "" "" "" ...
    ##  $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...
    ##  $ start_lng         : num  -87.7 -87.7 -87.7 -87.7 -87.7 ...
    ##  $ end_lat           : num  41.9 41.9 41.9 41.9 41.9 ...
    ##  $ end_lng           : num  -87.7 -87.7 -87.7 -87.7 -87.7 ...
    ##  $ member_casual     : chr  "member" "member" "member" "member" ...

``` r
str(m02_2021)
```

    ## 'data.frame':    49622 obs. of  13 variables:
    ##  $ ride_id           : chr  "89E7AA6C29227EFF" "0FEFDE2603568365" "E6159D746B2DBB91" "B32D3199F1C2E75B" ...
    ##  $ rideable_type     : chr  "classic_bike" "classic_bike" "electric_bike" "classic_bike" ...
    ##  $ started_at        : chr  "2021-02-12 16:14:56" "2021-02-14 17:52:38" "2021-02-09 19:10:18" "2021-02-02 17:49:41" ...
    ##  $ ended_at          : chr  "2021-02-12 16:21:43" "2021-02-14 18:12:09" "2021-02-09 19:19:10" "2021-02-02 17:54:06" ...
    ##  $ start_station_name: chr  "Glenwood Ave & Touhy Ave" "Glenwood Ave & Touhy Ave" "Clark St & Lake St" "Wood St & Chicago Ave" ...
    ##  $ start_station_id  : chr  "525" "525" "KA1503000012" "637" ...
    ##  $ end_station_name  : chr  "Sheridan Rd & Columbia Ave" "Bosworth Ave & Howard St" "State St & Randolph St" "Honore St & Division St" ...
    ##  $ end_station_id    : chr  "660" "16806" "TA1305000029" "TA1305000034" ...
    ##  $ start_lat         : num  42 42 41.9 41.9 41.8 ...
    ##  $ start_lng         : num  -87.7 -87.7 -87.6 -87.7 -87.6 ...
    ##  $ end_lat           : num  42 42 41.9 41.9 41.8 ...
    ##  $ end_lng           : num  -87.7 -87.7 -87.6 -87.7 -87.6 ...
    ##  $ member_casual     : chr  "member" "casual" "member" "member" ...

``` r
str(m03_2021)
```

    ## 'data.frame':    228496 obs. of  13 variables:
    ##  $ ride_id           : chr  "CFA86D4455AA1030" "30D9DC61227D1AF3" "846D87A15682A284" "994D05AA75A168F2" ...
    ##  $ rideable_type     : chr  "classic_bike" "classic_bike" "classic_bike" "classic_bike" ...
    ##  $ started_at        : chr  "2021-03-16 08:32:30" "2021-03-28 01:26:28" "2021-03-11 21:17:29" "2021-03-11 13:26:42" ...
    ##  $ ended_at          : chr  "2021-03-16 08:36:34" "2021-03-28 01:36:55" "2021-03-11 21:33:53" "2021-03-11 13:55:41" ...
    ##  $ start_station_name: chr  "Humboldt Blvd & Armitage Ave" "Humboldt Blvd & Armitage Ave" "Shields Ave & 28th Pl" "Winthrop Ave & Lawrence Ave" ...
    ##  $ start_station_id  : chr  "15651" "15651" "15443" "TA1308000021" ...
    ##  $ end_station_name  : chr  "Stave St & Armitage Ave" "Central Park Ave & Bloomingdale Ave" "Halsted St & 35th St" "Broadway & Sheridan Rd" ...
    ##  $ end_station_id    : chr  "13266" "18017" "TA1308000043" "13323" ...
    ##  $ start_lat         : num  41.9 41.9 41.8 42 42 ...
    ##  $ start_lng         : num  -87.7 -87.7 -87.6 -87.7 -87.7 ...
    ##  $ end_lat           : num  41.9 41.9 41.8 42 42.1 ...
    ##  $ end_lng           : num  -87.7 -87.7 -87.6 -87.6 -87.7 ...
    ##  $ member_casual     : chr  "casual" "casual" "casual" "casual" ...

``` r
str(m04_2021)
```

    ## 'data.frame':    337230 obs. of  13 variables:
    ##  $ ride_id           : chr  "6C992BD37A98A63F" "1E0145613A209000" "E498E15508A80BAD" "1887262AD101C604" ...
    ##  $ rideable_type     : chr  "classic_bike" "docked_bike" "docked_bike" "classic_bike" ...
    ##  $ started_at        : chr  "2021-04-12 18:25:36" "2021-04-27 17:27:11" "2021-04-03 12:42:45" "2021-04-17 09:17:42" ...
    ##  $ ended_at          : chr  "2021-04-12 18:56:55" "2021-04-27 18:31:29" "2021-04-07 11:40:24" "2021-04-17 09:42:48" ...
    ##  $ start_station_name: chr  "State St & Pearson St" "Dorchester Ave & 49th St" "Loomis Blvd & 84th St" "Honore St & Division St" ...
    ##  $ start_station_id  : chr  "TA1307000061" "KA1503000069" "20121" "TA1305000034" ...
    ##  $ end_station_name  : chr  "Southport Ave & Waveland Ave" "Dorchester Ave & 49th St" "Loomis Blvd & 84th St" "Southport Ave & Waveland Ave" ...
    ##  $ end_station_id    : chr  "13235" "KA1503000069" "20121" "13235" ...
    ##  $ start_lat         : num  41.9 41.8 41.7 41.9 41.7 ...
    ##  $ start_lng         : num  -87.6 -87.6 -87.7 -87.7 -87.7 ...
    ##  $ end_lat           : num  41.9 41.8 41.7 41.9 41.7 ...
    ##  $ end_lng           : num  -87.7 -87.6 -87.7 -87.7 -87.7 ...
    ##  $ member_casual     : chr  "member" "casual" "casual" "member" ...

``` r
str(m05_2021)
```

    ## 'data.frame':    531633 obs. of  13 variables:
    ##  $ ride_id           : chr  "C809ED75D6160B2A" "DD59FDCE0ACACAF3" "0AB83CB88C43EFC2" "7881AC6D39110C60" ...
    ##  $ rideable_type     : chr  "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : chr  "2021-05-30 11:58:15" "2021-05-30 11:29:14" "2021-05-30 14:24:01" "2021-05-30 14:25:51" ...
    ##  $ ended_at          : chr  "2021-05-30 12:10:39" "2021-05-30 12:14:09" "2021-05-30 14:25:13" "2021-05-30 14:41:04" ...
    ##  $ start_station_name: chr  "" "" "" "" ...
    ##  $ start_station_id  : chr  "" "" "" "" ...
    ##  $ end_station_name  : chr  "" "" "" "" ...
    ##  $ end_station_id    : chr  "" "" "" "" ...
    ##  $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...
    ##  $ start_lng         : num  -87.6 -87.6 -87.7 -87.7 -87.7 ...
    ##  $ end_lat           : num  41.9 41.8 41.9 41.9 41.9 ...
    ##  $ end_lng           : num  -87.6 -87.6 -87.7 -87.7 -87.7 ...
    ##  $ member_casual     : chr  "casual" "casual" "casual" "casual" ...

``` r
str(m06_2021)
```

    ## 'data.frame':    729595 obs. of  13 variables:
    ##  $ ride_id           : chr  "99FEC93BA843FB20" "06048DCFC8520CAF" "9598066F68045DF2" "B03C0FE48C412214" ...
    ##  $ rideable_type     : chr  "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : chr  "2021-06-13 14:31:28" "2021-06-04 11:18:02" "2021-06-04 09:49:35" "2021-06-03 19:56:05" ...
    ##  $ ended_at          : chr  "2021-06-13 14:34:11" "2021-06-04 11:24:19" "2021-06-04 09:55:34" "2021-06-03 20:21:55" ...
    ##  $ start_station_name: chr  "" "" "" "" ...
    ##  $ start_station_id  : chr  "" "" "" "" ...
    ##  $ end_station_name  : chr  "" "" "" "" ...
    ##  $ end_station_id    : chr  "" "" "" "" ...
    ##  $ start_lat         : num  41.8 41.8 41.8 41.8 41.8 ...
    ##  $ start_lng         : num  -87.6 -87.6 -87.6 -87.6 -87.6 ...
    ##  $ end_lat           : num  41.8 41.8 41.8 41.8 41.8 ...
    ##  $ end_lng           : num  -87.6 -87.6 -87.6 -87.6 -87.6 ...
    ##  $ member_casual     : chr  "member" "member" "member" "member" ...

``` r
str(m07_2021)
```

    ## 'data.frame':    822410 obs. of  13 variables:
    ##  $ ride_id           : chr  "0A1B623926EF4E16" "B2D5583A5A5E76EE" "6F264597DDBF427A" "379B58EAB20E8AA5" ...
    ##  $ rideable_type     : chr  "docked_bike" "classic_bike" "classic_bike" "classic_bike" ...
    ##  $ started_at        : chr  "2021-07-02 14:44:36" "2021-07-07 16:57:42" "2021-07-25 11:30:55" "2021-07-08 22:08:30" ...
    ##  $ ended_at          : chr  "2021-07-02 15:19:58" "2021-07-07 17:16:09" "2021-07-25 11:48:45" "2021-07-08 22:23:32" ...
    ##  $ start_station_name: chr  "Michigan Ave & Washington St" "California Ave & Cortez St" "Wabash Ave & 16th St" "California Ave & Cortez St" ...
    ##  $ start_station_id  : chr  "13001" "17660" "SL-012" "17660" ...
    ##  $ end_station_name  : chr  "Halsted St & North Branch St" "Wood St & Hubbard St" "Rush St & Hubbard St" "Carpenter St & Huron St" ...
    ##  $ end_station_id    : chr  "KA1504000117" "13432" "KA1503000044" "13196" ...
    ##  $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...
    ##  $ start_lng         : num  -87.6 -87.7 -87.6 -87.7 -87.7 ...
    ##  $ end_lat           : num  41.9 41.9 41.9 41.9 41.9 ...
    ##  $ end_lng           : num  -87.6 -87.7 -87.6 -87.7 -87.7 ...
    ##  $ member_casual     : chr  "casual" "casual" "member" "member" ...

``` r
str(m08_2021)
```

    ## 'data.frame':    804352 obs. of  13 variables:
    ##  $ ride_id           : chr  "99103BB87CC6C1BB" "EAFCCCFB0A3FC5A1" "9EF4F46C57AD234D" "5834D3208BFAF1DA" ...
    ##  $ rideable_type     : chr  "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : chr  "2021-08-10 17:15:49" "2021-08-10 17:23:14" "2021-08-21 02:34:23" "2021-08-21 06:52:55" ...
    ##  $ ended_at          : chr  "2021-08-10 17:22:44" "2021-08-10 17:39:24" "2021-08-21 02:50:36" "2021-08-21 07:08:13" ...
    ##  $ start_station_name: chr  "" "" "" "" ...
    ##  $ start_station_id  : chr  "" "" "" "" ...
    ##  $ end_station_name  : chr  "" "" "" "" ...
    ##  $ end_station_id    : chr  "" "" "" "" ...
    ##  $ start_lat         : num  41.8 41.8 42 42 41.8 ...
    ##  $ start_lng         : num  -87.7 -87.7 -87.7 -87.7 -87.6 ...
    ##  $ end_lat           : num  41.8 41.8 42 42 41.8 ...
    ##  $ end_lng           : num  -87.7 -87.6 -87.7 -87.7 -87.6 ...
    ##  $ member_casual     : chr  "member" "member" "member" "member" ...

``` r
str(m09_2021)
```

    ## 'data.frame':    756147 obs. of  13 variables:
    ##  $ ride_id           : chr  "9DC7B962304CBFD8" "F930E2C6872D6B32" "6EF72137900BB910" "78D1DE133B3DBF55" ...
    ##  $ rideable_type     : chr  "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : chr  "2021-09-28 16:07:10" "2021-09-28 14:24:51" "2021-09-28 00:20:16" "2021-09-28 14:51:17" ...
    ##  $ ended_at          : chr  "2021-09-28 16:09:54" "2021-09-28 14:40:05" "2021-09-28 00:23:57" "2021-09-28 15:00:06" ...
    ##  $ start_station_name: chr  "" "" "" "" ...
    ##  $ start_station_id  : chr  "" "" "" "" ...
    ##  $ end_station_name  : chr  "" "" "" "" ...
    ##  $ end_station_id    : chr  "" "" "" "" ...
    ##  $ start_lat         : num  41.9 41.9 41.8 41.8 41.9 ...
    ##  $ start_lng         : num  -87.7 -87.6 -87.7 -87.7 -87.7 ...
    ##  $ end_lat           : num  41.9 42 41.8 41.8 41.9 ...
    ##  $ end_lng           : num  -87.7 -87.7 -87.7 -87.7 -87.7 ...
    ##  $ member_casual     : chr  "casual" "casual" "casual" "casual" ...

``` r
str(m10_2021)
```

    ## 'data.frame':    631226 obs. of  13 variables:
    ##  $ ride_id           : chr  "620BC6107255BF4C" "4471C70731AB2E45" "26CA69D43D15EE14" "362947F0437E1514" ...
    ##  $ rideable_type     : chr  "electric_bike" "electric_bike" "electric_bike" "electric_bike" ...
    ##  $ started_at        : chr  "2021-10-22 12:46:42" "2021-10-21 09:12:37" "2021-10-16 16:28:39" "2021-10-16 16:17:48" ...
    ##  $ ended_at          : chr  "2021-10-22 12:49:50" "2021-10-21 09:14:14" "2021-10-16 16:36:26" "2021-10-16 16:19:03" ...
    ##  $ start_station_name: chr  "Kingsbury St & Kinzie St" "" "" "" ...
    ##  $ start_station_id  : chr  "KA1503000043" "" "" "" ...
    ##  $ end_station_name  : chr  "" "" "" "" ...
    ##  $ end_station_id    : chr  "" "" "" "" ...
    ##  $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...
    ##  $ start_lng         : num  -87.6 -87.7 -87.7 -87.7 -87.7 ...
    ##  $ end_lat           : num  41.9 41.9 41.9 41.9 41.9 ...
    ##  $ end_lng           : num  -87.6 -87.7 -87.7 -87.7 -87.7 ...
    ##  $ member_casual     : chr  "member" "member" "member" "member" ...

Every column name is consistent with each other. However, there are some
other inconsistencies.

in 2020 November, as m11_2020, the format of “started_at” and “ended_at”
are different from the rest of data. So this code changed it:

``` r
m11_2020$started_at <- strptime(m11_2020$started_at, format = "%d/%m/%Y %H:%M")
m11_2020$started_at <- format(m11_2020$started_at, "%Y-%m-%d %H:%M:%S")

m11_2020$ended_at <- strptime(m11_2020$ended_at, format = "%d/%m/%Y %H:%M")
m11_2020$ended_at <- format(m11_2020$ended_at, "%Y-%m-%d %H:%M:%S")
```

Warning: m11_2020 does not include the seconds in datetime, so we
assumed that as HH:MM:00. You can see the ride length of m11_2020 as
seconds of a full minutes, such as 60, 120, 720 seconds, etc.

The other inconsistency was about data type. In m11_2020
“start_station_id” and “end_station_id” are classified as integers, so
they are classified as character to make all of 12 months’ data
consistent with each other.

``` r
m11_2020 <- mutate(m11_2020, start_station_id = as.character(start_station_id),
                   end_station_id = as.character(end_station_id))
```

Now, we can finally combine all 12 data into a single big data frame
called “all_trips”.

``` r
all_trips <- bind_rows(m11_2020, m12_2020, m01_2021, m02_2021, m03_2021, m04_2021,
                       m05_2021, m06_2021, m07_2021, m08_2021, m09_2021, m10_2021)
```

### Clean up and Add Data to Prepare Analysis

To analyze the whole data, looking at the all_trips to check whether
there is a problem or not.

``` r
colnames(all_trips)
nrow(all_trips)
dim(all_trips)
str(all_trips)
head(all_trips)
```

You can see it here as summarized:

``` r
summary(all_trips)
```

    ##    ride_id          rideable_type       started_at          ended_at        
    ##  Length:5378834     Length:5378834     Length:5378834     Length:5378834    
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##  start_station_name start_station_id   end_station_name   end_station_id    
    ##  Length:5378834     Length:5378834     Length:5378834     Length:5378834    
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##    start_lat       start_lng         end_lat         end_lng      
    ##  Min.   :41.64   Min.   :-87.84   Min.   :41.51   Min.   :-88.07  
    ##  1st Qu.:41.88   1st Qu.:-87.66   1st Qu.:41.88   1st Qu.:-87.66  
    ##  Median :41.90   Median :-87.64   Median :41.90   Median :-87.64  
    ##  Mean   :41.90   Mean   :-87.65   Mean   :41.90   Mean   :-87.65  
    ##  3rd Qu.:41.93   3rd Qu.:-87.63   3rd Qu.:41.93   3rd Qu.:-87.63  
    ##  Max.   :42.08   Max.   :-87.52   Max.   :42.17   Max.   :-87.44  
    ##                                   NA's   :4831    NA's   :4831    
    ##  member_casual     
    ##  Length:5378834    
    ##  Class :character  
    ##  Mode  :character  
    ##                    
    ##                    
    ##                    
    ## 

Finding the average duration that the riders are using the bicycle. To
begin with, we needed to calculate ride length of every consumption.

To find the ride length, the lubridate package is used to get the large
POSIXct data of “started_at” and “ended_at”. Then, difftime function is
used to find the ride length and assign it as a new column of our
all_trips data. (The units of ride_length are by seconds.)

``` r
starttime <- ymd_hms(all_trips$started_at)
endtime <- ymd_hms(all_trips$ended_at)

all_trips$ride_length <- difftime(endtime, starttime, units = "secs")
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
```

Also, we wanted to analyse the trend by looking at the day of week the
riders used the bicycle.

Therefore, a new column named “day_of_week” is created so that we can
have much more detailed graph and maybe we can find a relation in there.

``` r
all_trips$day_of_week <- format(as.Date(as.Date(all_trips$started_at)), "%A")
```

There are some negative values of ride_length in the data, about 829
rows. Since it is impossible, they are deleted from our data set through
creating a new version of our dataframe (v2).

``` r
negative_ride_length <- filter(all_trips, ride_length < 0)

all_trips_v2 <- filter(all_trips, ride_length >= 0)

summary(all_trips_v2$ride_length)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##       0     420     743    1350    1346 3356649

### Descriptive Analysis

The analysis is based on “ride_length”, “day_of_week”, and
“member_casual”.

Gathering these columns into a table, but first we need to compare
members and casual users by ride_length.

``` r
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
```

    ##   all_trips_v2$member_casual all_trips_v2$ride_length
    ## 1                     casual                1953.3328
    ## 2                     member                 837.6682

``` r
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
```

    ##   all_trips_v2$member_casual all_trips_v2$ride_length
    ## 1                     casual                      982
    ## 2                     member                      596

``` r
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
```

    ##   all_trips_v2$member_casual all_trips_v2$ride_length
    ## 1                     casual                  3356649
    ## 2                     member                    93596

``` r
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)
```

    ##   all_trips_v2$member_casual all_trips_v2$ride_length
    ## 1                     casual                        0
    ## 2                     member                        0

After that, “day_of_week” column is included as well. To look at the
average duration by rider type(member and casual users) of each day, run
this code:

``` r
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + 
            all_trips_v2$day_of_week, FUN = mean)
```

    ##    all_trips_v2$member_casual all_trips_v2$day_of_week all_trips_v2$ride_length
    ## 1                      casual                   Friday                1854.4718
    ## 2                      member                   Friday                 819.6202
    ## 3                      casual                   Monday                1939.0839
    ## 4                      member                   Monday                 811.0328
    ## 5                      casual                 Saturday                2109.3361
    ## 6                      member                 Saturday                 933.2844
    ## 7                      casual                   Sunday                2286.2664
    ## 8                      member                   Sunday                 955.0169
    ## 9                      casual                 Thursday                1692.2855
    ## 10                     member                 Thursday                 786.0459
    ## 11                     casual                  Tuesday                1717.1213
    ## 12                     member                  Tuesday                 786.2102
    ## 13                     casual                Wednesday                1688.8442
    ## 14                     member                Wednesday                 789.8635

We can see that data is not ordered by “day_of_week”, so the whole data
is ordered and run the aforementioned aggregate function again.

``` r
all_trips_v2$day_of_week <- factor(all_trips_v2$day_of_week,
                                   levels = c("Sunday", "Monday", "Tuesday", "Wednesday",
                                              "Thursday", "Friday", "Saturday"), ordered = TRUE)

aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + 
            all_trips_v2$day_of_week, FUN = mean)
```

    ##    all_trips_v2$member_casual all_trips_v2$day_of_week all_trips_v2$ride_length
    ## 1                      casual                   Sunday                2286.2664
    ## 2                      member                   Sunday                 955.0169
    ## 3                      casual                   Monday                1939.0839
    ## 4                      member                   Monday                 811.0328
    ## 5                      casual                  Tuesday                1717.1213
    ## 6                      member                  Tuesday                 786.2102
    ## 7                      casual                Wednesday                1688.8442
    ## 8                      member                Wednesday                 789.8635
    ## 9                      casual                 Thursday                1692.2855
    ## 10                     member                 Thursday                 786.0459
    ## 11                     casual                   Friday                1854.4718
    ## 12                     member                   Friday                 819.6202
    ## 13                     casual                 Saturday                2109.3361
    ## 14                     member                 Saturday                 933.2844

Before visualizing the data, we analyse the number of rides and average
duration of these rides by rider type and day of week, then we summarise
and arrange it through this code:

``` r
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(),
            average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday)
```

    ## `summarise()` has grouped output by 'member_casual'. You can override using the `.groups` argument.

    ## # A tibble: 14 x 4
    ## # Groups:   member_casual [2]
    ##    member_casual weekday number_of_rides average_duration
    ##    <chr>         <ord>             <int>            <dbl>
    ##  1 casual        Sun              476160            2286.
    ##  2 casual        Mon              278264            1939.
    ##  3 casual        Tue              264264            1717.
    ##  4 casual        Wed              267479            1689.
    ##  5 casual        Thu              277327            1692.
    ##  6 casual        Fri              354986            1854.
    ##  7 casual        Sat              551862            2109.
    ##  8 member        Sun              368439             955.
    ##  9 member        Mon              391346             811.
    ## 10 member        Tue              431501             786.
    ## 11 member        Wed              444315             790.
    ## 12 member        Thu              425616             786.
    ## 13 member        Fri              425203             820.
    ## 14 member        Sat              421243             933.

### Plots

Now we can visualize this analysis. Let’s visualize the number of rides
by rider type.

``` r
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
```

    ## `summarise()` has grouped output by 'member_casual'. You can override using the `.groups` argument.

![](Cyclistic_Project_Github_files/figure-gfm/unnamed-chunk-18-1.png?raw=true)<!-- -->

We can clearly see that on weekends, casual riders are using the service
much more than annual members. On weekdays, annual members using
bicycles much more than casual riders.

Let’s create another visualization:The average duration by rider type.

``` r
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
```

    ## `summarise()` has grouped output by 'member_casual'. You can override using the `.groups` argument.

![](Cyclistic_Project_Github_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

In this graph, we can see that casual riders always spent much more time
than annual members. From this graph, we may claim that annual members
are more likely to use the bicycles for commuting work each day rather
than riding for leisure.

Last but not least, we create an csv file of summary file that we may
use for further analysis. We can visualize it in Excel, Tableau, or any
presentation software.

``` r
aggregate_data <- aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual +
                      all_trips_v2$day_of_week, FUN = mean)

write.csv(aggregate_data, file = "C:/Users/lenovo/Desktop/Google Data Analytics Certificate/My Capstone Project/avg_ride_length.csv")
```

### Conclusion

This report is about analysing the fictional company’s bike trip data.
With the findings of the analysis, this report has recommendations to
attract casual riders and convert them annual members.

-   Creating another type of memberships, such as monthly, 3 months, or
    6 months membership. Users may be reluctant to have annual
    membership, so they choose to get single-ride or full-day passes.

-   Changing the settings of the pricing plan to show the users that
    memberships would be much cheaper than buying passes. Maybe making
    the memberships cheaper or price of single-ride or full-day passes
    may differ according to the duration of the rides.

-   Facilitating another services for members only. The company provide
    discount coupons, 7/24 digital assistance, or custom-made bicycles
    only to the members.

Even though this is a fictional case study, it may inspire us to solve
real-life problems. Thank you for reading!
