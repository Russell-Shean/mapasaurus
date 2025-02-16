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

ui <- fluidPage(
  
  # include CSS
  tags$link(rel = "stylesheet", type = "text/css", href = "css/styles.css"),
  

  titlePanel("Upload a gpx file to get started!"),
  gpx_upload_UI("gpxUploader"),
  activity_header_UI("gpxUploader"),
  summary_map_UI("gpxUploader"),
  activity_stats_table_UI("gpxUploader"),
  elevation_plot_UI("gpxUploader"),
  aknowledgements_UI("gpxUploader")
  
  
)
