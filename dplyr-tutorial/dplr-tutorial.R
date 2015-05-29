# My practise of dplyr based on https://rpubs.com/justmarkham/dplyr-tutorial

library(dplyr)
library(hflights)

# check available datasets
data()

# load dataset
data(hflights)

head(hflights)

class(hflights) # check class of hflights

# convert to local data frame
flights <- tbl_df(hflights)
class(flights) # check class of flights

# prints only 10 rows of local data frame
flights

print(flights, n = 20)

# convert to normal data frame
data.frame(head(flights))

######################################################################
# select all flights in January
flights[flights$Month == 1, ]

# select all flights on 1st January
flights[flights$Month == 1 & flights$DayofMonth == 1, ]

# the same like above but in dplyr style
filter(flights, Month == 1, DayofMonth == 1)

#filter rows only yo 'AA' or 'UA' flights
filter(flights, UniqueCarrier == 'AA' | UniqueCarrier == 'UA')

# the same like above but use %in% operator
filter(flights, UniqueCarrier %in% c('AA', 'UA'))
######################################################################

######################################################################
# base r approche to select only given columns
flights[, c('DepTime', 'ArrTime', 'FlightNum')]

# the same like above but with splyr approche
select(flights, DepTime, ArrTime, FlightNum)

# select columns from Year to DayofMonth and all columns which contain 'Taxi' and 'Delay'
select(flights, Year:DayofMonth, contains('Taxi'), contains('Delay'))

# use starts_with() and ends_with() to select columns
select(flights, starts_with('A'), ends_with('Delay'))
######################################################################

# nested select in filter
filter(select(flights, UniqueCarrier, DepDelay), DepDelay > 30)

# chaining
flights %>% 
    select(UniqueCarrier, DepDelay) %>%
    filter(DepDelay > 30)

# another example of chaining
x1 <- 1:5
x2 <- 2:6

sqrt(sum((x1-x2)^2))

# the same with chaining
(x1 - x2)^2 %>% sum() %>% sqrt()

######################################################################
# select only UniqueCarrier and DepDelay columns and sort by DepDelay in base R
flights[order(flights$DepDelay), c('UniqueCarrier', 'DepDelay')]

# the same using dplyr style
flights %>%
    select(UniqueCarrier, DepDelay) %>%
    arrange(DepDelay)

flights %>%
    select(UniqueCarrier, DepDelay) %>%
    arrange(desc(DepDelay))
######################################################################
# add new variable which is function of existing variables in base R
flights$Speed <- flights$Distance / flights$AirTime*60
flights[, c('Distance', 'AirTime', 'Speed')]

# the same using dplyr style
flights %>%
    select(Distance, AirTime) %>%
    mutate(Speed = Distance / AirTime*60)

# store new variable
flights <- flights %>% mutate(Speed = Distance / AirTime*60)
######################################################################

# calculate the average arrival delay to each destination
with(flights, tapply(ArrDelay, Dest, mean, na.rm = TRUE))
aggregate(ArrDelay ~ Dest, flights, mean)

# the same using dplyr style
flights %>%
    group_by(Dest) %>%
    summarise(avg_delay = mean(ArrDelay, na.rm = TRUE))

# for each carrier, calculate the percentage of flights cancelled or diverted
flights %>%
    group_by(UniqueCarrier) %>%
    summarise_each(funs(mean), Cancelled, Diverted)

# for each carrier, calculate min & max arrival and departures delay
flights %>%
    group_by(UniqueCarrier) %>%
    summarise_each(funs(min(. , na.rm = TRUE), max(. , na.rm = TRUE)), matches('Delay'))

# for each day of the year, count the total number of flights and sort in descending order
# helper function: 
# n() counts the number of rows in a group
# n_distinct(vector) counts the number of unique items in that vector
flights %>%
    group_by(Month, DayofMonth) %>%
    summarise(flight_count = n()) %>%
    arrange(desc(flight_count))

# the same like above but simplified with tally function
flights %>%
    group_by(Month, DayofMonth) %>%
    tally(sort = TRUE)

# for each destination, count the total number of flights and the number of distinct planes that flew there
flights %>%
    group_by(Dest) %>%
    summarise(flight_count = n(), plane_count = n_distinct(TailNum))

# for each destination, show the number of cancelled and not cancelled flights
flights %>%
    group_by(Dest) %>%
    select(Cancelled) %>%
    table() %>%
    head()

# continue with Window Functions
    