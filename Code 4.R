################################################
### Code 4: Tidying and wrangling data
################################################

################################################
### The code in this file covers the following:
################################################

# Learn clean_names() from janitor
# Learn mutate() and select() to work column-wise
# Reshaping data


# Libraries needed

library(here) # easier file referencing 
library(tidyverse) # reading in CSV files and more
library(readxl) # reading in Excel files
library(janitor) # easier data tidying (NEW!)

## Learn clean_names from janitor

# The data we will be working with is the number of invertebrates recorded at 
# various sites in July over the three years 2016-2018:

invertebrates <- read_excel(here("data", "inverts.xlsx"))

# The names of three of the columns are essentially numbers, this is something R
# tends to really not like, this and other better ways of naming columns can
# be fixed by applying the clean_names() function from the janitor package:

inverts = invertebrates %>% 
  clean_names()

## Learn mutate() and select() to work column-wise

# mutate()

# We can use this function for two purposes, the first is to change the 
# data type. For example, R tends to treat any variable that is not clearly 
# numerical as a character variable, even if the data is actually numerical 
# (there are missing values) or a factor. 
# We have two out of seven of the variables that are clearly a factor and this 
# can be fixed with mutate():

inverts = inverts %>% 
  mutate(across(c(site, common_name), factor)) 

# Question: What do you think about month? Should we also treat it as a factor?

# Another application is to create a new variable in the data. For example,
# combining already existing variables can give you proportion found by year:

inverts = inverts %>% 
  mutate(prop2016 = x2016/(x2016 + x2017 + x2018))


# select()

# If you look at the data you will see that "month" is not adding any value 
# here, so you might as well remove it. 

# The function select() allows you to select which variables to keep:

inverts2 = inverts %>% 
  select(site, common_name, x2016, x2017, x2018)

# Or, it is sometimes easier to remove variables instead:

inverta = inverts %>% 
  select(-month) 

## Reshaping data

# Having the year variable split over three columns is what we would refer to
# as the data currently being in a wide format.

# Sometimes you might want to convert data in wide format to long format by 
# gathering together observations for a variable that is currently split into 
# multiple columns.

# We will use pivot_longer() to gather data from all years (in columns x2016, x2017, 
# and x2018) into two columns: one called "year", which contains the year and
# one called "sp_count" containing the number of each species observed.

inverts_long <- pivot_longer(data = inverts, 
                             cols = x2016:x2018,
                             names_to = "year",
                             values_to = "sp_count")


# Sometimes, we’ll have data that we want to spread over multiple columns.
# For example, imagine that, starting from inverts_long, we want each species 
# in the common_name column to exist as its own column:

inverts_wide <- inverts_long %>% 
  pivot_wider(names_from = common_name, 
              values_from = sp_count)

# We can see that now each species has its own column (wider format). However,
# once again the column names are not very coder-friendly, so let us clean them:

inverts_wide <- inverts_wide %>% 
  clean_names()

# Combine information in column(s)

# We can make a single column that has the combined information from site 
# abbreviation and year in inverts_long:

inverts_unite <- inverts_long %>% 
  unite(col = "site_year", # What to name the new united column
        c(site, year), # The columns we'll unite (site, year)
        sep = "_") # How to separate the things we're uniting

# Separate information into multiple columns

# It’s actually more likely that you’ll start with a single column that you 
# want to split up into pieces. For example, you might want to split up a 
# column containing the genus and species (Scorpaena guttata) into two 
# separate columns (Scorpaena | guttata), so that you can count how many 
# Scorpaena organisms exist in the data at the genus level.

# To see how the separate() function works, let's separate the two columns
# again we created in "inverts_unite":

inverts_sep <- inverts_unite %>% 
  separate(site_year, into = c("my_site", "my_year"))

# Final comment: You might need to be specific about WHICH separate or select
# function you mean: dplyr::select, tidyr::separate

# Sync project with GitHub repo
# Stage > Commit > Pull (to check for remote changes) > Push!
