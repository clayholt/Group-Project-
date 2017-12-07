#main
library("httr")
library("dplyr")
library("plotly")
library("shiny")
library('leaflet')
library('RColorBrewer')
library('scales')
library('lattice')
library('ggplot2')
library('ggmap')
library('data.table')

source("FAQ.R")
source("graph.R")




shinyServer(function(input, output, session) {
  
  house.data <- read.csv("data/house_data.csv")
  house.data$total_area <- house.data$sqft_above + house.data$sqft_basement
  
  
  output$user <- renderText({
    answer <- paste0("Hi " ,input$user , ", this application helps you get information on the houses on sale in the King County Area.
                     You will find some answers to the questions you might have through maps, graphs and more")
    return(answer)
  })
  
  
  ############################# FAQ TAB #############################

  
  # answer for question 1
  output$answer1 <- renderText(
    return(paste("A: Average number of bathrooms in houses priced over 1 million is ", bedrooms.average))
  )

  # answer for question 2
  output$answer2 <- renderText(
    return(paste("A: Average number of bathrooms in houses priced over 1 million is ", bathrooms.average))
  )

  # answer for question 3
  output$answer3 <- renderText(
    return(paste0("A: Average price of the houses in the best condition is $", best.condition.price))
  )

  # dynamic function for input from radio buttons
  areaAns <- reactive({
    if(input$Area == 'min') {
      return(toString(filter(house.data, total_area == min(total_area)) %>%
                        select(price)))
    }else{
      return(toString(filter(house.data, total_area == max(total_area)) %>%
                        select(price)))
    }

  })

  # answer for question 4
  output$answer4 <- renderText(
    return(paste0("A: Price of the house is $", areaAns()))
  )

  # dyanmic function for input from slider input
  gradeAns <-  reactive({
    ans <- input$Grade
    if(ans == 2){
      return("There are no houses with grade 2")
    }
    grade.price.average <- paste0("$", toString(round(filter(house.data, grade == ans) %>%
                                                 summarise(mean = mean(price)))))
    return(grade.price.average)
  })

  # answer for question 5
  output$answer5 <- renderText(
    return(paste0("A: Average price of the houses with the selected grade: ", gradeAns()))
  )

  # answer for question 6
  output$answer6 <- renderText(
    return(paste0("A: Average price of the houses with a waterfront: $", waterfront.price))
  )

  # dynamic method from input from numeric input
  zipcodeAns <- reactive({
    ans <- input$zipcode
    zipcode.price.average <- round(filter(house.data, zipcode == ans) %>%
      summarize(mean = mean(price)))
    if(is.nan(zipcode.price.average[1,1])) {
      return("There are no houses in this zipcode.")
    }
    return(paste0("$",zipcode.price.average))
  })

  # answer for question 7
  output$answer7 <- renderText(
    return(paste0("A: Average price of the house in the selected zipcode: ", zipcodeAns()))
  )

  # answer for question 8
  output$answer8 <- renderText(
    return(paste("A: The zipcode of the area with the highest average price of the houses: ", zipcode.highest.price))
  )

  ############################# INTERACTIVE MAP TAB #############################

  # Create the map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles(
        urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
        attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
      ) %>%
      setView(lng = -122.3321, lat = 47.6062, zoom = 10)
  })

  # Creates the circles and legend based on input by the user
  observe({
    colorBy <- input$color
    sizeBy <- input$size
    bedrm <- input$bdrm

    filtered <- house.data[house.data$bedrooms == bedrm,]

    colorData <- filtered[[colorBy]]
    pal <- colorBin("viridis", colorData, 7, pretty = FALSE)
    radius <- filtered[[sizeBy]] / max(filtered[sizeBy]) * 1000


    leafletProxy("map", data = filtered) %>%
      clearShapes() %>%
      addCircles(~long, ~lat, radius=radius, layerId=~id,
                 stroke=FALSE, fillOpacity=0.4, fillColor=pal(colorData)) %>%
      addLegend("bottomleft", pal=pal, values=colorData, title=colorBy,
                layerId="colorLegend")
  })

  # Show a popup at the given location
  popup <- function(id, lat, lng) {
    selected <- house.data[house.data$id == id,]
    content <- as.character(tagList(
      tags$h4("Grade:", as.integer(selected$grade)),
      tags$strong(HTML(paste0("(", sprintf("%s, %s",
                                           selected$lat, selected$long), ")" )
      )), tags$br(),
      sprintf("Zipcode: %s", selected$zipcode), tags$br(),
      sprintf("Price: $%s", selected$price), tags$br(),
      sprintf("Bedrooms: %s", selected$bedrooms), tags$br(),
      sprintf("Bathrooms: %s", selected$bathrooms),tags$br()
    ))
    leafletProxy("map") %>% addPopups(lng, lat, content, layerId = id)
  }

  # When map is clicked, show a popup with house info
  observe({
    leafletProxy("map") %>% clearPopups()
    event <- input$map_shape_click
    if (is.null(event))
      return()

    isolate({
      popup(event$id, event$lat, event$lng)
    })
  })
  
  ############################# GRAPH TAB #############################
  
  output$graph1 <- renderPlotly({
    g1 <- plot_ly(data = house.data, x = Area, y = Price1) %>% 
      layout(xaxis = x1 , yaxis = y1)
  }
  )
  
  output$graph2 <- renderPlotly({
    g2 <- plot_ly(data = house.data, x = Grade, y = Price2, xlab = "Grade of houses", ylab = "Price of houses") %>% 
      layout(xaxis = x2 , yaxis = y2)
  }
  )
  
  output$graph3 <- renderPlotly({
    g3 <- plot_ly(data = df1, x = ~Categories, y = ~AveragePrice) 
                      
  })
  
  
  
  
})

