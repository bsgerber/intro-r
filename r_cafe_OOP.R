# r_cafe_OOP.R

# S3 S4 R6 (S7 New! https://github.com/RConsortium/S7)
# S3 and S4 are base R, R6 is R6 package

# S3 - R’s original, informal OOP system;
# S4 - a more formal less flexible version of S3 (Bioconductor uses);
# RC - a reference class OOP system that more closely resembles the encapsulated object paradigm used in languages like C++ and Python.

# What is OOP? See figure
# https://www.geeksforgeeks.org/r-object-oriented-programming/

# Polymorphism (many shapes) - same interface but differing data types
# Encapsulation - combine data/attributes and methods into a unit

# https://bookdown.org/rdpeng/RProgDA/

# Think about a bus
# Bus is a class (blueprint) - how to make, knows what it can do, describes its parts
# Attributes are number seats, windows, top speed, mpg
# Methods are what it can do: open/close door, steer, accelerate or brake
# Inheritance "party bus" - additional attributes or methods, like fridge, window blinds

# Everything in R is an object
class(2)
class("hi there")
class(mtcars)
class(class)
class(lm)
class(as.data.frame)
class(`[`)
class(`+`)

# Say you have a model
mod <- lm(mpg ~ hp, data = mtcars)
plot(mtcars$mpg, mtcars$hp)
summary(mod)
class(mod)

# Sail the seas of OOP
sloop::otype(mtcars)
sloop::otype(mod)
sloop::s3_class(.5)

# Screw it up
class(mod) <- "character"
mod
summary(mod)

# How to make an object? Use a constructor
shape_s3 <- function(side_lengths){
  structure(
    list(side_lengths = side_lengths), 
    class = "shape_S3"
  )
}

# Make a square
square_4 <- shape_s3(c(4, 4, 4, 4))
class(square_4)
square_4
print(square_4)

# Make a triangle
triangle_3 <- shape_s3(c(3, 3, 3))
class(triangle_3)
triangle_3

# How to make an fancier object with a name? 
shape_s3 <- function(name, side_lengths){
  structure(
    list(name = name, side_lengths = side_lengths), 
    class = "shape_S3"
  )
}

# Make a square
square_4 <- shape_s3(name = "SQUARE", side_lengths = c(4, 4, 4, 4))
class(square_4)
square_4

# Look at model
mod <- lm(mpg ~ hp, data = mtcars)
str(mod)
mod$coefficients

# Make a generic class method that returns different stuff based on class
mean(c(2, 3, 7))
mean(c(as.Date("2024-11-14"), as.Date("2024-11-18")))

# How to make for our shape_s3 class?
is_square <- function(x) UseMethod("is_square")

# R searches for an S3 method based on the name of the generic function and the class of its first argument. 
# The specific function it looks for follows the naming pattern: generic.class.
# This is why it is advisable not to use dots when naming functions, classes, or other objects unless explicitly defining an S3 method.

is_square.shape_S3 <- function(x){
  length(x$side_lengths) == 4 && var(x$side_lengths) == 0
}

# Check it out
is_square(square_4)
is_square(triangle_3)

# Make another for matrix (is the matrix even rows and cols)
is_square.matrix <- function(x) {
  nrow(x) == ncol(x)
}

# Try it out
is_square(matrix(1:4, nrow = 2))
is_square(matrix(1:4, nrow = 1))

# What methods are there for different functions?
methods(is_square)
methods(print)
methods(summary)

# Will it work on our model?
is_square(mod)

# Make a default method
is_square.default <- function(x){
  "Oh no you don't!"
}

is_square(mod)
is_square(5)
is_square(c(1, 1, 1, 1))
is_square(square_4)

# Make a special print function
print.shape_S3 <- function(x) {
  if (length(x$side_lengths) == 4 && var(x$side_lengths) == 0) {
    paste("This is a square of length", x$side_lengths[1], "for each side")
  } else if (length(x$side_lengths) == 3) {
    paste("This is triangle. The perimeter is", sum(x$side_lengths))
  } else {
    "I don't know what this is."
  }
}

print(square_4)
print(triangle_3)
print(shape_s3("Ben", c(2, 3, 4, 5)))

methods(print)

# Others that we commonly use for different classes
methods(plot)
methods(mean)
methods(str)

# What's in the method for a print?
getAnywhere(print.lm)
getS3method('print', 'shape_S3')

# What if an object has multiple classes
# When an object has more than one class, R searches successively through the class attribute until a suitable method is found. 
# The sloop package and its function s3_dispatch() are helpful for understanding how this works.

mat <- matrix(1:9, nrow = 3)
class(mat)
class(mat) = c('green', class(mat))
class(mat)

# Find out what method is called
sloop::s3_dispatch(head(mat))
head(mat)
