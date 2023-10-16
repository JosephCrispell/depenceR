test_that("can find R files", {
  expect_true("test-find_dependencies.R" %in% find_r_files())
})

test_that("can identify code lines", {
  file_lines <- c(
    "# my test file",
    "# is really great",
    "here <- 15",
    "some <- \"code\""
  )
  expect_equal(get_code_line_indices(file_lines), c(3, 4))

  file_lines <- c(
    "This file is a [markdown]() one with lots of `markdown` in it",
    "and",
    "some `r print(\"in line R code\")`",
    "```",
    "this <- 15",
    "great <- \"code\"",
    "```",
    "code blocks!"
  )
  expect_equal(get_code_line_indices(file_lines), c(5, 6))
})

test_that("can get package name", {
  file_line <- "library(\"dependenceR\")"
  expect_equal(get_package_name_from_library_line(file_line), "\"dependenceR\"")
})
