# add libraries to shiny app
if(!require("pacman")){install.packages("pacman")}
pacman::p_load(dplyr,
               leaflet,
               lubridate,
               lutz,
               sf,
               shiny,
               tidygeocoder)



# change max file upload size
# before starting shiny
# looks like 20 MB should be enough
options(shiny.maxRequestSize = 20 * 1024^2)


# load Erik's elevation plot map
source("R/elevation_plotter.R")



ui <- fluidPage(
  
  # include CSS
  tags$link(rel = "stylesheet", type = "text/css", href = "css/styles.css"),
  

  #titlePanel("Upload a gpx file to get started!"),
  gpx_upload_UI("gpx_upload"),
  activity_header_UI("activity_header"),
  summary_map_UI("summary_map"),
  stats_table_UI("stats_table"),
  elevation_plot_UI("elevation_plot"),
  aknowledgements_UI("aknowledgements")
  

)
