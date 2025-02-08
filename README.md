# Mapasaurus <a href="https://russell-shean.github.io/mapasaurus/"><img src="https://github.com/user-attachments/assets/3497de47-b248-4342-8cd7-2598d944b5ef" align="right" height="240" /></a>
Introducing the mapasaurus! An R package to process your gpx files and make beautiful maps and stuff. We just started on this package, so check back later for anything actually useful.    

<!-- badges: start -->


  [![R-CMD-check](https://github.com/Russell-Shean/mapasaurus/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Russell-Shean/mapasaurus/actions/workflows/R-CMD-check.yaml)
  [![Codecov test coverage](https://codecov.io/gh/Russell-Shean/mapasaurus/graph/badge.svg)](https://app.codecov.io/gh/Russell-Shean/mapasaurus)
<!-- badges: end -->

# Getting started
The package can be installed from Github using the following command:    
```r
remotes::install_github("Russell-Shean/mapasaurus")
```
The package currently includes a shiny app that allows you to upload a .gpx file and see a map of the route. To launch the app use the following code:    
```r
library(stravinator)
launch_route_explorer()
```



# Developer Notes   
To create the package and GitHub repo I followed these <a href="https://r-pkgs.org/whole-game.html">instructions</a>     
Hex sticker was made using Dall-E 3     
Shiny app was included in package using this structure: https://stackoverflow.com/a/49623819/16502170
