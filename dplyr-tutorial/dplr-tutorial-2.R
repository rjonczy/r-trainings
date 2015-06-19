# My practise of dplyr based on https://github.com/justmarkham/dplyr-tutorial
library(nycflights13)
library(dplyr)



# besides just using select() to pick columns...
flights %>% select(carrier, flight)

# ...you can use the minus sign to hide columns
flights %>% select(-month, -day)


# hide a range of columns
flights %>% select(-(dep_time:arr_delay))

# hide any column with a matching name
flights %>% select(-contains("time"))

# pick columns using a character vector of column names
cols <- c("carrier", "flight", "tailnum")
flights %>% select(one_of(cols))

# select() can be used to rename columns, though all columns not mentioned are dropped
flights %>% select(tail = tailnum)

# rename() does the same thing, except all columns not mentioned are kept
flights %>% rename(tail = tailnum)

# filter() supports the use of multiple conditions
flights %>% filter(dep_time >= 600, dep_time <= 605)


# between() is a concise alternative for determing if numeric values fall in a range
flights %>% filter(between(dep_time, 600, 605))

# side note: is.na() can also be useful when filtering
flights %>% filter(!is.na(dep_time)) %>% head


# slice() filters rows by position
flights %>% slice(1000:1005)

# keep the first three rows within each group
flights %>% group_by(month, day) %>% slice(1:3)

# sample three rows from each group
flights %>% group_by(month, day) %>% sample_n(3)

# keep three rows from each group with the top dep_delay
flights %>% group_by(month, day) %>% top_n(3, dep_delay)

# also sort by dep_delay within each group
flights %>% group_by(month, day) %>% top_n(3, dep_delay) %>% arrange(desc(dep_delay))

# create two simple data frames
(a <- data_frame(color = c("green","yellow","red"), num = 1:3))
(b <- data_frame(color = c("green","yellow","pink"), size = c("S","M","L")))

# only include observations found in both "a" and "b" (automatically joins on variables that appear in both tables)
inner_join(a, b)

# include observations found in either "a" or "b"
full_join(a, b)

# include all observations found in "a"
left_join(a, b)

# include all observations found in "b"
right_join(a, b)

# right_join(a, b) is identical to left_join(b, a) except for column ordering
left_join(b, a)

# filter "a" to only show observations that match "b"
semi_join(a, b)

# filter "a" to only show observations that don't match "b"
anti_join(a, b)

