# This is a shiny module for an upload button
# Chatgpt is spooky good 😳

# UI Module
gpxUploadUI <- function(id) {
  ns <- NS(id)
  tagList(
    fileInput(ns("gpx_file"), "Upload GPX File", 
              accept = c(".gpx")),
    #DTOutput(ns("gpx_table"))
    leafletOutput(ns("activity_map"), height = "500px")
  )
}


upload_button_Server <- function(id) {
  moduleServer(id, function(input, output, session) {
   sf::st_read(output$files)
  })
}



# Server Module
gpxUploadServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    gpx_data <- reactive({
      req(input$gpx_file)
      
      # Read the GPX file using sf::st_read()
      sf_data <- st_read(input$gpx_file$datapath, layer = "tracks", quiet = TRUE)
      
      return(sf_data)
    })
    
    # output$gpx_table <- renderDT({
    #  req(gpx_data())
    # datatable(gpx_data())
    #})
    
    output$activity_map <- renderLeaflet({
      
      req(gpx_data())
      
      gpx_data() |> 
        leaflet() |> 
        addTiles() |>
        addPolylines(opacity = 1)
      
    })
    
    return(gpx_data)  # Return the data for potential further use
  })
}