library("shiny")
source(paste0(getwd(), "/ui.R"))

function(input, output) {
  
  
  ii <- cut(house.data$rating, breaks = seq(min(house.data$rating), max(house.data$rating), len = 71), 
            include.lowest = TRUE)
  colors <- colorRampPalette(c("red", "lightred"))(69)[ii]
  
  
  output$housePlot <- renderPlot({
    
    if(input$price) {
      
      barplot (house.data[,input$price], 
               
               main=input$price,
               
               ylab="Price of House",
               
               xlab="House Characteristics", col=colors, names.arg=house.data$name, las=5)
    } else 
    {
      barplot(house.data[,input$Price], 
              main=input$content,
              ylab="Price of House",
              xlab="House Characteristics", names.arg = house.data$name, las = 4)
    }
    
  })
}
