# Making a great reproducible example in R
# A great way to get help in R is on Stackoverflow

# https://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example
# https://stackoverflow.com/help/minimal-reproducible-example

# Provide a minimal dataset, or use a "toy" data set

dput(iris)

# Or subset

dput(iris[1:4,])
dput(head(iris))

# set.seed if using randomization

set.seed(42)
rnorm(5)

# include packages

sessionInfo()

# reprex
# https://github.com/tidyverse/reprex

# install.packages("reprex")

library(reprex)

(y <- 1:4)
mean(y)

# Try Addins --> Reprex selection

# Avoid screenshots!

# Show errors

# Try debugging

print("hi")
my_fun <- function(x) {
  z <- 5
  no_fun(x)
  return("all done!")
}

my_fun(5)

# traceback()

# with browser()

my_fun <- function(x) {
  browser()
  z <- 5
  no_fun(x)
  return("all done!")
}

my_fun(5)

# setting breakpoint (see r_breakpoint.R example)




