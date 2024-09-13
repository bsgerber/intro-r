# Examples of lists

# First other objects to review

x <- 5

vec <- 1:5

mat <- matrix(1:9, nrow = 3)

df <- mtcars
class(mtcars)

# Let's make a list!
x <- list("a" = 2.5, "b" = TRUE, "c" = 1:3, "d" = c("A", "B", "C"))

str(x)

# How to extract data from list, note different structures returned [ and [[ and $

x$a
x$b

x[1]
x[2]

x[1:2]

x[c(TRUE, FALSE, TRUE, FALSE)]

x[c("a", "b")]

x["a"]
x[["a"]]

typeof(x["a"])
typeof(x[["a"]])

x[["c"]]
x["c"]

x

x[["a"]] <- 7
x["a"] <- 12
x$a <- 15

x$e <- "something else"
x[["f"]] <- 1:10
x[["g"]] <- LETTERS[1:5]

# How to remove element?
x[["f"]] <- NULL

# Access specific element within list
x[["g"]][5]
x$g[5]
x["g"][[1]][5]

# Example using list on multiple data.frames with lapply and map

df1 <- mtcars
df2 <- mtcars
df3 <- mtcars

df2$mpg <- df2$mpg * 1.2
df3$mpg <- df3$mpg * 0.8

library(broom)
library(gtsummary)

fit <- lm(mpg ~ hp + wt, data = mtcars)
tbl_regression(fit)
summary(fit)
tidy(fit)

Mylm <- function(df) {
  fit <- lm(mpg ~ hp + wt, data = df)
  tidy(fit) # tidy the fit object
}

lapply(
  list(df1, df2, df3),
  Mylm
)

library(purrr)

map_dfr(
  list("df1 set" = df1, "df2 set" = df2, "df3 set" = df3),
  Mylm,
  .id = "model"
)

# Use of unlist (named vector)
y <- unlist(x)
class(y)


