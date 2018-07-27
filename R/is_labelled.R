#' @name is_labelled
#' @title Evaluate if a vector is labelled
#' 
#' @description Functions to determine if a vector has a label.
#' 
#' @param x An atomic vector
#' 
#' @return 
#' Returns a \code{logical(1)}.
#' 
#' @section Functional Requirements:
#' \enumerate{
#'  \item Return a logical value of length 1.
#'  \item Cast an error if \code{x} is not atomic.
#' }
#' 
#' @export

is.labelled <- function(x){
  if (!is.atomic(x)){
    stop("'x' must be atomic")
  }
  inherits(x, "labelled")
}

#' @rdname is_labelled
#' @export

is_labelled <- is.labelled

