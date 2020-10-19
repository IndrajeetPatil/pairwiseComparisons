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

#' @importFrom BayesFactor ttestBF
#' @importFrom dplyr mutate
#' @importFrom parameters model_parameters
#' @importFrom insight standardize_names
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
    insight::standardize_names(data = ., style = "broom") %>%
    dplyr::rename(.data = ., "bf10" = "bayes.factor") %>%
    dplyr::mutate(.data = ., log_e_bf10 = log(bf10))
}


#' @title Preparing text to describe which *p*-value adjustment method was used
#' @name p_adjust_text
#' @return Standardized text description for what method was used.
#'
#' @inheritParams pairwise_comparisons
#'
#' @examples
#' library(pairwiseComparisons)
#' p_adjust_text("none")
#' p_adjust_text("BY")
#' @export

p_adjust_text <- function(p.adjust.method) {
  switch(
    EXPR = p.adjust.method,
    none = "None",
    bonferroni = "Bonferroni",
    holm = "Holm",
    hochberg = "Hochberg",
    hommel = "Hommel",
    BH = "FDR",
    fdr = "FDR",
    BY = "BY",
    "Holm"
  )
}


#' @name pairwise_caption
#' @title Expression containing details about pairwise comparison test
#' @description This returns an expression containing details about the pairwise
#'   comparison test and the *p*-value adjustment method. These details are
#'   typically included in the `ggstatsplot` package plots as a caption.
#'
#' @param test.description Text describing the details of the test.
#' @param caption Additional text to be included in the plot.
#' @param pairwise.display Decides which pairwise comparisons to display.
#'   Available options are `"significant"` (abbreviation accepted: `"s"`) or
#'   `"non-significant"` (abbreviation accepted: `"ns"`) or
#'   `"everything"`/`"all"`. The default is `"significant"`.
#' @param ... Ignored.
#'
#' @examples
#' library(pairwiseComparisons)
#' pairwise_caption("my caption", "Student's t-test")
#' @export

pairwise_caption <- function(caption,
                             test.description,
                             pairwise.display = "significant",
                             ...) {
  # which comparisons are shown? (standardize strings)
  pairwise.display <-
    switch(
      EXPR = substr(x = pairwise.display, start = 1L, stop = 1L),
      s = "only significant",
      n = "only non-significant",
      "all"
    )

  # create expression
  substitute(
    atop(
      displaystyle(top.text),
      expr = paste(
        "Pairwise test: ",
        bold(test.description),
        "; Comparisons shown: ",
        bold(pairwise.display)
      )
    ),
    env = list(
      top.text = caption,
      test.description = test.description,
      pairwise.display = pairwise.display
    )
  )
}
