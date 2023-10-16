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
