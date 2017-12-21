#' @name print.labelled
#' @title Print Method for Labelled Vectors
#'
#' @description Labelled vectors are printed with their label appearing above
#'   the content of the vector.
#'
#' @param x A vector inheriting class \code{labelled}
#' @param ... Additional arguments to pass to other methods.
#'
#' @export

print.labelled <- function(x, ...){
  cat(attr(x, "label"), "\n", sep = "")
  attr(x, "label") <- NULL
  class(x) <- class(x)[!class(x) %in% "labelled"]
  NextMethod("print")
}
