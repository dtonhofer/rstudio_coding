# ===
# R code used as basis for illustratig the CLT theorem and
# construction of the confidence interval.
# ===

# ---
# Load the libraries that we need. Indicate whether "shiny" is needed (probably not)
# ---

load_libraries <- function(withshiny = FALSE) {
   library(tidyverse)  # Load the whole tidyverse (ggplot2, dplyr, purrr etc..)
   library(statsr)     # Companion package for the Coursera "Statistics with R" specialization 
   library(reshape2)   # Provides "reshape" to "melt" a data frame
   if (withshiny) {
      library(shiny)   # "An R package to build interactive web apps straight from R.", by RStudio. 
   }
   library(testit)     # For "assert": https://www.rdocumentation.org/packages/testit/versions/0.11
                       # install.packages('testit')
}

# ---
# Load the "ames" dataset and return the "area" information
# ---

load_dataset_ames_area <- function() {
   data(ames) 
   # We are interested in the area of transacted property, in feet² 
   ames_area <- select(ames,area)
   # "ames_area" is a tibble of 1 column named "area"
   # to rename column "area" to just "x" (one could also use dplyr's rename function)
   # names(ames_area)[names(ames_area) == "area"] <- "x"
   str(ames_area)
   return (ames_area)
}

# ---
# Given a plot created by ggplot2, add vertical lines for certain statistics
# ---

add_stats_vlines_to_plot <- function(stats, plot, add_median = TRUE) {

   stddev            <- stats$stddev
   mean              <- stats$mean
   median            <- stats$median
   stddev_range_high <- stats$mean + stddev
   stddev_range_low  <- stats$mean - stddev
   
   color_mean    <- "red"
   color_stddev  <- "blue"
   color_median  <- "orange"
 
   # add a vertical line for "mean"
   
   x_where <- mean
   plot <- plot +
           geom_vline(xintercept=x_where, color=color_mean) +
           annotate(geom="text", x=x_where,  y=0, label="<>", color=color_mean)
           
   # add a vertical line for "median"
   
   if (add_median) {
      x_where <- median
      plot <- plot +           
             geom_vline(xintercept=x_where, color=color_median) +
             annotate(geom="text", x=x_where,  y=0, label="∇", color=color_median) 
   }

   # add a dashed vertical line for "1-stddev range, low value"

   x_where <- stddev_range_high
   plot <- plot + 
           geom_vline(xintercept=x_where, color=color_stddev, linetype="dotdash") +     
           annotate(geom="text", x=x_where, y=0, label="sd-", color=color_stddev)

   # add a dashed vertical line for "1-stddev range, high value" 
          
   x_where <- stddev_range_low
   plot <- plot +    
           geom_vline(xintercept=x_where, color=color_stddev, linetype="dotdash") +     
           annotate(geom="text", x=x_where, y=0, label="sd+", color=color_stddev)

   return(plot)        
}

# ---
# Create a ggplot2 histogram of "ames" "area" values. This may be
# over the whole population or just over a sample. Returns the plot.
# ---

plot_histogram_of_ames_area_data <- function(ames_area_data, binwidth, x_max, titlestr) {

   stats <- compute_ames_area_stats(ames_area_data)

   subtitlestr <-
      paste0(stats$num_obs, " observations",
             ", binwidth = " , binwidth,
             ", min = "      , stats$min,
             ", max = "      , stats$max,
             ", mean = "     , round(stats$mean,1),
             ", median = "   , stats$median,
             ", stddev = "   , round(stats$stddev,1)) 

   plot <-
      ggplot(ames_area_data) +
      coord_cartesian(xlim=c(0,x_max)) + 
      geom_histogram(aes(x=area), binwidth=binwidth, color="grey") +
      labs(x="property area (feet²)", title=titlestr, subtitle=subtitlestr)

   stats_to_add <-
     setNames(as.list(c(stats$stddev,
                        stats$mean,
                        stats$median)), 
              c("stddev", "mean", "median"))
 
   plot <- add_stats_vlines_to_plot(stats_to_add, plot)

   return(plot)
}

# ---
# Create a Probability Density Function for the "ames" "area" values. This may
# be over the whole population or just over a sample.
# "Adjust" gives the kernel width (measure of "smoothness")
# ---

