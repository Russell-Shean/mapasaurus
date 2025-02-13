
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
  # change max file upload size
  # before starting shiny
  # looks like 20 MB should be enough
  options(shiny.maxRequestSize = 20 * 1024^2)
  
  shiny::runApp(appDir, display.mode = "normal")
}
