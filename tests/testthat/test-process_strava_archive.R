test_that("User provided a valid file", {
  expect_error(process_strava_archive(), regexp='is missing, with no default')
})
