#' @name remove_label
#' @title Remove the Label Attribute From a Variable
#' 
#' @description Remove the label from a labelled vector. The \code{data.frame}
#'   method removes labels from multiple vectors and returns a 
#'   data frame.
#'
#' @param x An atomic vector from which to remove a label attribute. May also
#'   be a \code{data.frame}, in which case label attributes will be removed
#'   from the specified vectors.
#' @param vars \code{character} vector of names in \code{x} giving vectors
#'   for which labels are to be removed.
#' @param ... Arguments to pass to other methods.
#'
#' @export

remove_label <- function(x, ...){
  UseMethod("remove_label")
}

#' @rdname remove_label
#' @export

remove_label.default <- function(x, ...){
  
  if (is.null(x)){
    return(x)
  }
  
  if (!is.atomic(x)){
    stop("`x` must be an atomic vector")
  }
  
  attr(x, "label") <- NULL
  class(x) <- class(x)[!class(x) %in% "labelled"]
  x
}

#' @rdname remove_label
#' @export

remove_label.data.frame <- function(x, vars, ...){
  if (!inherits(x, "data.frame")){
    stop("`x` must inherit class 'data.frame'")
  }
  
  if (!is.character(vars)){
    stop("`vars` must have class `character`")
  }
  
  not_in_data <- vars[!vars %in% names(x)]
  
  if (length(not_in_data)){
    stop("The following are not variables in `x`: ",
         paste0(not_in_data, collapse = ", "))
  }
  
  is_atomic <-
    vapply(x[vars],
           is.atomic,
           logical(1))
  
  if (any(!is_atomic)){
    stop("The following variables in `x` are not atomic: ",
         paste0(vars[!is_atomic], collapse = ", "))
  }
  
  for (v in vars){
    x[[v]] <- remove_label.default(x[[v]])
  }
  
  x
}
