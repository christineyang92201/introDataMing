### R code from vignette source '1-R.Rnw'

###################################################
### code chunk number 1: 1-R.Rnw:19-20
###################################################
options(width=60)


###################################################
### code chunk number 2: fundamentals
###################################################
1+1 # basic addition
x <- 1 # assignment using `<-`
print(x) # print value of `x`
x # R automatically prints last value
x + 1 # addition again


###################################################
### code chunk number 3: fundamentals
###################################################
x <- c(x, 2, 3, 4:9) # build vectors using `c`
x
4:9 # use `i:j` for sequences from `i` to `j`
x[2] # select 2nd element
x[-2] # select all but 2nd element


###################################################
### code chunk number 4: atomics
###################################################
logical(1)
numeric(1)
character(1)
raw(1)
complex(1)


###################################################
### code chunk number 5: matrices1
###################################################
matrix(1:9, nrow=3, ncol=3) # make a 3x3 matrix
x <- 1:9 # or turn a 1d vector in a matrix...
dim(x) <- c(3,3) # ...by giving it dimensions
x


###################################################
### code chunk number 6: matrices2
###################################################
array(1:18, dim=c(3,3,2)) # make a 3x3x2 array


###################################################
### code chunk number 7: lists1
###################################################
y <- list(TRUE, 1, "a") # a heterogenous list
y


###################################################
### code chunk number 8: lists2
###################################################
list(list(1, "Two"), "One more thing.") # recursive list


###################################################
### code chunk number 9: dataframes1
###################################################
df <- data.frame(x=c(1,2), y=c("a","b")) # a data.frame
df # column `x` is numeric and column `y` is character


###################################################
### code chunk number 10: subsetting1
###################################################
x
x[1,c(1,2)]
x[c(1,2),] # blank indices means assume all indices


###################################################
### code chunk number 11: subsetting1
###################################################
df
df[1,c("x","y")] # using integer and character indices
df[[1]] # selecting a column by its index
df$x # selecting a column by name


###################################################
### code chunk number 12: functions1
###################################################
foo <- function(x) {
  x + 1 # functions return the value last evaluated
}
foo(2)
foo(4:9)


###################################################
### code chunk number 13: functions2
###################################################
do.fun <- function(x, f) {
  f(x) # functions can be passed to other functions
}
do.fun(2, foo)
do.fun(2, function(x) x + 1) # anonymously
(function(x) x + 1)(2) # an anonymous function
1 + 2 # when you do this...
`+`(1, 2) # ...R does this


###################################################
### code chunk number 14: dataset
###################################################
library(ggplot2)
class(diamonds) # diamonds is a data.frame
dim(diamonds) # 53940 observations and 10 columns
names(diamonds) # names of the columns


###################################################
### code chunk number 15: summary1
###################################################
summary(diamonds$carat) # for a quantitative variable
summary(diamonds$cut) # for a categorical variable
summary(diamonds[1:3]) # summarize first 3 variables


###################################################
### code chunk number 16: summary2
###################################################
fit <- lm(price ~ carat, data=diamonds) # fit a linear model
summary(fit) # summary works for many types of objects


###################################################
### code chunk number 17: cleaning1
###################################################
class(diamonds$carat) # quantitative
range(diamonds$carat)
class(diamonds$cut) # categorical
class(diamonds$depth) # quantitative
range(diamonds$depth)


###################################################
### code chunk number 18: cleaning2
###################################################
ranges <- list()
for ( name in names(diamonds) )
  if ( is.numeric(diamonds[[name]]) )
    ranges[[name]] <- range(diamonds[[name]])
ranges[1:4]


###################################################
### code chunk number 19: cleaning3
###################################################
check.ranges <- function(data) {
  ranges <- list()
  for ( name in names(data) )
    if ( is.numeric(data[[name]]) )
      ranges[[name]] <- range(data[[name]]) 
  ranges
}


###################################################
### code chunk number 20: cleaning4
###################################################
map <- function(data, fun) {
  out <- list()
  for ( i in seq_along(data) )
    out[[i]] <- fun(data[[i]])
  out
}


###################################################
### code chunk number 21: cleaning5
###################################################
quantitative <- sapply(diamonds, is.numeric)
ranges <- lapply(diamonds[quantitative], range)
ranges[1:4]


###################################################
### code chunk number 22: summary3
###################################################
tapply(diamonds$price, diamonds$cut, summary)


###################################################
### code chunk number 23: summary4
###################################################
sizes <- cut(diamonds$carat, breaks=quantile(diamonds$carat),
             include.lowest=TRUE, labels=paste0("Q", 1:4))
tapply(diamonds$price, sizes, summary)


###################################################
### code chunk number 24: missing1
###################################################
NA == NA # careful!! cannot use `==` with NAs
is.na(NA) # must use is.na
any(c(TRUE, TRUE, FALSE)) # check if any elements are TRUE
sapply(diamonds, function(x) any(is.na(x))) # no missing data


###################################################
### code chunk number 25: missing2
###################################################
set.seed(123)
price2 <- diamonds$price
index <- sample(seq_along(price2), 50)
price2[index] <- NA
any(is.na(price2)) # are there any missing values?
sum(is.na(price2)) # how many missing values? (coercion!)
price2[is.na(price2)] <- mean(price2, na.rm=TRUE) # impute
any(is.na(price2))


###################################################
### code chunk number 26: visualization1
###################################################
set.seed(123)
index <- sample(1:nrow(diamonds), 50) # try a subset first
diamonds2 <- diamonds[index,]


###################################################
### code chunk number 27: visualization2
###################################################
plot(price ~ carat, data=diamonds2, col="blue")


###################################################
### code chunk number 28: visualization3
###################################################
plot(price ~ color, data=diamonds2, col=rainbow(7))


###################################################
### code chunk number 29: visualization4
###################################################
plot(price ~ carat, data=diamonds, col="blue")


###################################################
### code chunk number 30: visualization5
###################################################
smoothScatter(diamonds$carat, diamonds$price)


###################################################
### code chunk number 31: visualization6
###################################################
plot(price ~ color, data=diamonds, col=rainbow(7))


###################################################
### code chunk number 32: visualization7
###################################################
size.color <- as.factor(paste0(sizes, diamonds$color))
plot(size.color, diamonds$price, col=rep(rainbow(7), 4))


