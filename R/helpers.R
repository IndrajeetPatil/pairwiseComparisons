#' @name PMCMR_to_tibble
#' @note Adapted from `dfrtopics::gather_matrix()`.
#'
#' @importFrom stats na.omit
#' @importFrom dplyr bind_cols contains select
#'
#' @keywords internal
#' @noRd

# function body
PMCMR_to_tibble <- function(mod, ...) {
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

  # combining statistic and p-value columns
  dplyr::bind_cols(
    matrix_to_tidy(m = mod$statistic, col_names = c("group2", "group1", "statistic")),
    dplyr::select(
      matrix_to_tidy(m = mod$p.value, col_names = c("group2", "group1", "p.value")),
      -dplyr::contains("group")
    )
  )
}



#' @noRd
#' @keywords internal

p_adjust_column_adder <- function(df, p.adjust.method) {
  df %>%
    dplyr::mutate(p.value = stats::p.adjust(p = p.value, method = p.adjust.method)) %>%
    signif_column(data = ., p = p.value)
}
