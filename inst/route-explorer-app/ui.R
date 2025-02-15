# add libraries to shiny app
if(!require("pacman")){install.packages("pacman")}
pacman::p_load(dplyr,
               leaflet,
               lubridate,
               lutz,
               sf,
               shiny,
               tidygeocoder)

library(dplyr)
library(leaflet)
library(lubridate)
library(lutz)
library(sf)
library(shiny)
library(tidygeocoder)

# change max file upload size
# before starting shiny
# looks like 20 MB should be enough
options(shiny.maxRequestSize = 20 * 1024^2)

ui <- fluidPage(
  
  # include CSS
  tags$link(rel = "stylesheet", type = "text/css", href = "css/styles.css"),
  
  titlePanel("GPX File Upload"),
  gpxUploadUI("gpxUploader")
)
