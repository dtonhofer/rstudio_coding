# "Statistics with R" coding attempts

Some code for the Coursera "Statistics with R" specialization course as organized by Duke University:

[Statistics with R Specialization](https://www.coursera.org/specializations/statistics)

This repository will change often!

- Course 1: ["Introduction to Probability and Data"](https://www.coursera.org/learn/probability-intro/)
   - Week 1: "Introduction"
   - Week 2: "Exploratory Data Analysis and Introduction to Inference"
   - Week 3: "Defining Probability & Conditional Probability"
   - Week 4: "Probability Distributions"
   - Week 5: "Peer-Reviewed Assignment"
- Course 2: ["Inferential Statistics"](https://www.coursera.org/learn/inferential-statistics-intro/)
   - Week 1: "Central Limit Theorem and Confidence Interval"
   - Week 2: "Hypothesis Testing"

## Good to know

### R assertions and unit testing packages

[Assertions](https://en.wikipedia.org/wiki/Assertion_(software_development))? [Unit Testing](https://en.wikipedia.org/wiki/Unit_testing)? Yes, those. Use them! Without these exoskeletons you are not coding, just fumbling in the dark.

- Simple: [testit](https://www.rdocumentation.org/packages/testit/versions/0.11)
- Extensive (like [JUnit](https://junit.org/junit5/)): [testthat](https://cran.r-project.org/web/packages/testthat/index.html)

### R is organic!

- [NA vs. NULL](https://www.r-bloggers.com/r-na-vs-null/)
- [Notes on the R object system(s)](https://stackoverflow.com/questions/6583265/what-does-s3-methods-mean-in-r)

## Good to read

### R

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

### Probability and Statistics

#### Stanford Encyclopedia of Philosophy

- [Interpretations of Probability](https://plato.stanford.edu/entries/probability-interpret/)
- [Information](https://plato.stanford.edu/entries/information/)
- [Causal Models](https://plato.stanford.edu/entries/causal-models/)

#### "The Foundations of Statistics Reconsidered"

by Leonard J. Savage, University of Michigan. Appears in: _Vol.1 of the Proceedings of the Fourth Berkeley Symposium on Mathematics and Probability, Berkeley, University of California Press, 1961._

> Introduction: This is an expository paper on the evolution of opinion about the foundations of statistics.
> It particularly emphasizes the paths that some of us have followed to a position that may be called
> Bayesian or neo-Bayesian.
> The intense modern growth of statistical theory of which this Symposium is a manifestation has been
> strongly oriented by a certain view as to the meaning of probability. I shall try to explain why another
> view seems now to be entering upon the scene almost of its own accord and to suggest what practical 
> implications it brings with it.

PDF download links at the [CiteSeerX page](https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.170.8812).

#### "The origins and legacy of Kolmogorov's Grundbegriffe"

by Glenn Shafer and Vladimir Vovk. _"A shorter version was published under the title "The sources of Kolmogorov's Grundbegriffe" in Statistical Science 21, 70 - 98 (2006)"_

> Abstract: April 25, 2003, marked the 100th anniversary of the birth of Andrei Nikolaevich Kolmogorov, the
> twentieth century's foremost contributor to the mathematical and philosophical foundations of probability. The year
> 2003 was also the 70th anniversary of the publication of Kolmogorov's _Grundbegriffe der Wahrscheinlichkeitsrechnung_.
> Kolmogorov's _Grundbegriffe_ put probability's modern mathematical formalism in place. It also provided a philosophy of
> probability - an explanation of how the formalism can be connected to the world of experience. In this article, we
> examine the sources of these two aspects of the _Grundbegriffe_ - the work of the earlier scholars whose ideas
> Kolmogorov synthesized. 

PDF download links at the [ArXiv](https://arxiv.org/abs/1802.06071)

### "Severe Testing as a Basic Concept in a Neyman-Pearson Philosophy of Induction"

by Deborah G. Mayo , Aris Spanos. BRITISH JOURNAL FOR THE PHILOSOPHY OF SCIENCE, 2006.

- [CiteSeerX](https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.130.8131)
- [PDF](https://www.phil.vt.edu/dmayo/personal_website/2006Mayo_Spanos_severe_testing.pdf)

There is a whole book by Deborah Mayo on this ([Reviews](https://statmodeling.stat.columbia.edu/2019/04/12/several-reviews-of-deborah-mayos-new-book-statistical-inference-as-severe-testing-how-to-get-beyond-the-statistics-wars/). This is promising!

