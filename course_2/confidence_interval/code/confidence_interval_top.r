# ===
# R code to create function plots
# ===

# ---
# Helper to check for NA
# "all(is.na(sample))" because "is.na()" alone proceeds to first element testing on "sample" if
# "sample" is actually not NA and then emits a warning! R language: too clever by half.
# ---

check_na <- function(x) {
   return (all(is.na(x)))
}                      

# ---
# "Histogram of 'area' randvar for all property transactions in Ames, Iowa, 2006-2010"
# ---

plot1 <- function(binwidth, x_max, filename=NA) {
   load_libraries()
   ames_area <- load_dataset_ames_area()
   titlestr <- "Histogram of 'area' randvar for all property transactions in Ames, Iowa, 2006-2010"
   plot <- plot_histogram_of_ames_area_data(ames_area, binwidth=binwidth, x_max=x_max, titlestr=titlestr)
   # maybe save plot to file, if filename given, using https://ggplot2.tidyverse.org/reference/ggsave.html
   # an existing file will be overwritten w/o warning
   if (!is.na(filename)) {      
      ggsave(filename, plot=plot, device="png", width=plot_width, height=plot_height, units="cm", dpi=plot_dpi)
   }
   # actually plot
   print(plot)
}

# ---
# Approximating PDF of 'area' randvar for all property transactions in Ames, Iowa, 2006-2010
# ---

plot2 <- function(smoothing, x_max, filename=NA) {
   load_libraries()
   ames_area <- load_dataset_ames_area()
   titlestr <- "Approx. PDF for 'area' randvar for all property transactions in Ames, Iowa, 2006-2010"
   plot <- plot_pdf_of_ames_area_data(ames_area, adjust=smoothing, x_max=x_max, titlestr=titlestr)
   # maybe save plot to file, if filename given, using https://ggplot2.tidyverse.org/reference/ggsave.html
   # an existing file will be overwritten w/o warning
   if (!is.na(filename)) {      
      ggsave(filename, plot=plot, device="png", width=plot_width, height=plot_height, units="cm", dpi=plot_dpi)
   }
   # actually plot
   print(plot)
} 

# ---
# "Histogram of 'area' randvar for a single sample of property transactions in Ames, Iowa, 2006-2010"
# ---

plot3 <- function(sample=NA, binwidth, x_max, sample_size, filename=NA) {
   load_libraries()
   ames_area <- load_dataset_ames_area()
   if (check_na(sample)) {
      sample <- create_single_sample_of_ames_area_observations(ames_area, sample_size=sample_size)
   }
   else {
      # just use the sample provided!
      str(sample)
   }
   titlestr <- "Histogram of 'area' randvar for a single sample of property transactions in Ames, Iowa, 2006-2010"
   plot <- plot_histogram_of_ames_area_data(sample, binwidth=binwidth, x_max=x_max, titlestr=titlestr)
   # maybe save plot to file, if filename given, using https://ggplot2.tidyverse.org/reference/ggsave.html
   # an existing file will be overwritten w/o warning
   if (!is.na(filename)) {      
      ggsave(filename, plot=plot, device="png", width=plot_width, height=plot_height, units="cm", dpi=plot_dpi)
   }   
   # actually plot
   print(plot)
   return(sample)
}

# ---
# "PDF of 'area' randvar for a single sample of property transactions in Ames, Iowa, 2006-2010"
# ---

plot4 <- function(sample=NA, smoothing, x_max, sample_size=NA, filename=NA) {
   load_libraries()
   ames_area <- load_dataset_ames_area()
   if (check_na(sample)) {
      assert("if 'sample' is not set, then 'sample_size' must be", {
         !check_na(sample_size)
      })
      sample <- create_single_sample_of_ames_area_observations(ames_area, sample_size=sample_size)
   }      
   titlestr <- "Approx. PDF of 'area' randvar for a single sample of property transactions in Ames, Iowa, 2006-2010"
   plot <- plot_pdf_of_ames_area_data(sample, adjust=smoothing, x_max=x_max, titlestr=titlestr)
   # maybe save plot to file, if filename given, using https://ggplot2.tidyverse.org/reference/ggsave.html
   # an existing file will be overwritten w/o warning
   if (!is.na(filename)) {      
      ggsave(filename, plot=plot, device="png", width=plot_width, height=plot_height, units="cm", dpi=plot_dpi)
   }   
   # actually plot
   print(plot)
   return(sample)   
} 

# ----
# Histogram of "mean" for several samples, with Gaussian expected by CLT superimposed
# ----

plot5 <- function(sample_size,sample_count,sample_stats_binwidth,sample_stats_min,sample_stats_max,filename=NA) {
   load_libraries()
   ames_area <- load_dataset_ames_area()  
   multiple_sample_stats <- create_multiple_ames_area_sample_stats(
             ames_area, 
             sample_size=sample_size, 
             sample_count=sample_count)      
   str(multiple_sample_stats)   
   plot <- plot_histogram_of_ames_area_sample_stats_for_mean(
             multiple_sample_stats,
             binwidth=sample_stats_binwidth, 
             mean_min=sample_stats_min, 
             mean_max=sample_stats_max)
   population_stats <- compute_ames_area_stats(ames_area)
   plot <- overlay_clt_normal(
             plot,
             binwidth=sample_stats_binwidth, 
             mean_min=sample_stats_min, 
             mean_max=sample_stats_max, 
             population_mean=population_stats$mean,
             population_stddev=population_stats$stddev,
             sample_size=sample_size,
             sample_count=sample_count)
   # maybe save plot to file, if filename given, using https://ggplot2.tidyverse.org/reference/ggsave.html
   # an existing file will be overwritten w/o warning
   if (!is.na(filename)) {      
      ggsave(filename, plot=plot, device="png", width=plot_width, height=plot_height, units="cm", dpi=plot_dpi)
   }   
   # actually plot
   print(plot)
} 

# ---
# Empirically test the confidence interval by creating "trial_count" samples of
# "sample_size" individuals to compute the proportion of samples which indeed have
# the actual population mean within their "sample-based confidence interval".
# ---

empiricially_test_confidence_interval <- function(sample_size, confidence, trial_count) {
   load_libraries()
   assert("confidence is in [0.5,1[", {
      0.5 <= confidence
      confidence < 1.0
   })
   assert("sample_size is in [10,1000]", {
      is.integer(sample_size)
      10 <= sample_size
      sample_size <= 1000
   })
   assert("trial_count is in [1,1000]", {
      is.integer(trial_count)
      1 <= trial_count
      trial_count <= 1000   
   })
   ames_area        <- load_dataset_ames_area()  
   population_stats <- compute_ames_area_stats(ames_area)
   population_mean  <- population_stats$mean
   results <- replicate(trial_count,
                        check_confidence_interval(ames_area,population_mean,sample_size,confidence))
   actual_confidence = mean(results)
   message("At confidence level "
           ,(confidence*100)
           ,"% and sample size "
           ,sample_size
           ," the proportion of samples (of "
           ,trial_count
           ," samples) with population mean inside their confidence interval is: "
           ,actual_confidence)
   return(actual_confidence)           
}

