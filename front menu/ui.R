library(shiny)
library(shinythemes) 
shinyUI(navbarPage( theme = shinytheme("sandstone"),
                    
                    h4("House information system"),
                    
                    tabPanel(h6(""),  
                             sidebarLayout( 
                               
                               sidebarPanel( 
                                 helpText("Input information of houses"),
                                 sliderInput("s1", h3("price"),
                                             min = 75000, max = 7700000, value = 200000)
                                 ,
                                 sliderInput("s2", h3("number of bedrooms"),
                                             min = 0, max = 33, value = 2)
                                 ,
                                 sliderInput("s3", h3("number of bathrooms"),
                                             min = 0, max = 8, value = 1)
                                 ,
                                 sliderInput("s4", h3("sqft living"),
                                             min = 290, max = 13540, value = 1200)
                                 ,
                           submitButton(h4("Query"))
                               ),                                   
                            
                               mainPanel( 
                                 tabsetPanel( 
                                   tabPanel("Information", dataTableOutput("tab")),
                                   tabPanel("Map", plotOutput("fig"))
                                   
                               )
                             )               
                             
                             
                    )) 
                             
                             
                    
))