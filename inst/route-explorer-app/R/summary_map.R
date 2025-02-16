summary_map_UI <- function(id) {
  ns <- NS(id)
  tagList(
    
    fluidRow(column(12, leafletOutput(ns("summary_map"), height = "500px")))
  )
}


summary_map_server <- function(id, activity_tracks) {
  moduleServer(id, function(input, output, session) {
    
    
    
    output$summary_map <- renderLeaflet({
      
      req(activity_tracks())
      
      activity_tracks() |> 
        leaflet() |> 
        addTiles() |>
        addPolylines(opacity = 1)
      
    })
    
    
  })
}

