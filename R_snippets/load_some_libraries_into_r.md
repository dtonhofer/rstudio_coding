# Load some libraries into R

Principle: write a function, then call it!

We load the whole ensemble of libraries of the [Tidyverse](https://www.tidyverse.org/) instead of selected
libraries thereof.

The [ensemble contains](https://www.tidyverse.org/packages/):

- [ggplot2](https://ggplot2.tidyverse.org/)
- [dplyr](https://dplyr.tidyverse.org/)
- [tidyr](https://tidyr.tidyverse.org)
- [readr](https://readr.tidyverse.org/)
- [purrr](https://purrr.tidyverse.org/)
- [tibble](https://tibble.tidyverse.org/)
- [stringr](https://stringr.tidyverse.org/)
- [forcats](https://forcats.tidyverse.org/)

The `statsr` library code can be found [here](https://github.com/StatsWithR/statsr).

So:

````
# ---
# Load the libraries that we need. Indicate whether "shiny" is needed (probably not)
# ---

load_libraries <- function(withshiny = FALSE) {
   library(tidyverse)  # Load the whole tidyverse (ggplot2, dplyr, purrr etc..)
                       # You may have to run `install.packages("tidyverse")` first.
   library(statsr)     # Companion package for the Coursera "Statistics with R" specialization 
   library(reshape2)   # Provides "reshape" to "melt" a data frame
   if (withshiny) {
      library(shiny)   # "An R package to build interactive web apps straight from R.", by RStudio. 
   }
   library(testit)     # For "assert": https://www.rdocumentation.org/packages/testit/versions/0.11
                       # You may have to run `install.packages("testit")` first.
}
````

After R knows about that function, you can just run:

````
load_libraries()
````

We see:

````
> loadthem()
── Attaching packages ───────────────────────────────────── tidyverse 1.3.0 ──
✔ tibble  2.1.3     ✔ purrr   0.3.3
✔ tidyr   1.0.0     ✔ stringr 1.4.0
✔ readr   1.3.1     ✔ forcats 0.4.0
── Conflicts ──────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
````

Looking good.

## For the future

Write the code above into a file called `loadlibs.r` in directory `scripts` and then run

````
source("~/scripts/loadlibs.r")
````

in R whenever you need to load the libraries again.
