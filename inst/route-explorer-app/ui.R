# add libraries to shiny app
if(!require("pacman")){install.packages("pacman")}
pacman::p_load(dplyr,
               leaflet,
               sf,
               shiny)



ui <- fluidPage(
  titlePanel("GPX File Upload"),
  gpxUploadUI("gpxUploader")
)
