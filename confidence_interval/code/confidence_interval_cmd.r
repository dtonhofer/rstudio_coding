# ===
# R code that calls the function to build plots
# ===

# ---
# Load code that will be called
# ---

source("confidence_interval_base.r")
source("confidence_interval_top.r")

# ---
# Set common values
# ---

plot_width  <- 25
plot_height <- 10
plot_dpi    <- 150
path        <- "/tmp"
 
# ---
# Create plots.
# Files are dumped into directory "path"
# ---

plot1(binwidth=150, 
      x_max=4000,
      path=path,
      filename="histogram_of_ames_area_randvar_over_population.png")

plot2(smoothing=1.5,
      x_max=4000,
      path=path,
      filename="pdf_of_ames_area_randvar_over_population.png")
      
sample <- plot3(binwidth=150,
                x_max=4000,
                sample_size=100,
                path=path,
                filename="histogram_of_ames_area_randvar_for_single_sample.png")
                
# reuse previous sample and aggressively smooth the next plot

plot4(sample=sample, 
      smoothing=2,
      x_max=4000,
      path=path,
      filename="pdf_of_ames_area_randvar_for_single_sample.png")
      
plot5(sample_size=100,
      sample_count=300,
      sample_stats_binwidth=10,
      sample_stats_min=1200,
      sample_stats_max=1800,
      filename="histogram_of_mean_over_samples_of_ames_area_randvar.png")

# The calls just print out results

empiricially_test_confidence_interval(sample_size=100, confidence=0.90, trial_count=500)
empiricially_test_confidence_interval(sample_size=100, confidence=0.95, trial_count=500)
empiricially_test_confidence_interval(sample_size=100, confidence=0.98, trial_count=500)
empiricially_test_confidence_interval(sample_size=100, confidence=0.99, trial_count=500)

# At confidence level 90% and sample size 100
# the proportion of samples (of 500 samples) with
# population mean inside their confidence interval is: 0.906
#
# At confidence level 95% and sample size 100
# the proportion of samples (of 500 samples) with 
# population mean inside their confidence interval is: 0.952
#
# At confidence level 98% and sample size 100
# the proportion of samples (of 500 samples) with
# population mean inside their confidence interval is: 0.976
#
# At confidence level 99% and sample size 100
# the proportion of samples (of 500 samples) with
# population mean inside their confidence interval is: 0.99

