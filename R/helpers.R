#' @name matrix_to_tidy
#' @noRd
#'
#' @note Adapted from `dfrtopics::gather_matrix()`.
#'
#' @importFrom Matrix t
#'
#' @keywords internal

# function body
matrix_to_tidy <- function(m,
                           row_values = rownames(m),
                           col_values = colnames(m),
                           col_names = c("row_key", "col_key", "value"),
                           row_major = TRUE,
                           ...) {
  if (is.null(row_values)) {
    row_values <- seq(nrow(m))
  }
  if (is.null(col_values)) {
    col_values <- seq(ncol(m))
  }
  stopifnot(length(row_values) == nrow(m))
  stopifnot(length(col_values) == ncol(m))
  stopifnot(length(col_names) == 3)
  if (row_major) {
    result <- data.frame(
      rkey = rep(row_values, each = ncol(m)),
      ckey = rep(col_values, times = nrow(m)),
      value = as.numeric(Matrix::t(m)),
      stringsAsFactors = FALSE
    )
  }
  else {
    result <- data.frame(
      rkey = rep(row_values, times = ncol(m)),
      ckey = rep(col_values, each = nrow(m)),
      value = as.numeric(m),
      stringsAsFactors = FALSE
    )
  }
  names(result) <- col_names
  result <- as_tibble(na.omit(result))
  return(result)
}


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
