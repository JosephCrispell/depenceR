#' Get all R (.R or .Rmd) files in directory
#'
#' @param directory directory to search in. Defaults to "."
#'
#' @return vector of all the file paths (relative to directory)
#' @export
#'
#' @examples
#' find_r_files()
find_r_files <- function(directory = ".") {
  all_r_files <- list.files(pattern = ".r$|.R$|.Rmd", recursive = TRUE)

  return(all_r_files)
}

#' Returns indices of lines with R code in them (from vector of file lines)
#'
#' Useful for identifying comment lines and code block lines (in .Rmd) files
#' @param file_lines vector of file lines (from readLines())
#'
#' @return vector line indices for lines containing R code
#' @export
#'
#' @examples
#' file_lines <- c(
#'   "# my test file",
#'   "# is really great",
#'   "here <- 15",
#'   "some <- \"code\""
#' )
#' get_code_line_indices(file_lines) # 3,4
get_code_line_indices <- function(file_lines) {
  # Create vector of all line numbers
  line_numbers <- seq_along(file_lines)

  # Note indices of comment lines and remove
  comment_lines <- grep("^#", file_lines)
  line_numbers <- line_numbers[line_numbers %in% comment_lines == FALSE]

  # Find code block markers (.Rmd files)
  code_block_markers <- grep("^```", file_lines)

  # Not indices of lines inside code blocks (if code blocks present)
  if (length(code_block_markers) > 1) {
    # Get indices of code lines
    code_line_numbers <- sapply(
      seq_along(code_block_markers)[-1],
      FUN = function(index, code_block_markers) {
        start_index <- code_block_markers[index - 1] + 1
        end_index <- code_block_markers[index] - 1
        return(start_index:end_index)
      },
      code_block_markers
    )

    # Remove indices of lines outside code blocks
    line_numbers <- line_numbers[line_numbers %in% code_line_numbers]
  }

  return(line_numbers)
}

#' Get package name from line with library call
#'
#' @param line file line as text string
#'
#' @return string representing package name
#'
#' @examples
#' file_line <- "library(\"dependenceR\")"
#' get_package_name_from_library_line(file_line) # "dependenceR"
get_package_from_library_call <- function(file_line) {
  # Split the line by brackets
  line_parts <- unlist(strsplit(file_line, split = "\\(\"|\"\\)"))

  # Find part with library
  library_index <- grep(pattern = "library", line_parts)

  # Get package name
  package_name <- line_parts[library_index + 1]

  return(package_name)
}

find_functions_and_packages <- function(file_path) {
  # Get the file lines
  file_lines <- readLines(file_path)

  # Note indices of code lines
  code_line_indices <- get_code_line_indices(file_lines)

  # Get indices of lines with library calls
  library_line_indices <- code_line_indices[
    grepl("^library(.+)", file_lines[code_line_indices])
  ]

  # Get indices of lines with direct package references
  package_call_line_indices <- code_line_indices[
    grepl("\\w+::", file_lines[code_line_indices])
  ]

  # Get indices of lines with function definitions
  # Note this ignores functions defined directly in apply statements
  function_def_line_indices <- code_line_indices[
    # \\s* means 0 or multiple white spaces
    grepl("<-\\s*function\\s*\\(", file_lines[code_line_indices])
  ]

  # Get indices of lines with function calls
  function_call_line_indices <- code_line_indices[
    # \\w+ - one or more word characters (letters, digits, and under-scores)
    # \\s* means 0 or multiple white spaces
    grepl("\\w+\\s*\\(", file_lines[code_line_indices])
  ]

  # Get indices of closing curly brackets
  closing_bracket_indices <- code_line_indices[
    grepl("}", file_lines[code_line_indices])
  ]

  # TODO consider how to map functions called within another function
  #   TODO identify closing function def brackets, find closed function def
  #        to define where function starts/ends
  #   TODO check if any functions called fall in function def brackets
  #   TODO assign source to function if they do, or file/package otherwise

  # Just for lintr :-D
  return(
    c(
      library_line_indices, package_call_line_indices,
      function_def_line_indices,
      function_call_line_indices, closing_bracket_indices
    )
  )
}
