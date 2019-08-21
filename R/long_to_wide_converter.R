#' @title Converts long-format dataframe to wide-format dataframe
#' @name long_to_wide_converter
#' @author \href{https://github.com/IndrajeetPatil}{Indrajeet Patil}
#' @description This conversion is helpful mostly for repeated measures design.
#'
#' @inheritParams pairwise_comparisons
#'
#' @importFrom rlang !! enquo :=
#' @importFrom dplyr n row_number select mutate mutate_at group_by ungroup
#' @importFrom tidyr spread
#'
#' @examples
#' pairwiseComparisons:::long_to_wide_converter(
#'   data = iris_long,
#'   x = condition,
#'   y = value,
#'   paired = TRUE
#' )
#' @keywords internal

long_to_wide_converter <- function(data, x, y, paired = TRUE, ...) {

  # make sure both quoted and unquoted arguments are allowed
  x <- rlang::ensym(x)
  y <- rlang::ensym(y)

  # creating a dataframe
  data %<>%
    dplyr::select(.data = ., {{ x }}, {{ y }}) %>%
    dplyr::mutate(.data = ., {{ x }} := droplevels(as.factor({{ x }}))) %>%
    tibble::as_tibble(x = .)

  # figuring out number of levels in the grouping factor
  x_n_levels <- nlevels(data %>% dplyr::pull({{ x }}))[[1]]

  # wide format
  data_wide <-
    data %>%
    dplyr::filter(.data = ., !is.na({{ x }})) %>%
    dplyr::group_by(.data = ., {{ x }}) %>%
    dplyr::mutate(.data = ., rowid = dplyr::row_number()) %>%
    dplyr::ungroup(x = .) %>%
    dplyr::filter(.data = ., !is.na({{ y }}))

  # clean up for repeated measures design
  if (isTRUE(paired)) {
    data_wide %<>%
      dplyr::group_by(.data = ., rowid) %>%
      dplyr::mutate(.data = ., n = dplyr::n()) %>%
      dplyr::ungroup(x = .) %>%
      dplyr::filter(.data = ., n == x_n_levels) %>%
      dplyr::select(.data = ., {{ x }}, {{ y }}, rowid)
  }

  # spreading the columns of interest
  data_wide %<>%
    tidyr::spread(
      data = .,
      key = {{ x }},
      value = {{ y }},
      convert = TRUE
    )

  # return the dataframe in wide format
  return(data_wide)
}


#' @noRd
#' @keywords internal

df_cleanup_paired <- function(data, x, y) {
  data %<>%
    long_to_wide_converter(data = ., x = {{ x }}, y = {{ y }}) %>%
    tidyr::gather(data = ., key, value, -rowid) %>%
    dplyr::arrange(.data = ., rowid) %>%
    dplyr::rename(.data = ., {{ x }} := key, {{ y }} := value) %>%
    dplyr::mutate(.data = ., {{ x }} := factor({{ x }}))
}
