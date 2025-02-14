# This is a shiny module for an upload button
# Chatgpt is spooky good 😳
# see also: https://chatgpt.com/c/67a7ace9-f6e8-8008-a3c7-2397147edb5e

# load Erik's elevation plot map
source("R/elevation_plotter.R")


# UI Module
gpxUploadUI <- function(id) {
  ns <- NS(id)
  tagList(
    fileInput(ns("gpx_file"), "Upload GPX File", 
              accept = c(".gpx")),
    #DTOutput(ns("gpx_table"))
   # fluidRow(column(12, tags$html(HTML("")))),
    fluidRow(column(12, htmlOutput(ns("activity_icon")), 
                    textOutput(ns("activity_start")),
                    textOutput(ns("activity_location")))),
    fluidRow(column(12, textOutput(ns("activity_title")))),
   fluidRow(column(12, leafletOutput(ns("activity_map"), height = "500px"))),
   fluidRow(column(12,tableOutput(ns("activity_stats_table")))),
  fluidRow(column(12, plotOutput(ns("elevation_plot"), height = "500px"))),
   fluidRow(column(12, htmlOutput(ns("tnx_Erik"))))
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
      
      activity_track_points <- st_read(input$gpx_file$datapath, 
                                       layer = "track_points", 
                                       quiet = TRUE) |>
        mutate(ele_diff = ele - lag(ele),
               time_diff = difftime(time, lag(time)),
               lead = geometry[row_number() + 1],
               dist = st_distance(geometry, lead, by_element = TRUE)
        )
      
      
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
      
      start_time <- activity_track_points()$time |>
                                          lubridate::as_datetime() |>
                                          min()  |> 
        lubridate::force_tz(tzone = lutz::tz_lookup(activity_track_points()[1,], 
                                   method = "fast")) |>
                                          format("%B %d, %Y at %H:%m %Z") })
    
    
    
  
      output$activity_title <- renderText({
      
      req(activity_tracks())
      
      activity_tracks()$name
      
      
    })
      
      
      output$activity_location <- renderText({
        
        req(activity_track_points())
        
        
        
        rev_geo_location <- tidygeocoder::reverse_geocode(as_tibble(st_coordinates(activity_track_points()))[1,],
                                                          lat = Y, 
                                                          long = X, 
                                                          full_results = TRUE ) %>%
          
          # Set default locations in case a location isn't returned
          # or we don't find the columns we expect
          mutate(location1 = "",
                 location2 = "",
                 location3 = "") %>%
          
          # look for different spatial units in order of preference
          # for some reason these if( city %in% columnnames(.)) things don't work with new pipes)
          mutate( location1 = if("suburb" %in% colnames(.) &
                                 country %in% c("臺灣","Taiwan")){
            suburb
          }else if("city" %in% colnames(.)){
            city
          } else if("town" %in% colnames(.)){
            town
          } else if("hamlet" %in% colnames(.)){
            hamlet
          } else if("county" %in% colnames(.)){
            county 
          } else {
            location1
          },
          location2 = if("state" %in% colnames(.)){
            state
          } else if("province" %in% colnames(.)){
            province
            
          } else if("county" %in% colnames(.)){
            county
          } else if("city" %in% colnames(.)){
            city
          }else{
            location2
          },
          location3 = if("country" %in% colnames(.)){
            country
          } else{
            location3
          }) |>
          mutate(formated_location = paste(location1, 
                                           location2, 
                                           location3,
                                           sep=", ") %>% 
                   # remove any weird commas
                   stringr::str_remove_all("^, |, ,") ) 
        
        
        rev_geo_location |> pull(formated_location)
        
        
      })
    
    output$activity_map <- renderLeaflet({
      
      req(activity_tracks())
      
      activity_tracks() |> 
        leaflet() |> 
        addTiles() |>
        addPolylines(opacity = 1)
      
    })
    
    output$activity_stats_table <- renderTable({
      
      req(activity_tracks())
      req(activity_track_points())
      
      # distance calculations ---------------------------------------------
      distance <-  activity_tracks() |>
                    st_length()  |> 
        as.numeric() * 0.0006213712
      
      distance <- distance  |> round(digits = 2)
      
      # elevation calculations -----------------------------------
      elevation_gain <- activity_track_points() |>
                  dplyr::filter(ele_diff > 0)|>
                  dplyr::pull(ele_diff) |>
                  sum(na.rm = TRUE) * 3.280839895
      
      elevation_gain <- elevation_gain |> round()
      
      stats_table <- data.frame(Distance = paste(distance, "miles"),
                                `Elevation Gain` = paste(elevation_gain, "feet"))
      
      stats_table
      
    })
    
    output$elevation_plot <- renderPlot({
      req(input$gpx_file)
      
      # modified from: https://shiny.posit.co/r/articles/build/images/
      
      # create a temporary file path
   #   temp_dir <- tempdir()
  #    outfile <- paste0(temp_dir, '/elevation_plot.png')
    
      # run the function to generate a png that we'll return to the user
     # elevationprofile(filepath = input$gpx_file$datapath,
      #                 plotsave = TRUE,
       #                plotsavedir = temp_dir,
        #              plotname = "elevation_plot")
      
      elevationprofile(input$gpx_file$datapath )
      
      
      
      # Generate the PNG
     # png(outfile, width = 400, height = 300)
      
    #  dev.off()
      
      # Return a list containing the filename
      #list(src = outfile,
       #    contentType = "image/png",
          # width = 400,
           #height = 400 / 2.4,
        #   alt = "Elevation plot")
    } #, deleteFile = TRUE
    )
        

   # as.character(paste0('<image src=">',
    #                    temp_dir,
     #                   '/elevation_plot.png"'))
      
      #as.character("<p>text place holder</p>")
    
    output$tnx_Erik <- renderText({
      
      req(input$gpx_file)
      
      as.character("<span>Thanks to Erik de Jong for his super cool <a href='https://github.com/EPdeJ/cyclingplots'>elevation plot</a> function!</span>")
    })
      

    
    return(activity_tracks)  # Return the data for potential further use
  })
}