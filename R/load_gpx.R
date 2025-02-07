#' Title
#'
#' @description
#' This function allows you to vectorise multiple [switch()] statements. Each
#' case is evaluated sequentially and the first match for each element
#' determines the corresponding value in the output vector. If no cases match,
#' the `.default` is used.
#'
#' @param path A character vector with one element. This should be the path to a locally stored gpx file.
#'
#' @return A dataframe
#' @export
#'
#' @examples   

load_gpx <- function(path){
  
  gpx <- sf::st_read(path,layer="track_points") 
  
  return(gpx)
  
}