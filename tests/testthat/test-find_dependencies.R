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
  file_line <- "library(\"dependenceR\") # a comment"
  expect_equal(get_package_from_library_call(file_line), "dependenceR")

  file_line <- "a <- test(something::else(c, d), this::too())"
  expected_output <- data.frame(
    "package" = c("something", "this"),
    "function" = c("else", "too"),
    row.names = c("something::else", "this::too"),
    check.names = FALSE
  )
  expect_equal(
    get_package_func_from_call(file_line),
    expected_output
  )
})
