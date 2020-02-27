# Coursera "Statistics with R" C2W1: Load the "ames" dataset

The dataset used for Course 2, Week 1:

> We consider real estate data from the city of Ames, Iowa. The details of every real estate transaction in Ames
> is recorded by the City Assessor’s office. Our particular focus for this lab will be all residential home sales
> in Ames between 2006 and 2010. This collection represents our population of interest. In this lab we would 
> like to learn about these home sales by taking smaller samples from the full population. 

It can be found [here](https://github.com/StatsWithR/statsr/tree/master/data)

Let’s load the data. We are only interested in the "area" variable.

````
load_ames_area <- function() {
   # load 'ames' into the global environment
   data(ames) 
   # We are interested in the area of transacted property, in feet² 
   ames_area <- select(ames,area)
   # `ames_area` is a tibble with a single variable
   # to rename column "area" to just "x" (one could also use dplyr's rename function)
   # names(ames_area)[names(ames_area) == "area"] <- "x"
   return (ames_area)
}

ames_area <- load_ames_area()
str(ames_area)
````

## For the future

Write the above code into file `loadamesarea.r` in directory `scripts` so that the `ames_area` tibble
can be set or reset by executing

````
source("~/scripts/loadamesarea.r")
````

## P.S.

I still haven't understood R's structure unpacking...

````
v0 <- ames_area[0]    # just a value .. 2930 obs. of 0 variables (i.e. there is nothing)
v1 <- ames_area[1]    # a tibble (S3 class), 2930 obs. of 1 variable (of mode int)
v2 <- ames_area[[1]]  # the content of v1. This is just a value, an array of int [1:2930]