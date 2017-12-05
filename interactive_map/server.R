## Fran Dukic
## Group Project
## INFO201AF

library("shiny")
library('leaflet')
library('RColorBrewer')
library('scales')
library('lattice')
library('dplyr')
source(paste0(getwd(), "/ui.R"))

function(input, output, session) {
  
  ## Interactive Map #
  
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
      tags$strong(HTML(sprintf("%s, %s, %s",
                               selected$lat, selected$long, selected$zipcode
      ))), tags$br(),
      sprintf("Price: %s", selected$price), tags$br(),
      sprintf("Bedrooms: %s", selected$bedrooms), tags$br(),
      sprintf("Bathrooms: %s", selected$bathrooms)
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
}