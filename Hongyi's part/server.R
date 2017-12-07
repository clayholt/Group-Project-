library(ggplot2)
library(ggmap)
library(data.table)
#load map
load("data/map.rdata")
data = read.csv("data/kc_house_data.csv")
shinyServer(function(input, output) {
  
  output$tab = renderDataTable(
    {
     
      
      if(as.integer(input$s1) == 1) {
        dt = subset(data, price < 1000000 & bedrooms == input$s2 & bathrooms == input$s3
                    & abs(sqft_living - input$s4) <= 1000)
      }
      
      if(as.integer(input$s1) == 2) {
        dt = subset(data, 1000000 <= price & price < 3000000 & bedrooms == input$s2 & bathrooms == input$s3
                    & abs(sqft_living - input$s4) <= 1000)
      }
      
      if(as.integer(input$s1) == 3) {
        dt = subset(data, 3000000 <= price & price < 5000000 & bedrooms == input$s2 & bathrooms == input$s3
                    & abs(sqft_living - input$s4) <= 1000)
      }
      
      if(as.integer(input$s1) == 4) {
        dt = subset(data, 5000000 <= price & price < 7000000 & bedrooms == input$s2 & bathrooms == input$s3
                    & abs(sqft_living - input$s4) <= 1000)
      }
      
      if(as.integer(input$s1) == 5) {
        dt = subset(data, price >= 7000000 & bedrooms == input$s2 & bathrooms == input$s3
                    & abs(sqft_living - input$s4) <= 1000)
      }
      dt
    }
  )
  
  output$fig = renderPlot(
    
    {
      if(as.integer(input$s1) == 1) {
        dt = subset(data, price < 1000000 & bedrooms == input$s2 & bathrooms == input$s3
                    & abs(sqft_living - input$s4) <= 1000)
      }
      
      if(as.integer(input$s1) == 2) {
        dt = subset(data, 1000000 <= price & price < 3000000 & bedrooms == input$s2 & bathrooms == input$s3
                    & abs(sqft_living - input$s4) <= 1000)
      }
      
      if(as.integer(input$s1) == 3) {
        dt = subset(data, 3000000 <= price & price < 5000000 & bedrooms == input$s2 & bathrooms == input$s3
                    & abs(sqft_living - input$s4) <= 1000)
      }
      
      if(as.integer(input$s1) == 4) {
        dt = subset(data, 5000000 <= price & price < 7000000 & bedrooms == input$s2 & bathrooms == input$s3
                    & abs(sqft_living - input$s4) <= 1000)
      }
      
      if(as.integer(input$s1) == 5) {
        dt = subset(data, price >= 7000000 & bedrooms == input$s2 & bathrooms == input$s3
                    & abs(sqft_living - input$s4) <= 1000)
      }
      
     p = ggmap(a)  + geom_point(data=dt,aes(x=long,y=lat, color = "darkorange", size = 2)) + theme(legend.position ="none")
     p
    }
   
    
  )



})



