library(ggplot2)
library(ggmap)
library(data.table)
#load map
load("data/map.rdata")
data = read.csv("data/kc_house_data.csv")
shinyServer(function(input, output) {
  
  output$tab = renderDataTable(
    {
      dt = subset(data, abs(price -  input$s1) <= 10000 & bedrooms == input$s2 & bathrooms == input$s3
                  & abs(sqft_living - input$s4) <= 1000)
      dt
    }
  )
  
  output$fig = renderPlot(
    
    {
     dt = subset(data, abs(price -  input$s1) <= 10000 & bedrooms == input$s2 & bathrooms == input$s3
                  & abs(sqft_living - input$s4) <= 1000)
     p = ggmap(a)  + geom_point(data=dt,aes(x=long,y=lat, color = "darkorange", size = 2)) + theme(legend.position ="none")
     p
    }
   
    
  )



})



