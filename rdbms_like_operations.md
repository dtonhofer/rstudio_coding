# RDBMS-like operations

**TODO: Do this in SQL**

Inspired from a problem at StackOverflow: [Find mutual element in different facts in swi-prolog](https://stackoverflow.com/questions/60582295/find-mutual-element-in-different-facts-in-swi-prolog).

- We have data about actors appearing in movies.
- Given a list of movies, find those actors that appear in all of the movies of the list!

Seems clear-cut, the only question is, what actors appear in no movie at all? Is it _none_ or _all of them_?

After some fumbling:

````
# Load tidyverse dplyr

library(dplyr)

# Create a data frame ("tibble") with our raw data using `tribble`

t <- tribble(
        ~movie, ~actor
        ,"a"   , "bob"
        ,"c"   , "bob"
        ,"a"   , "maria"
        ,"b"   , "maria"
        ,"c"   , "maria"
        ,"a"   , "george"
        ,"b"   , "george"
        ,"c"   , "george"
        ,"d"   , "george")
````

Ok, now:

````
# The function!

actors_appearing_in_movies <- function(data, movies_must) {
   # (movie,actor) pairs of actors active in movies we are interested in 
   t1 <- data %>% filter(is.element(movie, movies_must))
   
   # (actor, (movies)) pairs of actors and the movies they appear in
   # for movies we are interested in 
   t2 <- t1 %>% group_by(actor) %>% summarize(movies = list(unique(movie)))   
   
   # Retain only those which appear in all movies
   t3 <- t2 %>% rowwise() %>% filter(setequal(movies_must,movies))
   
   # Select only the actor column
   # ("Select" works columnwise, not rowwise as in SQL)   
   t4 <- t3 %>% select(actor)
   
   return(t4)
}
````

Results?

The above approach is of the opinion that no actor appear in no movie at all. This is not wrong:

````
> actors_appearing_in_movies(t, c())
# A tibble: 0 x 1
# … with 1 variable: actor <chr>
````

More results:

````
> actors_appearing_in_movies(t, c("a"))

# A tibble: 3 x 1
  actor 
  <chr> 
1 bob   
2 george
3 maria 
````

````
> actors_appearing_in_movies(t, c("a","b"))

# A tibble: 2 x 1
  actor 
  <chr> 
1 george
2 maria 
````

````
> actors_appearing_in_movies(t, c("a","b","c"))

# A tibble: 2 x 1
  actor 
  <chr> 
1 george
2 maria 
````

````
> actors_appearing_in_movies(t, c("a","b","c","d"))

# A tibble: 1 x 1
  actor 
  <chr> 
1 george
````
