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
  # combining statistic and p-value columns
  dplyr::bind_cols(
    matrix_to_tidy(mod$statistic, "statistic"),
    dplyr::select(matrix_to_tidy(mod$p.value, "p.value"), -dplyr::contains("group"))
  )
}

#' @keywords internal
#' @noRd

matrix_to_tidy <- function(m, col_name = "value", ...) {
  result <-
    data.frame(
      group2 = rep(rownames(m), each = ncol(m)),
      group1 = rep(colnames(m), times = nrow(m)),
      value = as.numeric(base::t(m)),
      stringsAsFactors = FALSE
    )

  names(result)[3] <- col_name
  as_tibble(stats::na.omit(result))
}

#' @name p_adjust_column_adder
#'
#' @importFrom stats p.adjust
#' @importFrom dplyr mutate
#'
#' @noRd
#' @keywords internal

p_adjust_column_adder <- function(df, p.adjust.method) {
  df %>%
    dplyr::mutate(p.value = stats::p.adjust(p = p.value, method = p.adjust.method)) %>%
    signif_column(data = ., p = p.value)
}

#' @importFrom BayesFactor ttestBF
#' @importFrom dplyr mutate
#' @importFrom parameters model_parameters
#' @importFrom ipmisc easystats_to_tidy_names
#'
#' @noRd
#' @keywords internal

bf_internal_ttest <- function(data,
                              x,
                              y,
                              paired = FALSE,
                              bf.prior = 0.707,
                              ...) {
  # make sure both quoted and unquoted arguments are allowed
  c(x, y) %<-% c(rlang::ensym(x), rlang::ensym(y))

  # have a proper cleanup with NA removal
  data %<>%
    ipmisc::long_to_wide_converter(
      data = .,
      x = {{ x }},
      y = {{ y }},
      paired = paired,
      spread = paired
    )

  # within-subjects design
  if (isTRUE(paired)) {
    # extracting results from Bayesian test and creating a dataframe
    bf_object <-
      BayesFactor::ttestBF(
        x = data[[2]],
        y = data[[3]],
        rscale = bf.prior,
        paired = TRUE,
        progress = FALSE
      )
  }

  # between-subjects design
  if (isFALSE(paired)) {
    # extracting results from Bayesian test and creating a dataframe
    bf_object <-
      BayesFactor::ttestBF(
        formula = rlang::new_formula({{ y }}, {{ x }}),
        data = as.data.frame(data),
        rscale = bf.prior,
        paired = FALSE,
        progress = FALSE
      )
  }

  # extracting Bayes Factors and other details
  parameters::model_parameters(bf_object, ...) %>%
    ipmisc::easystats_to_tidy_names(.) %>%
    dplyr::rename(.data = ., bf10 = bf) %>%
    dplyr::mutate(.data = ., log_e_bf10 = log(bf10))
}
