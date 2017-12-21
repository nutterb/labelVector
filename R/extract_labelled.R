#' @name extract_labelled
#' @title Extract or Replace Parts of Labelled Vectors
#' 
#' @description Extraction and replacement methods for labelled vectors.
#' 
#' @param x An atomic vector inheriting the \code{labelled} class.
#' @param i The elements to extract.
#' @param value typically a vector of similar class of length \code{i}
#' 
#' @seealso \code{\link{Extract}}
#' 
#' @examples 
#' 
#' x <- set_label(1:10, "Integers")
#' x[1:3]
#' 
#' x[3] <- pi
#' x
#' 
#' @export

`[.labelled` <- function(x, i){
  structure(
    unclass(x)[i],
    label = attr(x, "label"),
    class = class(x)
  )
}

#' @rdname extract_labelled
#' @export

`[<-.labelled` <- function(x, i, value){
  x_new <- x
  class(x_new) <- class(x_new)[!class(x_new) %in% "labelled"]
  x_new[i] <- value
  structure(
    x_new,
    label = attr(x, "label"),
    class = c("labelled", class(x_new))
  )
}
