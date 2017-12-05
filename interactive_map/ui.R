## Fran Dukic
## Group Project
## INFO201AF

library('shiny')
library('leaflet')
dir <- paste0(getwd(), "/Group-Project-/house_data.csv")
house.data <- read.csv(dir)

library(leaflet)

# Choices for drop-downs
vars <- c(
  "Lot Size" = "sqft_lot15",
  "Living Space" = "sqft_living15",
  "Price" = "price"
)


navbarPage("Housing Sales in King County, WA", id="nav",
           tabPanel("Interactive map",
                    div(class="outer"
                    ),
                    
                    leafletOutput("map", width="100%", height="800"),
                    
                    absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                  draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                  width = 330, height = "auto",
                                  
                                  h2("House Explorer"),
                                  
                                  selectInput("color", "Color", vars),
                                  selectInput("size", "Size", vars, selected = "price"),
                                  numericInput("bdrm", "Number of Bedrooms", 1)
                    )
                    
                    
           ),
           
           conditionalPanel("false", icon("crosshair"))
)
