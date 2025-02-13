# add libraries to shiny app
if(!require("pacman")){install.packages("pacman")}
pacman::p_load(dplyr,
               leaflet,
               sf,
               shiny)


<<<<<<< HEAD
# change max file upload size
# before starting shiny
# looks like 20 MB should be enough
options(shiny.maxRequestSize = 20 * 1024^2)
=======
>>>>>>> 9f046ffc70c00ab7ec44543ed34478c6cd7bf102

ui <- fluidPage(
  titlePanel("GPX File Upload"),
  gpxUploadUI("gpxUploader")
)
