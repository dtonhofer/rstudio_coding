# Plot a Normal Distribution

Make sure you have loaded the tidyverse libraries.

````
library(tidyverse)
````

Define the function to plot a Normal.

Just dump this code into the RStudio console, or better write it to a file
called for example `plot_normal.r` and load it into RStudio by issuing the command
`source("plot_normal.r")`.

````
plot_normal <- function(the_min, the_max, the_mean, the_stddev) {

   num_points <- 200
   x <- seq(the_min, the_max, (the_max-the_min)/(num_points-1))
   y <- dnorm(x, mean=the_mean, sd=the_stddev)
   normal = tibble(x,y)
   
   titlestr <- "A normal distribution"

   subtitlestr <-
      paste0("min = "      , round_it(the_min),
             ", max = "      , round_it(the_max),
             ", mean = "     , round_it(the_mean),
             ", stddev = "   , round_it(the_stddev))

   plot <- ggplot() +
       geom_line(data = normal, aes(x=x,y=y)) +
       coord_cartesian(xlim=c(the_min,the_max)) +   
       labs(x="x", y="dp", title=titlestr, subtitle=subtitlestr)

   color_mean    <- "navy"
   color_stddev  <- "blue"   
   
   # add a vertical line for "mean"
   
   x_where <- the_mean
   plot <- plot + geom_vline(xintercept=x_where, color=color_mean)

   # add a dashed vertical line for "1-stddev range, low value"

   x_where <- the_mean + the_stddev
   plot <- plot + geom_vline(xintercept=x_where, color=color_stddev, linetype="dotdash")

   # add a dashed vertical line for "1-stddev range, high value" 
          
   x_where <- the_mean - the_stddev
   plot <- plot + geom_vline(xintercept=x_where, color=color_stddev, linetype="dotdash")
           
   return(plot)
}

round_it <- function(value) {
   rr = 0 # round to integer with 0   
   rounded_value <- round(value,rr)
   error = abs(value * 0.0001) # set as needed
   diff = abs(value - rounded_value)
   while (diff > error) {
      rr <- rr+1
      rounded_value <- round(value,rr)   
      diff = abs(value - rounded_value)
   }
   return (rounded_value)
}
````

Plot in RStudio using:

````
> plot_normal(-10,10.0,3)
````

![Normal plot](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/course_1/plot_normal/Rplot.png)







