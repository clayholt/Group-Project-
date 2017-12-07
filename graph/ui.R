library('shiny')
setwd("\Users\clayh")


dir <- paste0(getwd(), "/Users/clayh/InfoProject/Kaggledata/.csv")
house.data <- read.csv(dir)


fluidPage(
  titlePanel("House Pricing"),
  
  sidebarLayout(
    sidebarPanel(
      
      selectInput(inputId = "Details",
                  label = "Buyer Needs:",
                  choices = c("bedrooms", "bathrooms", "floors", "sqft_living"),
                  
                  
                  selected = "bedrooms"),
      
      mainPanel(
        plotOutput("HousePlot", width = "100%")
      )
    )
  )
)
