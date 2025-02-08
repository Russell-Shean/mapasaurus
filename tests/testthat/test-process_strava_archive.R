test_that("User provided a valid file", {
  expect_error(process_strava_archive(), regexp='make sure the file exists and is in the right location')
})
