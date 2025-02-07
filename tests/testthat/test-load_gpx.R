test_that("User must provide arguments to load_gpx()", {
  expect_error(load_gpx(), regexp='argument "path" is missing, with no default')
})