create_pdf_for_ames_area_data <- function(ames_area_data, adjust) {
   density_obj = density(ames_area_data$area, adjust=adjust)
   # str(density_obj)
   pdf <- tibble(x=density_obj$x, y=density_obj$y)
   # str(pdf)
   return(pdf)
}

# ---
# Create a ggplot2 graph of a Probability Density Function for the "ames" "area"
# values. This may be over the whole population or just over a sample. Returns the plot
# ---

plot_pdf_of_ames_area_data <- function(ames_area_data, adjust, x_max, titlestr) {

   stats <- compute_ames_area_stats(ames_area_data)
     
   subtitlestr <-
      paste0(stats$num_obs, " observations",
             ", smoothing = ", adjust,
             ", min = "      , stats$min,
             ", max = "      , stats$max,
             ", mean = "     , round(stats$mean,1),
             ", median = "   , stats$median,
             ", stddev = "   , round(stats$stddev,1)) 
                        
   pdf <- create_pdf_for_ames_area_data(ames_area_data,adjust)

   plot <-
      ggplot(pdf) +
      coord_cartesian(xlim=c(0,x_max)) + 
      geom_line(aes(x=x,y=y)) +
      labs(x="property area (feet²)", y="dp/dx", title=titlestr, subtitle=subtitlestr)

   stats_to_add <-
     setNames(as.list(c(stats$stddev,
                        stats$mean,
                        stats$median)), 
              c("stddev", "mean", "median"))
 
   plot <- add_stats_vlines_to_plot(stats_to_add, plot)

   return(plot)
}

# ---
# Create a single sample by selecting observations at random
# ---

create_single_sample_of_ames_area_observations <- function(ames_area, sample_size) {
   # Use dplyr:sample_n
   # Resulting "sample" is a tibble "sample_size x 1", listing observations
   sample <- sample_n(ames_area, size=sample_size, replace=FALSE)
   # str(sample)
   return(sample)
}

# ---
# Compute statistics of ames area data (either a sample or the whole set
# of observations)
# ---

compute_ames_area_stats <- function(ames_area_data) {

   # Use "summarise" from package "dplyr".
   # This creates a tibble of dimensions "1 x 8", with the columns having the
   # names given below.

   stats <- 
      summarise(ames_area_data,
                mean   = mean(area),
                median = median(area),
                stddev = sd(area),
                iqr    = IQR(area),
                min    = min(area),
                max    = max(area),
                quart1 = quantile(area, 0.25), # first ¼-ile, 25th %-ile
                quart3 = quantile(area, 0.75)) # third ¼-ile, 75th %-ile

   stats <- add_column(stats, num_obs = nrow(ames_area_data))
   return(stats)

}

# ---
# Create multiple samples (and then their sample stats) from the ames dataset
# ---

create_multiple_ames_area_sample_stats <- function(ames_area, sample_size, sample_count) {
   # message("Creating ", sample_count, " samples of ", sample_size, " individuals, and their corresponding sample statistics")

   # Create empty list to store the "sample_count" sample statistics

   fillable_list  <- rep(list(NA), sample_count)

   # This can probably be done in vector fashion instead of a loop...

   for(i in 1:sample_count) {
      # "sample" is a tibble "sample_size x 1", listing observations
      sample <- create_single_sample_of_ames_area_observations(ames_area, sample_size)      
      # "sample_stats" is a tibble "1 x 9", with columns "mean", "median", "stddev", ...
      sample_stats <- compute_ames_area_stats(sample)
      # str(sample_stats)
      fillable_list[[i]] <- sample_stats
   }

   # Not sure why the next instruction works but it does!
   # The result is a tibble with "sample_size x 9", with columns "mean", "median", "stddev", ...

   multiple_sample_stats <- do.call(rbind.data.frame, fillable_list)
   return(multiple_sample_stats)
}


# ---
# Compute the sampling stats (mean of sample means) from the collection of sample stats (sample means etc.)
# ---

compute_sampling_stats_for_mean <- function(multiple_sample_stats) {

   # Use "summarise" from package "dplyr".
   # This creates a tibble of dimensions "1 x 5", with the columns having the
   # names given below.

   stats <- 
      summarise(multiple_sample_stats,
                mean   = mean(multiple_sample_stats$mean),
                median = median(multiple_sample_stats$mean),
                stddev = sd(multiple_sample_stats$mean),
                min    = min(multiple_sample_stats$mean),
                max    = max(multiple_sample_stats$mean))

   stats <- add_column(stats, sample_count = nrow(multiple_sample_stats))
   stats <- add_column(stats, sample_size  = mean(multiple_sample_stats$num_obs)) # constant over samples
   
   return(stats)
}

