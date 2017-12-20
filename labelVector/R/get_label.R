#' @name get_label
#' @title Extract Label Attribute From a Labelled Vector
#'
#' @description Retrieve the label attribute of a labelled vector. If the
#'   vector has no label, the vector name is returned as a string.
#'
#' @param x An atomic vector.
#' @param ... Arguments to pass to other methods.
#' @param vars A character vector of variable names in \code{x} for which
#'   to retrieve labels.  If \code{NULL}, all labels are returned.
#'
#' @seealso \code{\link{set_label}}
#' x <- 1:10
#' x <- set_label(x, "Integers")
#'
#' get_label(x)
#'
#' y <- letters
#' attr(y, "label")    # NULL
#' get_label(y)        # "y"
#'
#' # Set labels for variables in a data frame
#'
#' mtcars2 <-
#'   set_label(mtcars,
#'             am = "Automatic / Manual",
#'             mpg = "Miles per Gallon",
#'             gear = "Number of gears")
#'
#' get_label(mtcars2)
#'
#' @export

get_label <- function(x, ...){
  UseMethod("get_label")
}

#' @rdname get_label
#' @export

get_label.default <- function(x, ...){
  if (!is.atomic(x)){
    stop("`x` must be an atomic vector")
  }

  lbl <- attr(x, "label")
  if (is.null(lbl)){
    deparse(substitute(x))
  }
  else{
    lbl
  }
}

#' @rdname get_label
#' @export

get_label.data.frame <- function(x, vars = NULL, ...){
  if (!inherits(x, "data.frame")){
    stop("`x` must inherit class 'data.frame'")
  }

  if (is.null(vars)){
    vars <- names(x)
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

  has_label <-
    vapply(X = x[vars],
           FUN = function(x) !is.null(attr(x, "label")),
           FUN.VALUE = logical(1))

  lbl <- vars
  lbl[has_label] <-
    vapply(X = x[vars][has_label],
           FUN = get_label.default,
           FUN.VALUE = character(1))

  lbl
}
