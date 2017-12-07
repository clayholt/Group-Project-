library("dplyr")

# average number of bedrooms in the houses priced over 1 million
bedrooms.average <- toString(round(filter(house.data, price > 1000000) %>% 
                                     summarise(mean = mean(bedrooms))))

# average number of bathrooms in the houses with 3 or more bedrooms
bathrooms.average <- toString(round(filter(house.data, bedrooms >= 3) %>% 
                                      summarise(mean = mean(bathrooms))))

# average price of the houses in the best condition
best.condition.price <- toString(round(filter(house.data, condition == max(condition)) %>% 
                                         summarise(mean = mean(price))))

# price of the house with max/min total area
specific.price <- toString(filter(house.data, total_area == max(total_area)) %>% 
                             select(price))

# average price of th houses with a watefront
waterfront.price <-  toString(round(filter(house.data, waterfront ==1) %>% 
                                      summarise(mean = mean(price))))

# average price of the houses in every zipcode
zipcode.price <- group_by(house.data, zipcode) %>% 
  summarise(mean = mean(price))

# zipcode of the area with the highest priced houses on an average
zipcode.highest.price <- toString(filter(zipcode.price, mean == max(mean)) %>% 
                                    select(zipcode))
