# labelVector
Label Attributes for Atomic Vectors

[![Build Status](https://travis-ci.org/nutterb/labelVector.png?branch=master)](https://travis-ci.org/nutterb/labelVector)
![](http://cranlogs.r-pkg.org/badges/grand-total/labelVector)
[![Coverage Status](https://coveralls.io/repos/github/nutterb/labelVector/badge.svg?branch=master)](https://coveralls.io/github/nutterb/labelVector?branch=master)


Labels are a common construct in statistical software providing a human readable description of a variable. While variable names are succinct, quick to type, and follow a language's naming conventions, labels may  be more illustrative and may use plain text and spaces. 

R does not provide native support for labels. Some packages, however, have made this feature available.  Most notably, the `Hmisc` package provides labelling methods for a number of different object. Due to design decisions, these methods are not all exported, and so are unavailable for use in package development.  

The `labelVector` package supports labels for atomic vectors in a light-weight design that is suitable for use in other packages.

## Download

The package may be downloaded from CRAN using

    install.packages("labelVector")
    
or from GitHub using 

    devtools::install_github("nutterb/labelVector")

## Motivation 

When generating summaries for reports to be delivered to a non-technical audience, the variable names used in analytical code may not be adequately descriptive to the audience to provide the full context and meaning of the results.  Variable labels are a compromise that may be inserted to clarify meaning to the audience without requiring excessively difficult variable names to be used in code.

In the table below, a linear model estimating gas mileage is given with terms taken from the variable labels.

```r
library(labelVector)

mtcars <- 
  set_label(mtcars,
            qsec = "Quarter mile time",
            am = "Automatic / Manual",
            wt = "Vehicle weight")

fit <- lm(mpg ~ qsec + am + wt, 
          data = mtcars)

# Create a summary table
res <- as.data.frame(coef(summary(fit)), 
                     stringsAsFactors = FALSE)
res <- cbind(rownames(res), res)
rownames(res) <- NULL
names(res) <- c("term", "estimate", "se", "t", "p")
res$term <- as.character(res$term)

kable(res)
```

|term        |  estimate|        se|         t|         p|
|:-----------|---------:|---------:|---------:|---------:|
|(Intercept) |  9.617781| 6.9595930|  1.381946| 0.1779152|
|qsec        |  1.225886| 0.2886696|  4.246676| 0.0002162|
|am          |  2.935837| 1.4109045|  2.080819| 0.0467155|
|wt          | -3.916504| 0.7112016| -5.506882| 0.0000070|

In constrast, the following table replaces these term labels with longer, more human-readable terms that assist in the interpretation of the model.

```r
res$term[-1] <- get_label(mtcars, vars = res$term[-1])
kable(res)
```

|term               |  estimate|        se|         t|         p|
|:------------------|---------:|---------:|---------:|---------:|
|(Intercept)        |  9.617781| 6.9595930|  1.381946| 0.1779152|
|Quarter mile time  |  1.225886| 0.2886696|  4.246676| 0.0002162|
|Automatic / Manual |  2.935837| 1.4109045|  2.080819| 0.0467155|
|Vehicle weight     | -3.916504| 0.7112016| -5.506882| 0.0000070|

Truthfully, I don't believe it to be likely that these labels will be retrieved and applied to summaries interactively, but they do become useful when writing functions to generate common summary tables.

## Usage

Labels are easily set using the `set_label` function and retreived using the `get_label` function.

```r
x <- 1:10
x <- set_label(x, "some integers")

x

get_label(x)
```

Labels may also be assigned in a manner that is pipe-friendly.

```r
mtcars2 <- 
  set_label(mtcars,
            am = "Automatic",
            mpg = "Miles per gallon",
            cyl = "Cylinders",
            qsec = "Quarter mile time")
```

## Interaction with `Hmisc`

Whereas `labelVector` provides a similar functionality as is provided by the `Hmisc` package, and considering the widespread use of `Hmisc`, consideration is taken for the possibility that `labelVector` and `Hmisc` may need to work in the same environment. This is permissible since `set_label` and `get_label` both work on the `label` attribute of a vector and their names do not conflict with the `label` generic exported by `Hmisc`.
