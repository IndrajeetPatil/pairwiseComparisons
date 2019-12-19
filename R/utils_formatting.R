#' @title Creating a new column with significance labels
#' @name signif_column
#' @author Indrajeet Patil
#' @description This function will add a new column with significance labels to
#'   a dataframe containing *p*-values.
#' @return Returns the dataframe in tibble format with an additional column
#'   corresponding to APA-format statistical significance labels.
#'
#' @param data Data frame from which variables specified are preferentially to
#'   be taken.
#' @param p The column containing *p*-values.
#' @param messages Logical decides whether to produce notes (Default: `TRUE`).
#'
#' @importFrom dplyr group_by summarize n arrange pull
#' @importFrom dplyr mutate mutate_at mutate_if
#' @importFrom rlang !! !!! enquo
#' @importFrom stats lm
#'
#' @family helper_stats
#'
#' @examples
#' library(pairwiseComparisons)
#'
#' # preparing a newdataframe
#' df <- cbind.data.frame(
#'   x = 1:5,
#'   y = 1,
#'   p.value = c(0.1, 0.5, 0.00001, 0.05, 0.01)
#' )
#'
#' # dataframe with significance column
#' pairwiseComparisons::signif_column(data = df, p = p.value)
#' @export

# function body
signif_column <- function(data, p, messages = FALSE) {
  # add new significance column based on standard APA guidelines
  data %<>%
    dplyr::mutate(
      .data = .,
      significance = dplyr::case_when(
        {{ p }} >= 0.050 ~ "ns",
        {{ p }} < 0.050 & {{ p }} >= 0.010 ~ "*",
        {{ p }} < 0.010 & {{ p }} >= 0.001 ~ "**",
        {{ p }} < 0.001 ~ "***"
      )
    ) %>% # convert to tibble dataframe
    tibble::as_tibble(x = .)
}


#' @title Formatting numeric (*p*-)values
#' @name specify_decimal_p
#' @author Indrajeet Patil
#'
#' @description Function to format an R object for pretty printing with a
#'   specified (`k`) number of decimal places. The function also allows really
#'   small *p*-values to be denoted as `"p < 0.001"` rather than `"p = 0.000"`.
#'   Note that if `p.value` is set to `TRUE`, the minimum value of `k` allowed
#'   is `3`. If `k` is set to less than 3, the function will ignore entered `k`
#'   value and use `k = 3` instead. **Important**: This function is not
#'   vectorized.
#'
#' @param x A numeric value.
#' @param k Number of digits after decimal point (should be an integer)
#'   (Default: `k = 3`).
#' @param p.value Decides whether the number is a *p*-value (Default: `FALSE`).
#'
#' @return Formatted numeric value.
#'
#' @examples
#' library(pairwiseComparisons)
#' specify_decimal_p(x = 0.00001, k = 2, p.value = TRUE)
#' specify_decimal_p(x = 0.008, k = 2, p.value = TRUE)
#' specify_decimal_p(x = 0.008, k = 3, p.value = FALSE)
#' @export

# function body
specify_decimal_p <- function(x, k = 3, p.value = FALSE) {

  # for example, if p.value is 0.002, it should be displayed as such
  if (k < 3 && isTRUE(p.value)) k <- 3

  # formatting the output properly
  output <- trimws(format(round(x = x, digits = k), nsmall = k), which = "both")

  # if it's a p-value, then format it properly
  if (isTRUE(p.value) && output < 0.001) output <- "< 0.001"

  # this will return a character
  return(output)
}


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
