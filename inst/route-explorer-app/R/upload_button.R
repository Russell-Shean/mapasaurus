# This is a shiny module for an upload button
# Chatgpt is spooky good 😳
# see also: https://chatgpt.com/c/67a7ace9-f6e8-8008-a3c7-2397147edb5e

# UI Module
gpxUploadUI <- function(id) {
  ns <- NS(id)
  tagList(
    fileInput(ns("gpx_file"), "Upload GPX File", 
              accept = c(".gpx")),
    #DTOutput(ns("gpx_table"))
    fluidRow(column(12, textOutput(ns("activity_title")))),
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
    
    activity_tracks <- reactive({
      req(input$gpx_file)
      
      # Read the GPX file using sf::st_read()
      activity_tracks <- st_read(input$gpx_file$datapath, layer = "tracks", quiet = TRUE)
      
    })
    
    # output$gpx_table <- renderDT({
    #  req(activity_tracks())
    # datatable(activity_tracks())
    #})
    
  
      output$activity_title <- renderText({
      
      req(activity_tracks())
      
      activity_tracks()$name
      
      
    })
    
    output$activity_map <- renderLeaflet({
      
      req(activity_tracks())
      
      activity_tracks() |> 
        leaflet() |> 
        addTiles() |>
        addPolylines(opacity = 1)
      
    })
    
    return(activity_tracks)  # Return the data for potential further use
  })
}