# Script: GettingStaRted_Raw.R
# Author: Joshua Eubanks
# Created: 19 Aug 2022

5 + 8

unlucky <- 5 + 8
lucky <- unlucky - 6 

abs(-3)
sqrt(lucky)

library(swirl)

mtcars

mtcars$hp
mtcars[,4]

mtcars[1,]
mtcars["Mazda RX4",]

mtcars$hp[1]
mtcars[1,4]

sqrt(mtcars$hp)

mtcars$sqrtHP <- sqrt(mtcars$hp)

getwd()

library(readxl)

Wealth1percent <- read_excel("../Data/Wealth1percent.xlsx",
                             col_types = c("date", "numeric","numeric"))

