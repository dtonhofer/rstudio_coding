# Building "Confidence Intervals"

## Illustration to explain reasoning behind the construction of "Confidence Intervals".

![Confidence interval pipeline graph](https://raw.githubusercontent.com/dtonhofer/diagrams/master/RStudio_Exercises/Confidence_Interval_Pipeline/confidence_interval_pipeline.png)

## Plots based on the "ames" dataset

### Histogram and PDF over the whole of the population

Population statistics are indicated.

![Histogram, whole population](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/confidence_interval/plots/histogram_of_ames_area_randvar_over_population.png)

![PDF, whole population](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/confidence_interval/plots/pdf_of_ames_area_randvar_over_population.png)

### Histogram and PDF over a single sample

Sample statistics are indicated.

![Histogram, single sample](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/confidence_interval/plots/histogram_of_ames_area_randvar_for_single_sample.png)

![PDF, single sample](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/confidence_interval/plots/pdf_of_ames_area_randvar_for_single_sample.png)

### Histogram of means computed from many samples

Sampling statistics are indicated

![Histogram of sample statistics](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/confidence_interval/plots/histogram_of_mean_over_samples_of_ames_area_randvar.png)

## Empirically testing the confidence interval

The little function `empiricially_test_confidence_interval()` checks whether the interpretation of
the confidence interval is correct.

> "We are X% certain that the confidence interval is between LOW and HIGH"

means

> "A proportion of (approximately) X% of the samples (obtained under the same circumstances
> as the sample at hand) have a confidence interval (computed under the same circumstances
> as the interval [LOW,HIGH] computed using the sample mean and sample standard deviation of the
> sample at hand) that includes the true population mean.

How much "approximate" is "approximately", which is beset by noise due to random selection
and noise due to use of approximating values, in particular the sample mean and the sample
standard deviation.

This test says it's "not bad":

````
empiricially_test_confidence_interval(sample_size=100, confidence=0.90, trial_count=500)
````

> At confidence level 90% and sample size 100
> the proportion of samples (of 500 samples) with
> population mean inside their confidence interval is: 0.906

````
empiricially_test_confidence_interval(sample_size=100, confidence=0.95, trial_count=500)
````

> At confidence level 95% and sample size 100
> the proportion of samples (of 500 samples) with 
> population mean inside their confidence interval is: 0.952

````
empiricially_test_confidence_interval(sample_size=100, confidence=0.98, trial_count=500)
````

> At confidence level 98% and sample size 100
> the proportion of samples (of 500 samples) with
> population mean inside their confidence interval is: 0.976

````
empiricially_test_confidence_interval(sample_size=100, confidence=0.99, trial_count=500)
````

> At confidence level 99% and sample size 100
> the proportion of samples (of 500 samples) with
> population mean inside their confidence interval is: 0.99

## Code to generate plots

- Basis: [confidence_interval_base.r](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/confidence_interval/code/confidence_interval_base.r)
- Functions to create the plots, calls the above: [confidence_interval_top.r](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/confidence_interval/code/confidence_interval_top.r)
- The code to execute in R/RStudio, loads and calls the above: [confidence_interval_cmd.r](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/confidence_interval/code/confidence_interval_cmd.r)

