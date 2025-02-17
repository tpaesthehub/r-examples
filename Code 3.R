################################################
### Code 3: Creating tables
################################################

################################################
### The code in this file covers the following:
################################################

# Introduce group_by() %>% summarise() 
# They sent the wrong data!


# Libraries needed

library(here) # easier file referencing 
library(tidyverse) # reading in CSV files and more
library(readxl) # reading in Excel files


## Introduce group_by() %>% summarise()  

# First read in some data

# Our third data set is an Excel file containing data on lobsters captured along 
# the Santa Barbara coast from 2012 onwards. You can open it in Excel to see 
# that the data doesn’t start until line 5; there are 4 lines of metadata.

# Note that the metadata is important, so we should not delete it and then 
# proceed with the analyses. However, we also don't want to include this data 
# when reading it in. To remove these lines in R we use an argument called 
# skip that we can set to 4 to skip 4 lines:

lobsters <- read_excel(here("data/lobsters.xlsx"), skip=4)

# Have a first look at the data:

summary(lobsters)

# Now, imagine we want to report about how the average size of lobsters has 
# changed for each site across time.

# The code we use to do this involves using the pipe operator %>%. 
# It allows us to chain together steps of our data wrangling in a way that 
# lets us "read" the history of our changes to the data.

# group_by one variable

# We will first group by year and count how many lobsters were caught in each 
# year. We use the function n() that counts the number of times an observation 
# shows up, and since this is uncounted data, this will count each row:

lobsters %>%
  group_by(year) %>% 
  summarise(count_by_year = n())

# group_by multiple variables:

lobsters %>%
  group_by(site, year) %>%
  summarise(count_by_siteyear =  n())


# summarise multiple variables

lobsters %>%
  group_by(site, year) %>%
  summarise(count_by_siteyear =  n(),
            mean_size_mm = mean(size_mm))

# You may notice that NA turns up for some entries, this is because the mean() 
# function in R returns an NA if any values are missing. The argument na.rm= 
# allows us to tell R to ignore missing values when computing the mean:

lobsters %>%
  group_by(site, year) %>%
  summarise(count_by_siteyear =  n(), 
            mean_size_mm = mean(size_mm, na.rm = T))


# Let's also compute the standard deviation in lobster sizes for each year 
# and save this new table so we can work with it, for example, visualise the 
# changes over time.

siteyear_summary <- lobsters %>%
  group_by(site, year) %>%
  summarise(count_by_siteyear =  n(), 
            mean_size_mm = mean(size_mm, na.rm = T), 
            sd_size_mm = sd(size_mm, na.rm = T))


# They sent the wrong data!

# You might find yourself getting to this point and then being sent an updated 
# version of the data. With Excel we would need to redo all the steps, but with 
# R we can simply update the filename when reading in the data and then rerun 
# the exact same functions:

lobsters <- read_excel(here("data/lobsters2.xlsx"), skip=4)
summary(lobsters)

siteyear_summary <- lobsters %>%
  group_by(site, year) %>%
  summarise(count_by_siteyear =  n(), 
            mean_size_mm = mean(size_mm, na.rm = T), 
            sd_size_mm = sd(size_mm, na.rm = T))

# Takeaway: R’s power is not only in analytical power, 
# but in automation and reproducibility.

# Sync project with GitHub repo
# Stage > Commit > Pull (to check for remote changes) > Push!
