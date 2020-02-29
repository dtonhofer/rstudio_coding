# ===
# R code used as basis for illustratig the CLT theorem and
# construction of the confidence interval.
# ===

# ---
# Load the libraries that we need.
# ---

load_libraries_for_tests <- function() {
   library(tidyverse)  # Load the whole tidyverse (ggplot2, dplyr, purrr etc..)
   library(testit)     # For "assert": https://www.rdocumentation.org/packages/testit/versions/0.11
                       # install.packages('testit')
}

# ---
# Call from toplevel to run some test
# ---

run_some_tests <- function() {
   load_libraries_for_tests()
   assert('Testing NULL', {
      NULL == NULL
   })
}

jungle <- function(x) {
   message("Structure via str(x)") # str(x) outputs to terminal
   str(x)
   message("Storage mode via typeof(x): ",typeof(x))
   message("Storage mode via storage.mode(x): ", storage.mode(x))
   if (mode(x) != storage.mode(x)) {
      message("mode(x) and storage.mode(x) differ: mode(x)=", mode(x), ", storage.mode(x)=", storage.mode(x))
   }   
   if (is.null(attributes(x))) {
      message("There are no attributes on this thing")
   }
   else {
      message("Attributes: ", attributes(x))
   }
   if (is.null(attr(x, "class"))) {
      message("There is no 'class' attribute on this thing")
      message("Implicit class as given by class(x): ", class(x))
   }
   else {
      message("Explicit class via class(x): ", class(x))
   }
   if (is.atomic(x) || is.list(x)) {
      message("This is a vector of type: ", typeof(x), " and length: ", length(x))
   }
   else {
      message("This is not a vector")
   }
}

