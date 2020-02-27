# Coursera "Statistics with R" C2W1: Plotting the PDF of "area" of the "ames" dataset

## Prepare

- Load libraries according to [this gist](https://gist.github.com/dtonhofer/408a6c15ee4d171fd9314113660cd312).
- Load "ames" dataset according to [this gist](https://gist.github.com/dtonhofer/5b14680401823826120c7bebcdccb8f7).

## A quick histogram of the property area values

Histogram plot of raw data (limited to maximum 4000 feet² property)

````
ggplot(data = ames_area, aes(x = area), title="area (feet²)") + 
     geom_histogram(binwidth = 250, color = "grey") +
     coord_cartesian(xlim = c(0,4000)) + 
     labs(x="property area (feet²)", title="Property transactions in Ames, Iowa, 2006-2010")
````    

![property transactions in ames.png](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/course_2_week_1/plots/property_transactions_in_ames.png)

## Smoothing the property area values into a Probability Density Function

`ggplot2` has its own PDF smoother, but we are using the one of package `stats`:

- [stats.density](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/density): _Transform collected area values into a smoothed probability density function over the range of area values_
- [ggplot2.geom_density](https://www.rdocumentation.org/packages/ggplot2/versions/3.2.1/topics/geom_density): _Computes and draws kernel density estimate, which is a smoothed version of the histogram._

````
make_area_pdf <- function(ames_area,adj) {
   density_obj = density(ames_area$area, adjust = adj)
   str(density_obj)
   pdf <- tibble(x = density_obj$x, y = density_obj$y)
   str(pdf)
   return(pdf)
}

ames_area_pdf <- make_area_pdf(ames_area,1)
````

`ames_area_pdf` is a column of (regularly spaced) `x` values and a column of `y` values. Being a PDF, we check that the
approximate integral over that function is approximately 1.0:

````
sum((ames_area_pdf$x[2]-ames_area_pdf$x[1])*ames_area_pdf$y)
[1] 1.000978
````

Sounds about right.

Now for something more adventurous. We can certainly plot the historgram by itself and the PDF by itself.
But can we overlay them?

The two graphs have very different scaling. A histogram bin height represents the absolute number of transactions
recorded for property areas [x, x+binwidth]. A point on the PDF curve represents the relative number of transactions
recorded for property areas [x, x+dx]. 

- I don't know how to "rescale" the histogram.
- But it is possible to rescale the PDF by multiplying it with _binwidth*total number of transactions_

````
plot_overlaid <- function(ames_area_pdf,ames_area,binwidth) {
   stretcher = length(ames_area$area) * binwidth
   stretched_ames_area_pdf = tibble(ames_area_pdf$x, ames_area_pdf$y * stretcher)
   names(stretched_ames_area_pdf)[1] <- "x"
   names(stretched_ames_area_pdf)[2] <- "y"
   plot <-
      ggplot() + 
      coord_cartesian(xlim = c(0,4000)) +           
      geom_histogram(binwidth = binwidth, color = "darkgrey", fill = "grey", 
                     data = ames_area, aes(x = area), alpha = 0.3) + 
      geom_line(data = stretched_ames_area_pdf, aes(x = x, y = y)) +
      labs(x="property area (feet²)", y="stretched probability density",
           title="Stretched probability density function for property transactions in Ames, Iowa, 2006-2010")
   return(plot)           
}

plot_overlaid(ames_area_pdf,ames_area,250)
````    

![property transactions in ames overlaid pdf](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/course_2_week_1/plots/property_transactions_in_ames_overlaid_pdf.png)


## Highlight values

Finally we want to highlight some particular x values:

- The population mean (officialy, "μ");
- The population median (inofficially, "∇", the _nabla_ sign, because I like it);
- The population standard deviation (officialy, "σ"), or rather the values μ-σ, μ+σ;
- The "asym_σ_hi", a particular sigma that I just invented; is is computed like σ for values above μ;
- The "asym_σ_lo", a particular sigma that I just invented; is is computed like σ for values below μ;
  - The interval [μ-asym_σ_lo, μ+asym_σ_hi] is asymmetric, unlike the interval [μ-σ, μ+σ], and carries some information about the actual distribution (similar to the interquartile ranges).

````
plot_overlaid_extras <- function(ames_area_pdf,ames_area,binwidth) {

   # Standard summary values
   
   area_sigma       <- sd(ames_area$area)
   area_mu          <- mean(ames_area$area)
   area_nabla       <- median(ames_area$area)
   area_sigma_hi    <- area_mu + area_sigma
   area_sigma_lo    <- area_mu - area_sigma

   # Asymmetric standard deviation

   area_above_mu <- filter(ames_area, area_mu < area)
   area_below_mu <- filter(ames_area, area < area_mu)
   
   area_above_mu_dsq <- lapply(area_above_mu, function(x) { (x - area_mu)**2 })
   area_below_mu_dsq <- lapply(area_below_mu, function(x) { (x - area_mu)**2 })
   
   area_asym_sigma_hi <- area_mu + sqrt(mean(area_above_mu_dsq$area))
   area_asym_sigma_lo <- area_mu - sqrt(mean(area_below_mu_dsq$area))
   
   col_mu         <- "red"
   col_sigma      <- "blue"
   col_asym_sigma <- "magenta"
   col_nabla      <- "yellow"

   plot <- plot_overlaid(ames_area_pdf,ames_area,binwidth) +
      geom_vline(xintercept=area_mu, color = col_mu) +
      annotate(geom="text", x=area_mu+50,  y=0, label="μ", color=col_mu) +
      geom_vline(xintercept=area_nabla, color = col_nabla) +
      annotate(geom="text", x=area_nabla-50,  y=0, label="∇", color=col_nabla) + 
      geom_vline(xintercept=area_sigma_lo, color = col_sigma) +     
      annotate(geom="text", x=area_sigma_lo-50, y=0, label="μ-σ", color=col_sigma) +
      geom_vline(xintercept=area_sigma_hi, color = col_sigma) +     
      annotate(geom="text", x=area_sigma_hi+50, y=0, label="μ+σ", color=col_sigma) +
      geom_vline(xintercept=area_asym_sigma_lo, color = col_asym_sigma) +
      annotate(geom="text", x=area_asym_sigma_lo, y=600, label="μ-asym_σ_lo", color=col_asym_sigma) +               
      geom_vline(xintercept=area_asym_sigma_hi, color = col_asym_sigma) + 
      annotate(geom="text", x=area_asym_sigma_hi, y=600, label="μ+asym_σ_hi", color=col_asym_sigma)      
   return(plot)
}

plot_overlaid_extras(ames_area_pdf,ames_area,250)
````

![property transactions in ames overlaid pdf lines](https://raw.githubusercontent.com/dtonhofer/rstudio_coding/master/course_2_week_1/plots/property_transactions_in_ames_overlaid_pdf_lines.png)

Still looks a bit inelegant.

## Note

Eyeballing the graph, one feels that the Standard Deviation doesn't really make sense as "distance from the mean"
in case of a skewed, asymmetric distribution. It is just some general measure of the spread of the distribution,
and not even dimensionless.

See this discussion of some interest: [Why square the difference instead of taking the absolute value in standard deviation?](https://stats.stackexchange.com/questions/118/why-square-the-difference-instead-of-taking-the-absolute-value-in-standard-devia)


