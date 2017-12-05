library("httr")
library("dplyr")
library("plotly")
library("shiny")

shinyUI(fluidPage(
  
  p(titlePanel("FAQs")),
  
  br(),
  
  "Q: What are the average number of bedrooms in the houses priced over 1 million?",
  tableOutput("answer1"),
  
  br(),
  

  "Q: What are the average number of bathrooms in the houses priced over 1 million?",
  textOutput("answer2"),
  
  br(),
  
  "Q: What is the average price of the houses in the best condition?",
  tableOutput("answer3"),
  
  br(),
  
  "Q: What is the price of the house with the largest/smallest area (in sqft) including the basement? Choose one of the options below:",
  radioButtons("Area", 
               label =  "Area:", 
               choices= c("smallest area" = "min", "largest area" = "max"), 
               selected = "min",
               inline = TRUE
  ),
  textOutput("answer4"),
  
  br(),
  
  "Q: What is the average price of the houses with the selected grade? Select the grade below:",
  p(em("(Overall grade given to the housing unit, based on King County grading system. Range: 1-13)")),
  sliderInput("Grade",
              label = "Grade:",
              min = min(house.data$grade),
              max = max(house.data$grade),
              value = min(house.data$grade),
              step = 1,
              ticks = TRUE,
              animate = TRUE
    
  ),
  textOutput("answer5"),
  
  br(),
  
  "Q: What is average price of the houses with a waterfront view?",
  textOutput("answer6"),
  
  br(),
  
  "Q: What is the average price of the house in the selected zipcode? Select a zipcode below:",
  p(em("(Range of zipcodes: 98001-98199)")),
  numericInput("zipcode",
               label = "Zipcode: ",
               value = 98001,
               min = 98001,
               max = 98199,
               step = 1),
  textOutput("answer7")
))

