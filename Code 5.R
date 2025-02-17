################################################
### Code 5: More tidying and wrangling data
################################################

################################################
### The code in this file covers the following:
################################################

# Conditionally subset by rows
# Merge data frames


# Libraries needed

library(here) # easier file referencing 
library(tidyverse) # reading in CSV files and more
library(readxl) # reading in Excel files


# First, we read in two data sets we will be working with in this session:

fish <- read_csv(here("data", "fish.csv"))
kelp_abur <- read_excel(here("data", "kelp.xlsx"), sheet = "abur")

# Remember to take a moment to get a sense of the data before analysing it,
# using functions such as summary() or even some simple plots.


## Conditionally subset by rows

# We do this in R by using the filter() function. This function works by taking 
# a data frame and using conditional statements to let R know which rows you 
# want to keep or exclude, based whether or not their contents match conditions 
# that you set for one or more variables. Here we will look at various ways in
# which we can apply filter().

# Filter rows by matching a single character string

# To keep all observations from the fish data set where the common name is 
# “garibaldi” we use the following code:

fish_garibaldi <- fish %>% 
  filter(common_name == "garibaldi")

# Filter rows based on numeric conditions

# If the variable we are filtering by is numerical, we can use more operators
# when filtering. This is how we keep observations in the fish data where the 
# "total_count" is greater than 50:

fish_over50 <- fish %>% 
  filter(total_count > 50)


# Filter to return rows that match this OR that OR that

# What if we want to return a subset of the fish df that contains garibaldi, 
# blacksmith OR black surfperch? 

fish_3sp <- fish %>% 
  filter(common_name == "garibaldi" | 
           common_name == "blacksmith" | 
           common_name == "black surfperch")

# Note, the vertical "|" is the symbol for the OR operator.

# Filter to return observations that match this AND that

# You can create a subset that only returns rows from fish where the year is 2018 
# AND the site is Arroyo Quemado (“aque”) as follows:

aque_2018 <- fish %>% 
  filter(year == 2018 & site == "aque")

# Filter by a partial pattern

# There might be situations where you want to work with observations based on
# a variable containing a certain string pattern. The str_detect() function from
# the stringr package will help here. For example,  we can keep 
# observations from the fish data set where "common_name" contains the string 
# pattern “black” as follows: 

fish_bl <- fish %>% 
  filter(str_detect(common_name, pattern = "black"))

# Looking at the result subset, we notice that there are two fish, blacksmith 
# and black surfperch, that satisfy this condition.

## Merge data frames

# When merging, we need to tell R which data frames we want to merge and which
# variables to merge by.

# full_join()

# This is the best option if you’re unclear about how to merge the data frames,
# as it keeps everything. For example, we can merge the fish abundance data with 
# the kelp abundance data where there were measurements taken at the same sites 
# in the same year:

abur_kelp_fish <- kelp_abur %>% 
  full_join(fish, by = c("year", "site")) 

# Looking at the data we see that:
# 1. All columns that existed in both data frames still exist.
# 2. All observations are retained, even if they don’t have a match. 
# In this case, notice that for other sites (not ‘abur’) the observation for 
# fish still exists, even though there was no corresponding kelp data to 
# merge with it.
# 3. The kelp data is joined to all observations where the joining variables 
# (year, site) are a match, which is why it is repeated 5 times for each year 
# (once for each fish species).

# left_join(x,y)

# This function merges two data frames while keeping everything in the first 
# data frame (x) and only matches from the second data frame (y). In the case
# of the two data sets above, when we use left_join(), any information from fish 
# that don’t have a match (by year and site) in kelp_abur won’t be retained, 
# because those wouldn’t have a match in the left data frame:

kelp_fish_left <- kelp_abur %>% 
  left_join(fish, by = c("year","site"))

# inner_join()

# Use this function if when merging the data frames, you only want to keep 
# observations with a match in both. 

kelp_fish_injoin <- kelp_abur %>% 
  inner_join(fish, by = c("year", "site"))

# This is the smallest merged data set as only observations (rows) where there 
# is a match for year and site in both data frames are returned.


# Sync project with GitHub repo
# Stage > Commit > Pull (to check for remote changes) > Push!

#################
### THE END #####
#################



