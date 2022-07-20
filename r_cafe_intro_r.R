# R Cafe introduction to R

# The following uses RStudio
# This requires downloads of both RStudio and R
# You can get them here:
# RStudio: https://www.rstudio.com/products/rstudio/download/
# R: https://cran.r-project.org/mirrors.html

# Orientation to RStudio - there are 4 window panes:
# 1 Console (bottom left): type commands, see output
# 2 Top right: environment tab for objects we are working with, and history tab for what you've done so far
# 3 Bottom right: Files in your workspace, folder directory, plots, packages, help tabs
# 4 Top left: R scripts for record of your work, like do-file in Stata, syntax SAS program

# Go to console, there should be a prompt ">" awaiting your command
# Try the following:

2+2
print("hi")

# You can do logical comparisons, that R will evaluate
# Try the following:

4>2
17<11
2==4
3==3

# Note the double equals used when comparing to see if equal

2 != 1

# Let's create a new project...
# File > New Project > Existing directory > Browse button > Create project
# This folder will have all your project stuff (data, scripts, plots, information) - it's good to be organized with folders!

# Now create a new R file script. File > New File > R or the plus sign button top left, select "R Script"
# You have an untitled document you can save as part of your project

# Add something descriptive at the top, make a comment with pound sign

# My painless introduction
# Ben Gerber
# July X, 2022

# Notice after you add comments, the "Untitled" document is red with an asterisk * - it has changed and not saved
# Feel free to take a moment to save File > Save or File > Save as... (or disk icon button)

# Everything that exists is an object.
# Everything that happens is a function call

# Let's make an object and store something in it, then check what's in the object
# Arrow or equals will "assign" an object to something

x <- 5
x

y <- 2 + 2
y

z = 3 / 4
z

# It's case sensitive so watch out!

Y

# Check out "Environment" in the top right window pane, you can see the objects you created so far...

# Let's make another object, this one a "vector" that contains multiple numbers or characters
# Characters are alphanumeric (either number of letter), numeric is strictly numbers, and you can't mix them
# Colon makes range of values with shorthand

1:5

# c means combine values, it's a function, and "does something" - if you want to know what a function does,
# try ?c or help(c) and check then help tab in the bottom right window

c(2,4,6)

c("john", "sue", "nancy")

?c

# You can't mix them, if you try they all become character and have quotes around them

c("john", 3, "nancy")

# You can make a "logical" vector of TRUE and FALSE

c(TRUE, FALSE, T, T, F)

# And there's other shorthand available like with rep (replicate) function

rep(1:5, times = 3)

# Many functions in R are vectorized, so it will do a function on each value in a vector, for example

x <- 3:7
x
x * 2

# You can extract from a vector based on position using left bracket
# Actually the left bracket is a function that does something, it extracts [
# Try ?`[` 

x[3] # The third value is 5
x[2:4] # The second through fourth values are 4,5,6
x[-4] # Minus sign means omit, this gives all but fourth value
x[c(T, F, T, F, T)] # Logical vector inside brackets indicates which values to keep and output

# More often we deal with a data set in a data.frame
# R comes with example data frames, like mtcars

mtcars

# You can see it's a data frame

class(mtcars)

# If you want to see the structure of the data frame, use str

str(mtcars)

# You will see 32 observations (or different cars), and 11 variables, such as miles per gallon, horsepower, weight, cylinders

# Doing basic statistics is easy

mean(mtcars$mpg)
min(mtcars$cyl)

# You can summarize all at once

summary(mtcars)

# This includes 1st and 3rd quartiles, min, max, mean, and median

# How do you subset data, selecting specific rows of data?

# For example, selecting the second row, 4th variable/column would be:
# [row, column]

mtcars[2, 4]

# If you leave column empty, you get all columns:

mtcars[2, ]

# If you leave row empty, you get all rows for a specific column:

mtcars[ , 4]

# You can also use dollar sign $ to select the same column:

mtcars$hp

# If you want to evaluate which cars have high hp > 200, you can do:

mtcars$hp > 200

# which gives lots of TRUE/FALSE...you can then use to subset data
# where only the rows where hp > 200 is TRUE are included in output

mtcars[mtcars$hp > 200, ]

# You can also mix this with "assign" with arrow <- we did earlier and replace the high hp with 0

mtcars[mtcars$hp > 200, "hp"] <- 0
mtcars

# Don't worry about messing up mtcars, if you clear workspace in R Studio mtcars will go back to what it was

# There is "AND" & and "OR" |

mtcars[mtcars$mpg > 30 & mtcars$hp < 100, ]

# Let's look at the iris dataset that has categorical data if there's time...!

iris
iris[1:6, ]
head(iris) # Gets specific number of rows at beginning, default is 6

summary(iris)

# Note Species, there are 50 of each kind

table(iris$Species) # This will also give you number of each species

# Let's end with a cool plot with iris!

plot(iris$Petal.Length, iris$Petal.Width, col = iris$Species)

# Or

plot(Petal.Length ~ Petal.Width, iris, col = Species)

# Make sure to save your work!