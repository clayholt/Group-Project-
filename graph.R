library("dplyr")
library("stringr")
library("knitr")
library("ggplot2")

house.data <- read.csv("data/house_data.csv")

# scatter plot for total area of the house vs. price of the house

Area <- house.data$total_area
Price1 <- house.data$price

x1 <- list(title = "Area")
y1 <- list(title = "Price")

# scatter plot for grade of the house vs. price of the house

Grade <- house.data$grade
Price2 <- house.data$price

x2 <- list(title = "Grade")
y2 <- list(title = "Price")

# bargraph for houses with/without waterfront vs. average price

houses.with.waterfront <-  filter(house.data, waterfront == 1) %>% 
  summarise(mean = mean(price)) 

houses.without.waterfront <- filter(house.data, waterfront == 0) %>% 
  summarise(mean = mean(price)) 

Categories <- c("Houses with waterfront", "Houses without waterfront")
AveragePrice <- c(houses.with.waterfront[1,1], houses.without.waterfront[1,1])

df1 <- data.frame(Categories, AveragePrice)


