library("httr")
library("dplyr")
library("plotly")
library("shiny")

source("app.R")

house.data <- read.csv("house_data.csv")
house.data$total_area <- house.data$sqft_above + house.data$sqft_basement


shinyServer(function(input, output) {
  
  output$answer1 <- renderText(
    return(paste("A: Average number of bathrooms in houses priced over 1 million is ", bedrooms.average))
  )
  
  output$answer2 <- renderText(
    return(paste("A: Average number of bathrooms in houses priced over 1 million is ", bathrooms.average))
  )
  
  output$answer3 <- renderText(
    return(paste0("A: Average price of the houses in the best condition is $", best.condition.price))
  )
  
  areaAns <- reactive({
    if(input$Area == 'min') {
      return(toString(filter(house.data, total_area == min(total_area)) %>% 
                        select(price)))
    }else{
      return(toString(filter(house.data, total_area == max(total_area)) %>% 
                        select(price)))
    }
    
  })
  
  output$answer4 <- renderText(
    return(paste0("A: Price of the house is $", areaAns()))
  )
  
  
  gradeAns <-  reactive({
    ans <- input$Grade
    if(ans == 2){
      return("There are no houses with grade 2")
    }
    grade.price.average <- paste0("$", toString(round(filter(house.data, grade == ans) %>% 
                                                 summarise(mean = mean(price)))))
    
  })
  
  output$answer5 <- renderText(
    return(paste0("A: Average price of the houses with the selected grade: ", gradeAns()))
  )
  
  output$answer6 <- renderText(
    return(paste0("A: Average price of the houses with a waterfront: $", waterfront.price))
  )
  
  zipcodeAns <- reactive({
    ans <- input$zipcode
    zipcode.price.average <- paste0("$", toString(round(group_by(house.data, zipcode) %>% 
                                                         summarise(mean = mean(price)))))
  })
  
  output$answer7 <- renderText(
    return(paste0("A: Average price of the house in the selected zipcode: ", zipcodeAns()))
  )
})


