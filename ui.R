#main
library("httr")
library("dplyr")
library("plotly")
library("shiny")
library('leaflet')
library("shinythemes")


vars <- c(
  "Lot Size" = "sqft_lot15",
  "Living Space" = "sqft_living15",
  "Price" = "price"
)

shinyUI(fluidPage(theme = shinytheme("darkly"),
  
  navbarPage("Housing Sales in King County, WA", id="nav",
             
             ############## FAQ TAB ##################
             
             tabPanel("Frequently Asked Questions",
                      div(class="outer"),
                      
                      modalDialog(h3("Hey, what's your name?"),textInput("user", label = "",placeholder = 'Type here..'), title = NULL, footer = modalButton("Let me in"),
                                  size = "s", easyClose = FALSE, fade = TRUE),
                      p(h2(textOutput('user'))),
                      
                      br(),
                      
                      "Q: What are the average number of bedrooms in the houses priced over 1 million?",
                      textOutput("answer1"),
                      
                      br(),
                      br(),
                      
                      
                      "Q: What are the average number of bathrooms in the houses priced over 1 million?",
                      textOutput("answer2"),
                      
                      br(),
                      br(),
                      
                      "Q: What is the average price of the houses in the best condition?",
                      tableOutput("answer3"),
                      
                      br(),
                      br(),
                      
                      "Q: What is the price of the house with the largest/smallest area (in sqft) including the basement? Choose one of the options below:",
                      radioButtons("Area", 
                                   label =  "Area:", 
                                   choices = c("smallest area" = "min", "largest area" = "max"), 
                                   inline = TRUE
                      ),
                      textOutput("answer4"),
                      
                      br(),
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
                      br(),
                      
                      "Q: What is average price of the houses with a waterfront view?",
                      textOutput("answer6"),
                      
                      br(),
                      br(),
                      
                      "Q: What is the average price of the house in the selected zipcode? Select a zipcode below:",
                      p(em("(Range of zipcodes: 98001-98199)")),
                      numericInput("zipcode",
                                   label = "Zipcode: ",
                                   value = 98001,
                                   min = 98001,
                                   max = 98199,
                                   step = 1),
                      textOutput("answer7"),
                      
                      br(),
                      br(),
                      
                      "Q: Which area in King County (zipcode) has the highest priced houses?",
                      textOutput("answer8"),
                      
                      br()  
             ),
             
                      
             ########### INTERACTIVE MAP ###########
             
             tabPanel("Interactive map",
                      div(class="outer"),
                      
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("color", "Color of the markings based on:", vars),
                          selectInput("size", "Size of the markings based on:", vars, selected = "price"),
                          numericInput("bdrm", "Size of the markings based on number of bedrooms:", 1)
                        ),
                        mainPanel(
                          leafletOutput("map", width="100%", height="750"))
                        )
              ),
             
             conditionalPanel("false", icon("crosshair")),
             
             
             ############# GRAPH TAB ##############
             
             tabPanel("Interactive Graphs",
                      div(class="outer"),
                      
                      p(h3("The following graphs show a few factors that affect the pricing of the house:"),
                      
                        br(),
                      
                        p("The scatterplot below shows the correlation between total area of houses and the price of houses:"),
                      
                        p(plotlyOutput("graph1")),
                      
                        br(),
                      
                        p("While it could've been assumed that price would increase with the area of the house, the graph shows that price and area of the house have no correlation.
                          Let's dig into other factors which could affect the price of houses such as the grade given to the house, whether the house of has a waterfront view etc.")),
                        
                        br(),
                        
                        p("The scatterplot below shows the correlation between total area of houses and the grade of houses:"),
                        
                        p(plotlyOutput("graph2")),
                      
                        br(),
                        
                        p("This scatterplot clearly shows that the price of the houses increases with the grade of houses."),
                        
                        br(),
                        
                        p("The bargraph below shows the correlation between price of the house and the houses with and without a waterfront:"),
                      
                        plotlyOutput("graph3"),
                      
                        p("This graph shows that the houses with a waterfornt view have a higher average price.")
                      
                      
             )
             
             
             
              
             
)))
