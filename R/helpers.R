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