
#' Unzip a Strava archive and return a dataframe of activities
#' 
#' @description
#' This function unzips a strava archive stored in a zip file. 
#' The zip file is loaded from the path at `zip_file_path`. 
#' The  unzipped file are stored in `outdir`. If outdir doesn't already exist, it will be created. Multiple folders can be created recursively. 
#' The function returns a dataframe summarizing the activities stored in the archive. 
#' See Strava's guide to downloading your archive: https://support.strava.com/hc/en-us/articles/216918437-Exporting-your-Data-and-Bulk-Export#h_01GG58HC4F1BGQ9PQZZVANN6WF
#' 
#' Note: Use this function for bulk downloads not individual activities!
#'
#' @param zip_file_path A single character vector. It should be the path to where the archive is stored on your computer 
#' @param outdir A single character vector. 
#'               This should be the file path of the folder where you want to store the unzipped files. Defaults to the current working directory.
#'
#' @return A dataframe of activities
#' @export
#'
#' @examples
#' \dontrun{
#' # Return a dataframe of activies
#' activities_df <- process_strava_archive(zip_file_path = "export_1111111.zip", 
#'                                         outdir = "./data")
#' 
#' # unzip the archive without creating a dataframe of activies
#' # return files to the current working directory
#' 
#' process_strava_archive(
#'         zip_file_path = "export_1111111.zip")
#'         }
#' 
process_strava_archive <- function(zip_file_path, outdir = getwd()){
  
  # check to make sure zip file exists
  if(!file.exists(zip_file_path)){
    stop(paste0("Couldn't find ",
                zip_file_path,
                " make sure the file exists and is in the right location!"))
    }
 
  # create the output directory if it doesn't already exist
  if(!dir.exists(outdir)){
    dir.create(outdir, recursive = TRUE)
  }
  
  # unzip file and move content into output directory
  utils::unzip(zipfile = zip_file_path, exdir = outdir) 
  
  # load activities csv from output directory
  activities_path <- file.path(outdir, "activities.csv")
  if(!file.exists(activities_path)){
    stop(paste0("Couldn't find ",
                activities_path,
                ". This might mean ", 
                zip_file_path,
                " is not a zip file downloaded from strava. Please double check you provided the right path!"))
  }
  
  
  activities_df <- utils::read.csv(file = activities_path)
  
  return(activities_df)
  

}

