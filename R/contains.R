#' Test if a list contains some elements of the desired class.
#'
#' @param match_list list. The list to test for class of the elements.
#' @param expected_class character. The name of the expected class to test.
#' @examples
#'   list(1, 2, 3) %contains% numeric
#'   list(1, 2, "a") %contains% numeric
#' @return Boolean whether or not the match_list has at least one element of expected_class.
#' @export
`%contains%` <- function(match_list, expected_class) {
  if (is.name(substitute(expected_class))) {
    expected_class <- deparse(substitute(expected_class))
  }
  checkr:::contains_(match_list, expected_class, exclusive = FALSE)
}

#' Test if a list does not contain some elements of the desired class.
#' @rdname grapes-contains-grapes
#' @examples
#'   list(1, 2, 3) %does_not_contain% character
#' @return Boolean whether or not the match_list has no elements of the expected_class.
#' @export
`%does_not_contain%` <- function(match_list, expected_class) {
  if (is.name(substitute(expected_class))) {
    expected_class <- deparse(substitute(expected_class))
  }
  !checkr:::contains_(match_list, expected_class, exclusive = FALSE)
}

#' Test if a list contains only elements of the desired class.
#' @rdname grapes-contains-grapes
#' @examples
#'   list(1, 2, 3) %contains_only% numeric
#'   list(1, 2, "a") %contains_only% numeric
#' @return Boolean whether or not the match_list has all elements of expected_class.
#' @export
`%contains_only%` <- function(match_list, expected_class) {
  if (is.name(substitute(expected_class))) {
    expected_class <- deparse(substitute(expected_class))
  }
  checkr:::contains_(match_list, expected_class, exclusive = TRUE)
}

contains_ <- function(match_list, expected_class, exclusive) {
  if (checkr::is.empty(match_list)) { return(FALSE) }
  match_fn <- if (isTRUE(exclusive)) { all } else { any }
  match_fn(vapply(match_list, checkr:::`%is_%`, expected_class = expected_class, logical(1)))
}
