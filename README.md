
<!-- README.md is generated from README.Rmd. Please edit that file -->

# darklyplot

<!-- badges: start -->

<!-- badges: end -->

The goal of darklyplot is to create simple time series plots with a dark
background. The miniminum and maximum values are highlghted, and color
coded along with the y axis and x axis labels.

## Installation

You can install the development version of darklyplot from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lenkiefer/darklyplot")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(darklyplot)
darklyplot(mtg_rate,"rate",labelx="roundx",n.decimals=3)
```

<img src="man/figures/README-example-1.png" width="50%" />
