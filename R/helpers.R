#' @name matrix_to_tidy
#' @note Adapted from `dfrtopics::gather_matrix()`.
#' @importFrom stats na.omit
#' @keywords internal
#' @noRd

# function body
matrix_to_tidy <- function(m, col_names = c("row_key", "col_key", "value"), ...) {
  result <-
    data.frame(
      rkey = rep(rownames(m), each = ncol(m)),
      ckey = rep(colnames(m), times = nrow(m)),
      value = as.numeric(base::t(m)),
      stringsAsFactors = FALSE
    )

  names(result) <- col_names
  as_tibble(stats::na.omit(result))
}


#' @noRd
#' @keywords internal

p_adjust_column_adder <- function(df, p.adjust.method) {
  df %>%
    dplyr::mutate(p.value = stats::p.adjust(p = p.value, method = p.adjust.method)) %>%
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
