# More on R

## R assertions and unit testing packages

[Assertions](https://en.wikipedia.org/wiki/Assertion_(software_development))? [Unit Testing](https://en.wikipedia.org/wiki/Unit_testing)? Yes, those. Use them! Without these exoskeletons you are not coding, just fumbling in the dark.

- Simple: [testit](https://www.rdocumentation.org/packages/testit/versions/0.11)
- Extensive (like [JUnit](https://junit.org/junit5/)): [testthat](https://cran.r-project.org/web/packages/testthat/index.html)

## R is organic!

- R-Bloggers: [NA vs. NULL](https://www.r-bloggers.com/r-na-vs-null/)
- StackOverflow: [Notes on the R object system(s)](https://stackoverflow.com/questions/6583265/what-does-s3-methods-mean-in-r)

## R language definition

- [R Language Definition at CRAN](https://cran.r-project.org/doc/manuals/R-lang.html)

## Good to read

#### Questions/Answers of some interest on Stack Overflow

- [The difference between bracket \[\] and double bracket \[\[\]\] for accessing the elements of a list or dataframe](https://stackoverflow.com/questions/1169456/the-difference-between-bracket-and-double-bracket-for-accessing-the-el). 
   - See [Indexing](https://cran.r-project.org/doc/manuals/R-lang.html#Indexing). 
   - Also, from Quora: [What is the difference between \[ \] and \[\[ \]\] in R?](https://www.quora.com/What-is-the-difference-between-and-in-R?share=1)
- [What are the differences between “=” and “<-” assignment operators in R?](https://stackoverflow.com/questions/1741820/what-are-the-differences-between-and-assignment-operators-in-r)
- [What is the meaning of the dollar sign “$” in R function()?](https://stackoverflow.com/questions/42560090/what-is-the-meaning-of-the-dollar-sign-in-r-function)
- [Remove duplicated rows using dplyr](https://stackoverflow.com/questions/22959635/remove-duplicated-rows-using-dplyr)

#### Expressions

How does the following even work? It must grab into the Abstract Syntax Tree of the parameter expression. Even a LISP cannot do that without resorting to macros ... I think.

````
ci <- ames %>%
        rep_sample_n(size = n, reps = 50, replace = TRUE) %>%
        summarise(lower = mean(area) - z_star_95 * (sd(area) / sqrt(n)),
                  upper = mean(area) + z_star_95 * (sd(area) / sqrt(n)))
````

- https://adv-r.hadley.nz/evaluation.html (second edition)
- http://adv-r.had.co.nz/Expressions.html (first edition)
- https://stackoverflow.com/questions/4692231/r-passing-expression-to-an-inner-function
- https://stackoverflow.com/questions/4682709/how-to-write-an-r-function-that-evaluates-an-expression-within-a-data-frame

#### Tidyverse "dplyr"

- [Programming with dplyr](https://dplyr.tidyverse.org/articles/programming.html)

#### "The R Inferno"

by Patrick Burns, 2011-04-30

> Abstract: If you are using R and you think you’re in hell, this is a map for you. A book about trouble spots,
> oddities, traps, glitches in R.  Many of the same problems are in S+.

PDF at ["The R Inferno"](http://www.burns-stat.com/documents/books/the-r-inferno/) page.

Contents:

- Circle 2: Growing Objects
- Circle 3: Failing to Vectorize
- Circle 4: Over-Vectorizing
- Circle 5: Not Writing Functions
- Circle 6: Doing Global Assignments
- Circle 7: Tripping on Object Orientation
- Circle 8: Believing it Does as Intented _(packed full of good stuff)_
- Circle 9: Unhelpfully Seeking Help 

#### The R FAQ

It's at https://cran.r-project.org/faqs.html

#### "Advanced R"

By Hadley Wickham.

- [First Edition](http://adv-r.had.co.nz)
- [Second Edition](https://adv-r.hadley.nz/)

From the [Introduction to the 1st Edition](http://adv-r.had.co.nz/Introduction.html):

> To get the most out of this book, you’ll need to have written a decent amount of code in R or
> another programming language. You might not know all the details, but you should be familiar
> with how functions work in R and although you may currently struggle to use them effectively,
> you should be familiar with the apply family (like apply() and lapply()).

> You are confronted with over 20 years of evolution every time you use R.
> Learning R can be tough because there are many special cases to remember.

From the [Introduction to the 2nd Edition](https://adv-r.hadley.nz/introduction.html):

> This book delivers the knowledge that I think an advanced R programmer should possess: a deep
> understanding of the fundamentals coupled with a broad vocabulary that means that you can 
> tactically learn more about a topic when needed.

> What you will not learn
> 
> This book is about R the programming language, not R the data analysis tool. If you are
> looking to improve your data science skills, I instead recommend that you learn about 
> the tidyverse, a collection of consistent packages developed by me and my colleagues.
> In this book you’ll learn the techniques used to develop the tidyverse packages; if you
> want to instead learn how to use them, I recommend _R for Data Science_.

> A scientific mindset is extremely helpful when learning R. If you don’t understand 
> how something works, you should develop a hypothesis, design some experiments, run them,
> and record the results. This exercise is extremely useful since if you can’t figure
> something out and need to get help, you can easily show others what you tried. Also,
> when you learn the right answer, you’ll be mentally prepared to update your world view.

Contents of the 1st Edition:

- Introduction
- Foundations
  - [Data structures](http://adv-r.had.co.nz/Data-structures.html)
  - Subsetting
  - Vocabulary
  - Style
  - Functions
  - OO field guide
  - Environments
  - Exceptions and debugging
- Functional programming
  - Functional programming
  - Functionals
  - Function operators
- Metaprogramming
  - Non-standard evaluation
  - Expressions
  - Domain specific languages
- Performant code
  - Performance
  - Profiling
  - Memory
  - Rcpp
  - R's C interface
