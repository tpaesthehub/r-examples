################################################
### Code 2: Plotting
################################################

################################################
### The code in this file covers the following:
################################################

# Build several types of graphs in ggplot2
# Customise graph aesthetics 
# Update axis labels and titles
# Combine compatible graph types (geoms)
# Build multiseries graphs
# Split up data into faceted graphs
# Export figures with ggsave()


# Libraries needed

library(here) # easier file referencing 
library(tidyverse) # reading in CSV files and more
library(readxl) # reading in Excel files


## Build several types of graphs in ggplot2

# First plot will be a simple line plot:
ggplot(data = ci_np, aes(x = year, y = visitors)) +
  geom_line()

# We are going to be working through quite a few variations, so store the
# first line as object "gg_base" so that we don’t need to retype it each time:

gg_base <- ggplot(data = ci_np, aes(x = year, y = visitors))

# Now can plot as scatterplot instead:

gg_base +
  geom_point()

# Or as a column graph:

gg_base +
  geom_col()

# Or as a area plot:

gg_base +  
  geom_area()

## Customise graph aesthetics 

# We return to the line plot:

gg_base +
  geom_line(col = "purple", linetype = "dashed")

# We return to the scatterplot:

gg_base + 
  geom_point(col = "purple", pch = 17, size = 4, alpha = 0.5)

gg_base + 
  geom_point(aes(size = visitors, col = visitors), alpha = 0.5)  

# We return to the column plot:

gg_base + 
  geom_col(aes(fill = visitors))  

# Can also change the theme:

gg_base + 
  geom_point(aes(size = visitors, col = visitors), alpha = 0.5) +
  theme_minimal()

## Update axis labels and titles

# Return to line chart and add context:

gg_base +
  geom_line(linetype = "dotted") +
  theme_bw() +
  labs(x = "Year", y = "Annual park visitors",
       title = "Channel Islands NP Visitation",
       subtitle = "(1963 - 2016)")

## Combine compatible graph types (geoms)

# Can layer graph types in a single plot:

gg_base +
  geom_line(col = "purple") +
  geom_point(col = "orange", aes(size = year), alpha = 0.5)

gg_base +
  geom_col(fill = "orange", col = "purple") +
  geom_line(col = "green")

## Build multiseries graphs

# Demo of what happens if you do not provide enough details:

ggplot(data = ca_np, aes(x = year, y = visitors)) +
  geom_line()

# Plot is messy because R doesn't know that these 
# should be different series based on the different parks 

ggplot(data = ca_np, aes(x = year, y = visitors, group = park_name)) +
  geom_line()

# Another option:

ggplot(data = ca_np, aes(x = year, y = visitors, col = park_name)) +
  geom_line()

# Store first line for later use:

gg_np <- ggplot(data = ca_np, aes(x = year, y = visitors, group = park_name))

## Split up data into faceted graphs

gg_np +
  geom_line(show.legend = F) +
  theme_light() + 
  labs(x = "Year", y = "Annual visitors") +
  facet_wrap(~ park_name)

## Export figures with ggsave()

ggsave(here("figures", "np_graph.jpg"), dpi = 180, width = 8, height = 7)

# Sync project with GitHub repo
# Stage > Commit > Pull (to check for remote changes) > Push!

