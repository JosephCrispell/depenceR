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
