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
   # fluidRow(column(12, tags$html(HTML("")))),
    fluidRow(column(12, htmlOutput(ns("activity_icon")), textOutput(ns("activity_start")))),
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
    
    activity_track_points <- reactive({
      req(input$gpx_file)
      
      activity_track_points <- st_read(input$gpx_file$datapath, layer = "track_points", quiet = TRUE)
      
      
    })
    
    # output$gpx_table <- renderDT({
    #  req(activity_tracks())
    # datatable(activity_tracks())
    #})
    
    output$activity_icon <- renderText({
      if(activity_tracks()$type == "hiking"){
        
        
        as.character("<image class='cycling-icon' src='images/hiking.png'>")
        # <a href="https://www.flaticon.com/free-icons/hiking" title="hiking icons">Hiking icons created by juicy_fish - Flaticon</a>
      
        } else if(activity_tracks()$type == "running"){
       

          as.character("<image class='cycling-icon' src='images/jogging.png'>")
       # https://www.flaticon.com/free-icons/jogging" title="jogging icons">Jogging icons created by Freepik - Flaticon</a>'
     
           } else if(activity_tracks()$type == "cycling"){
      
              # https://www.flaticon.com/free-icons/bicycle" title="bicycle icons">Bicycle icons created by Freepik - Flaticon</a>
               as.character("<image class='cycling-icon' src='images/bike.png'>")
             
      } else if(activity_tracks()$type == "walking"){

        as.character("<image class='cycling-icon' src='images/walk.png'>")
      }
     
      
    })
    
    
    output$activity_start <- renderText({ 
      
      req(activity_track_points())
      
      activity_track_points()$time |>
                                          lubridate::as_datetime() |>
                                          min() |> 
                                          format("%B %d, %Y at %H:%m %Z") })
    
    
    
  
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