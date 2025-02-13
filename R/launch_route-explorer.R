
#' Launch route explorer shiny
#'
#' @return A shiny app is launched
#' @export
#' 
#' @seealso https://stackoverflow.com/a/49623819/16502170
#' 
#'
#' @examples
#' \dontrun{
#' launch_route_explorer()
#' }
launch_route_explorer <- function() {
  appDir <- system.file("route-explorer-app", package = "mapasaurs")
  
  if (appDir == "") {
    stop("Could not find route-explorer-app. Try re-installing `mapasaurus`.", call. = FALSE)
  }
<<<<<<< HEAD
  # change max file upload size
  # before starting shiny
  # looks like 20 MB should be enough
  options(shiny.maxRequestSize = 20 * 1024^2)
=======
>>>>>>> 9f046ffc70c00ab7ec44543ed34478c6cd7bf102
  
  shiny::runApp(appDir, display.mode = "normal")
}