# ---
# Create a ggplot2 histogram of the "mean" sample statistics (over the samples). Returns the plot.
# ---

plot_histogram_of_ames_area_sample_stats_for_mean <- function(multiple_sample_stats, binwidth, mean_min, mean_max) {

   sampling_stats <- compute_sampling_stats_for_mean(multiple_sample_stats)

   titlestr <- "Histogram of mean of property area over samples of property transactions made in Ames, Iowa, 2006-2010"

   subtitlestr <-
      paste0(sampling_stats$sample_count, " samples of ",
             sampling_stats$sample_size, " observations ",
             ", binwidth = " , binwidth,
             ", min = "      , round(sampling_stats$min,1),
             ", max = "      , round(sampling_stats$max,1),
             ", mean = "     , round(sampling_stats$mean,1),
             ", stddev = "   , round(sampling_stats$stddev,2),
             "\nOverlaid: limit Gaussian postulated by CLT (scaled)")

   plot <-
      ggplot(multiple_sample_stats) +
      coord_cartesian(xlim=c(mean_min,mean_max)) + 
      geom_histogram(aes(x=mean), binwidth=binwidth, color="grey") +
      labs(x="mean of property area over a single sample (feet²)", title=titlestr, subtitle=subtitlestr)

   stats_to_add <-
     setNames(as.list(c(sampling_stats$stddev,
                        sampling_stats$mean,
                        sampling_stats$median)), 
              c("stddev", "mean", "median"))
              
   plot <- add_stats_vlines_to_plot(stats_to_add, plot, add_median = FALSE)

   return(plot)
}

# ---
# Overlay the Normal to which the histogram should converge according to the CLT
# ---

overlay_clt_normal <- function(plot, binwidth, mean_min, mean_max, population_mean, population_stddev, sample_size, sample_count) {
   num_points <- 200
   x <- seq(mean_min, mean_max, (mean_max-mean_min)/(num_points-1)) 
   stretch <- sample_count*binwidth # stretch the small Normal curve to the same dimension as the histogram
   y <- dnorm(x, mean=population_mean, sd=population_stddev/sqrt(sample_size))*stretch
   normal = tibble(x,y)
   plot <- plot + geom_line(data = normal, aes(x=x,y=y))
   return(plot)
}

# ---
# Compute a confidence interval then add its lower and upper limit to the "sample_stat", which is returned
# ---

add_confidence_interval <- function(sample_stats, confidence, verbose) {
   zscore             = -qnorm((1.0-confidence)/2)  # positive surface in tail of the Gaussian (one side)
   sample_size        = sample_stats$num_obs
   standard_error     = sample_stats$stddev / sqrt(sample_size)
   margin_of_error    = zscore*standard_error
   conf_interval_low  = sample_stats$mean - margin_of_error
   conf_interval_high = sample_stats$mean + margin_of_error
   if (verbose) {
      message("The confidence interval at " 
              ,(confidence*100)
              ,"% is ["
              ,conf_interval_low
              ,","
              ,conf_interval_high
              ,"]")
   }
   res <- add_column(sample_stats
                     ,conf_interval_low  = conf_interval_low
                     ,conf_interval_high = conf_interval_high)
   return(res)
}

# ---
# Return TRUE if the population mean is indeed within the confidence interval
# ---

check_confidence_interval <- function(ames_area, population_mean, sample_size, confidence) {  
   # create a single sample and compute its statistics   
   # "sample_stats" is a tibble of 9x1 observations with variables "mean", "median, "stddev" etc..
   sample_stats <- create_multiple_ames_area_sample_stats(ames_area,
                      sample_size=sample_size,
                      sample_count=1)
   # extend the "sample_stats" tibble with information about the confidence interval
   sample_stats <- add_confidence_interval(sample_stats, confidence, verbose=FALSE)
   # str(sample_stats)
   # return TRUE if the population mean is indeed within the confidence interval
   return(sample_stats$conf_interval_low < population_mean && population_mean < sample_stats$conf_interval_high)
}

