#' @noRd
#' @keywords internal

p_adjust_column_adder <- function(df, p.adjust.method) {
  df %>%
    dplyr::mutate(
      .data = .,
      p.value = stats::p.adjust(p = p.value, method = p.adjust.method)
    ) %>%
    signif_column(data = ., p = p.value)
}


#' @name df_cleanup_paired
#'
#' @importFrom rlang :=
#' @importFrom dplyr rename select arrange mutate
#' @importFrom tidyr gather
#'
#' @noRd
#' @keywords internal

df_cleanup_paired <- function(data, x, y) {
  data %>%
    long_to_wide_converter(data = ., x = {{ x }}, y = {{ y }}) %>%
    tidyr::gather(data = ., key, value, -rowid) %>%
    dplyr::arrange(.data = ., rowid) %>%
    dplyr::rename(.data = ., {{ x }} := key, {{ y }} := value) %>%
    dplyr::mutate(.data = ., {{ x }} := factor({{ x }}))
}
