test_that("can find R files", {
  expect_true("test-find_dependencies.R" %in% find_r_files())
})
