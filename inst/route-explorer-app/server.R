server <- function(input, output, session) {
  gpx_file <- gpx_upload_server("gpx_upload")
  activity_tracks <- tracks_server("tracks_process", gpx_file)
  activity_track_points <- track_points_server("track_points_process", gpx_file)
  activity_header_server("activity_header", activity_tracks, activity_track_points)
  summary_map_server("summary_map", activity_tracks)
  stats_table_server("stats_table", activity_tracks, activity_track_points)
  elevation_plot_server("elevation_plot", gpx_file)
  aknowledgements_server("aknowledgements", gpx_file)
  
  
}
