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


