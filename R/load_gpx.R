#' Load a .gpx file from disk
#'
#' @description
#' This function loads a locally stored .gpx file using the track_points layer 
#' and returns a simple features (sf) data frame
#' 
#'
#' @param path A character vector with one element. This should be the path to a locally stored gpx file.
#'
#' @return A dataframe
#' @export
#'
#' @examples
#'activity1 <- load_gpx("C:/Users/your user name/activities/activity1.gpx")

load_gpx <- function(path){
  
  gpx <- sf::st_read(path,layer="track_points") 
  
  return(gpx)
  
}