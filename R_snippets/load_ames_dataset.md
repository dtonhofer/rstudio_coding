# "Statistics with R" C2W1: Load the "ames" dataset

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

On a Unix machine:

Copy the above code into a file `~/scripts/loadamesarea.r` for example (i.e. the file `loadamesarea.r` in directory `scripts` in your home directory)

Then the `ames_area` tibble can be set or reset by executing this in the RStudio console:

````
source("~/scripts/loadamesarea.r")
````
