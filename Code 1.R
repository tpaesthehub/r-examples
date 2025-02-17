# Credit: Based on course by Julie Lowndes & Allison Horst (2020):
# https://rstudio-conf-2020.github.io/r-for-excel/index.html

################################################
### Code 1: Read in data
################################################

################################################
### The code in this file covers the following:
################################################

  # Read in external data (Excel files, CSVs) with readr and readxl
  # Initial data exploration
  # Set up GitHub
  
# Libraries needed

library(here) # easier file referencing 
library(tidyverse) # reading in CSV files and more
library(readxl) # reading in Excel files


## Read in external data (Excel files, CSVs) with readr and readxl

# Our first data set is a comma-separated-value (CSV) file containing visitation 
# data for all National Parks in California (ca_np.csv)

ca_np <- read_csv(here("data", "ca_np.csv"))

# Our second data set is a single Excel worksheet containing only visitation for 
# Channel Islands National Park (ci_np.xlsx)

ci_np <- read_excel(here("data", "ci_np.xlsx"))

## Initial data exploration

# Can look at the data in the environment tab, 
# or with functions such as follows:

names(ca_np) # check what all the variable names are
head(ca_np) # first 6 rows of the data
summary(ca_np) # quick summary of each variable

View(ci_np) # opens data in extra tab, can also get this by double-clicking on
            # data set name in Environment tab
summary(ci_np)

## Set up GitHub (one off!)

library(usethis)

## use_git_config function with your username and email as arguments
use_git_config(user.name = "your_username", 
               user.email = "example@gmail.com")


