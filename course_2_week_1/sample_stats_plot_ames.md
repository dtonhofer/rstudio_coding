# Coursera "Statistics with R" C2W1: Plotting the distribution of sample statistics of "area" of the "ames" dataset

We want to plot:

- The distribution of _s_ (sample standard deviation)
- ... of samples taken from the "Ames" dataset
- ... of the area in feet² of properties transacted, in Ames, Iowa between 2006 and 2010.

## Notes

- [paste, paste0, and sprintf](https://www.r-bloggers.com/paste-paste0-and-sprintf/) - generate strings, yay!!
- [Why is message() a better choice than print() in R for writing a package?](https://stackoverflow.com/questions/36699272/why-is-message-a-better-choice-than-print-in-r-for-writing-a-package)
- [futile.logger](https://www.r-bloggers.com/better-logging-in-r-aka-futile-logger-1-3-0-released/), [futile.logger at CRAN](https://cran.r-project.org/web/packages/futile.logger/index.html): I can haz proper logging in R!
- [ggplot2 linetypes](http://sape.inf.usi.ch/quick-reference/ggplot2/linetype)
- [ggplot2 `scale_manual`](https://ggplot2.tidyverse.org/reference/scale_manual.html)

## Kickoff

- Load libraries according to [this gist](https://gist.github.com/dtonhofer/408a6c15ee4d171fd9314113660cd312).
- Load "ames" dataset according to [this gist](https://gist.github.com/dtonhofer/5b14680401823826120c7bebcdccb8f7).

## Sample repeatedly from the "ames" data set

We use:

- [base::rep](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/rep) for repeating an operation
- [dplyr::sample_n](https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/sample) for sampling
- [dplyr::summarise](https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/summarise) with the
associated `mean()`, `median()` etc.
- [base::rbind](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/cbind) to bind row vectors
into a data frame
- [base::do.call](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/do.call) to perform a call
to `rbind()` 
- [base::message](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/message) to write a message.


````
create_sample_statistics <- function(sample_size, num_samples, ames_area) {
   message("Creating ", num_samples, " samples of ", sample_size, " individuals, and their statistics")
   # create empty list to store the "num_samples" sample statistics
   list_of_obs  <- rep(list(NA), num_samples) 
   # this can probably be done in vector fashion instead of a loop
   for(i in 1:num_samples) {
      a_sample  <- ames_area %>% sample_n(size = sample_size, replace = FALSE)   
      a_summary <- a_sample %>% summarise(
                     sample_mu     = mean(area),
                     sample_median = median(area),
                     sample_sigma  = sd(area),
                     sample_iqr    = IQR(area),
                     sample_min    = min(area),
                     sample_max    = max(area),
                     sample_quart1 = quantile(area, 0.25), # first ¼-ile, 25th %-ile
                     sample_quart3 = quantile(area, 0.75)) # third ¼-ile, 75th %-ile
       list_of_obs[[i]] <- a_summary
   }
   # not sure why the next instruction works but it does!
   sample_statistics <- do.call(rbind.data.frame, list_of_obs)    
   return(sample_statistics)
}

sample_statistics <- create_sample_statistics(100, 500, ames_area)
````

## Plot distribution of sample statistics 

Each sample obtained can be seen as an individual giving rise to a few new random variables:

- the _mean_ of the samples' _area_ values (_x bar_ = _x̅_)  (why doesn't everything, including this page, accept [proper TeX notation](https://docs.moodle.org/38/en/Using_TeX_Notation)? One day it will happen!!);
- the _standard deviation_ of the samples' _area_ values (_s_);
- the _median_ of the samples' _area_ values.

A statistic over the above values would be a "second order statistics".

- The "first order statistics" being the one over the population (e.g. "mean of a population random variable", in this case, the area in feet²)
- The "second order statistics" being the one over the samples (e.g. "mean of a sample random variable", in this case, the mean area in feet²)

_**TODO/FUN**: Find a measure that expresses how much a distribution resembles a Gaussian (look somewhere in the general
direction of [L-moments](https://en.wikipedia.org/wiki/L-moment)) and plot the graph of that value as sample size
increases (this is a "third-order" statistics because it is derived from a series of samples over the population).
statistic, because it is derived from a series of samples._

```` 
plot_ames_sample_statistics <- function(sample_size, num_samples, ames_area, hg_binwidth, x_limit) {

   # Population statistics
   
   area_sigma       <- sd(ames_area$area)
   area_mu          <- mean(ames_area$area)
   area_nabla       <- median(ames_area$area)
   area_sigma_hi    <- area_mu + area_sigma
   area_sigma_lo    <- area_mu - area_sigma

   # Sample statistics
   
   sample_statistics <- create_sample_statistics(sample_size, num_samples, ames_area)
   str(sample_statistics)
   
   # Select certain values and create a dataframe
   
   sample_statistics_melted  <- melt(sample_statistics[c('sample_mu','sample_median','sample_sigma')])
   str(sample_statistics_melted)
   
   # Create plot showing distribution of sample statistics (mean over sample etc.)
   # From which one can eyeball the *sampling* statistics (mean over mean over samples etc.)
   
   col_mu         <- "red"
   col_sigma      <- "blue"
   col_asym_sigma <- "magenta"
   col_nabla      <- "yellow"
   alpha          <- 0.5
   
   titlestr <- "Distribution of sample statistics for property transactions in Ames, Iowa, 2006-2010"
   subtitlestr <- paste0("Statistics over ", num_samples, " samples of ", sample_size,
                         " transactions, plotted with bindwidth ", hg_binwidth)

   plot <- sample_statistics_melted %>% ggplot() +
           coord_cartesian(xlim = c(0,x_limit)) + 
           geom_histogram(aes(x = value, fill = variable), binwidth = hg_binwidth, alpha = alpha, position="identity") +
           labs(x="property area (feet²)", title=titlestr,subtitle=subtitlestr)
           
   # The line below looks like a suboptimal way of defining a mapping from a factor (sample_mu,
   # sample_median, sample_sigma) to a label or a color. There must be a better way.
   
   plot <- plot + scale_fill_manual(labels = c("sample mean (x̅) ", "sample median", "sample s.d. (s)"), 
                                     values = c(col_mu, col_nabla, col_sigma))

   # add a vertical line for the population mean μ
   
   plot <- plot +
           geom_vline(xintercept=area_mu, color = col_mu) +
           annotate(geom="text", x=area_mu+50,  y=0, label="μ", color=col_mu)
           
   # add a vertical line for the population median ∇
   
   plot <- plot +           
           geom_vline(xintercept=area_nabla, color = col_nabla) +
           annotate(geom="text", x=area_nabla-50,  y=0, label="∇", color=col_nabla) 

   # add two dashed vertical lines for the population's  μ-σ, μ+σ 

   plot <- plot + 
           geom_vline(xintercept=area_sigma_lo, color = col_sigma, linetype="dotdash") +     
           annotate(geom="text", x=area_sigma_lo-50, y=0, label="μ-σ", color=col_sigma) +
           geom_vline(xintercept=area_sigma_hi, color = col_sigma, linetype="dotdash") +     
           annotate(geom="text", x=area_sigma_hi+50, y=0, label="μ+σ", color=col_sigma)

   # add a vertical lines for the population standard deviation σ

   plot <- plot +
           geom_vline(xintercept=area_sigma, color = col_sigma) +     
           annotate(geom="text", x=area_sigma, y=0, label="σ", color=col_sigma)
           
   return(plot)        
}
````

## Results

The binwidth for the resulting histograms must be relatively small because the distributions are relatively
narrow (being narrowed by ~ `sqrt(sample_size)`)

### Sample size 50

````
plot_ames_sample_statistics(sample_size = 50, 
                            num_samples = 500, 
                            ames_area, hg_binwidth = 20, x_limit = 2000)
````

![500 samples of 50 transactions](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/course_2_week_1/plots/ames_dataset_sample_statistics_plot__500_samples_of_50_transactions.png)

### Sample size 100

````
plot_ames_sample_statistics(sample_size = 100, 
                            num_samples = 500, 
                            ames_area, hg_binwidth = 20, x_limit = 2000)
````

![500 samples of 100 transactions](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/course_2_week_1/plots/ames_dataset_sample_statistics_plot__500_samples_of_100_transactions.png)

### Sample size 200

````
plot_ames_sample_statistics(sample_size = 200,
                            num_samples = 500, 
                            ames_area, hg_binwidth = 20, x_limit = 2000)
````

![500 samples of 200 transactions](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/course_2_week_1/plots/ames_dataset_sample_statistics_plot__500_samples_of_200_transactions.png)


