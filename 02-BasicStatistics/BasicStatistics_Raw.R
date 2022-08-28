# Script: BasicStatistics_Raw.R
# Author: Joshua L. Eubanks (joshua.eubanks@ucf.edu)
# Date: 28 Aug 2022

library(gt)
library(tidyverse)
library(gtsummary)
library(plotly)
library(readxl)
library(plotly)

sessionInfo()

grades <- c(78,79,80,81,82)
mean(grades)

median(grades)

getModes <- function(x) {
  ux <- unique(x)
  tab <- tabulate(match(x, ux))
  ux[tab == max(tab)]
}

getModes(grades)
grades <- rnorm(100,mean = 75, sd = 5 )
hist(grades)

var(starwars$height)

var(starwars$height, na.rm = TRUE)
sd(starwars$height, na.rm = TRUE)
IQR(starwars$height, na.rm = TRUE)
range(starwars$height, na.rm = TRUE)

boxplot(starwars$height)

hist(starwars$height, breaks = "fd")

summary(mtcars)

cor(mtcars$mpg, mtcars$hp)

plot(mtcars$hp, mtcars$mpg)

plot(mtcars$hp, mtcars$mpg,
     main = "Scatterplot of Horsepower and Miles Per Gallon",
     xlab = "Horsepower",
     ylab = "Miles Per Gallon")

Wealth1percent <- read_excel("../Data/Wealth1percent.xlsx",
                             col_types = c("date", "numeric","numeric"))

plot(Wealth1percent$quarter,Wealth1percent$Share, type = "l")
abline(lm(Share ~ quarter, data = Wealth1percent),lty = 2)

table(starwars$hair_color)

bins <- seq(10,34,by = 2)

mpg <- cut(mtcars$mpg,bins)

table(mpg)

n <- table(mtcars$gear)

barplot(n,xlab="Number of Gears")

stem(mtcars$hp, scale = 3)

hair <- table(starwars$hair_color)%>% 
  data.frame()

colnames(hair)[1] <- "Hair Color"

gt(hair)

bins <- seq(10,34,by = 2)

mpg <- cut(mtcars$mpg,bins)

table(mpg)%>%
  data.frame() %>% 
  gt()

mtcars%>% select(mpg, cyl,hp) %>% 
  tbl_summary(statistic = list(all_continuous() ~ c("{mean} ({sd})",
                                                    "{median} ({p25}, {p75})",
                                                    "{min}, {max}"),
                              all_categorical() ~ "{n} / {N} ({p}%)"),
              type = all_continuous() ~ "continuous2"
  )

ggplot(mtcars, aes(mpg))+ 
  geom_histogram(binwidth = 2,col = 'black', fill = 'darkblue', alpha = 0.75)+
  labs(title = 'Distribution of Miles Per Gallon', caption = "1974 Motor Trend US Magazine")+
  theme_bw()

plot_ly(x = ~mtcars$mpg, type = "histogram", alpha = 0.6) %>% 
  layout(title = 'Distribution of Miles Per Gallon',
         xaxis = list(title = 'Miles Per Gallon'),
         yaxis = list(title = 'Count'))


plot_ly(y = starwars$height, type = 'box', name = 'Height [cm]',text = starwars$name) %>% 
  layout(title = 'Distribution of Star Wars Character Heights')

reduced <- mtcars %>% 
  select(mpg, hp, wt,qsec,disp,drat)

corrplot(cor(reduced),
         type = "lower",
         order = "hclust", 
         tl.col = "black",
         tl.srt = 45,
         addCoef.col = "black",
         diag = FALSE)

ggplot(starwars,aes(height, mass))+
  geom_point(color = 'gray40')+
  theme_bw()+
  labs(title = "Relationship between Mass and Height of Star Wars Characters")

plot_ly(starwars, y = ~mass, x = ~height, type = 'scatter',text = ~name, mode = "markers")

ggplot(Wealth1percent, aes(quarter, Share))+
  geom_line(color = 'gray40',alpha = 0.75)+
  geom_smooth(method = "lm", se = F, color = 'darkblue', linetype = 'dashed')+
  theme_bw()+
  labs(title = "Share of Total Net Worth Held by the Top 1%",
       subtitle = 'from 1989-2022',
       x = "Date",
       y = "Share")

model <- lm(Share~quarter,Wealth1percent)
Trend <- predict(model,data = Wealth1percent$quarter)

plot_ly(Wealth1percent, x = ~quarter, y = ~Share, type = 'scatter', mode = 'lines', name = "Share") %>% 
add_trace(y = ~Trend, name = 'Trend', mode = 'lines')


####### To create pdfs

#     pdf_document:
#         toc: true
#          number_sections: true
# always_allow_html: true
