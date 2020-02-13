#' @name set_label
#' @title Set the label of an atomic vector
#'
#' @description Variable labels are a common construct in statistical
#'   software, giving users the ability to provide plain text descriptions
#'   for variables.  These descriptions can be more informative of the
#'   variable's purpose, since they need not be restricted to the naming
#'   conventions imposed on variable names.
#'
#' @param x An atomic vector
#' @param label \code{character(1)}, A character string denoting the label
#'   to assign to the variable.
#' @param ... For the default method, arguments to pass to other methods.
#'   For the \code{data.frame} method, key-pairs of the pattern
#'   \code{variable = 'label'}.
#' @param .dots, for data frames, a named list of key-pairs mapping the 
#'   variable name to the label.
#'
#' @seealso \code{\link{get_label}}
#'
#' @source
#' Frank E Harrell Jr, with contributions from Charles Dupont and many
#' others. (2017). Hmisc: Harrell Miscellaneous. R package version 4.0-3.
#' https://CRAN.R-project.org/package=Hmisc
#'
#' @examples
#' x <- 1:10
#' x <- set_label(x, "Integers")
#' x
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

set_label <- function(x, ...){
  UseMethod("set_label")
}

#' @rdname set_label
#' @export

set_label.default <- function(x, label, ...){
  if (!is.atomic(x)){
    stop("`x` must be an atomic vector")
  }
  
  if (is.null(x)){
    stop("labels may not be added to `NULL` objects.") 
  }

  if (!is.character(label) | length(label) != 1){
    stop("`label` must be a length 1 character string")
  }

  structure(x,
            label = label,
            class = c("labelled", class(x)[!class(x) %in% "labelled"]))
}

#' @rdname set_label
#' @export

set_label.data.frame <- function(x, ..., .dots = list()){

  if (!inherits(x, "data.frame")){
    stop("`x` must inherit class 'data.frame'")
  }

  if (length(.dots) && is.null(names(.dots))){
    stop("`.dots` must be a named list")  
  }
  
  lbl <- c(list(...), .dots)

  vars <- names(lbl)

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

  x[vars] <-
    mapply(function(v, lbl) set_label.default(x[[v]], lbl),
           v = vars,
           lbl = lbl,
           SIMPLIFY = FALSE)

  x
}
