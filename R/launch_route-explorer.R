
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
  appDir <- system.file("route-explorer-app", package = "stravinator")
  
  if (appDir == "") {
    stop("Could not find route-explorer-app. Try re-installing `stravinator`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}
