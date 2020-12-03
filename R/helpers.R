#' @name PMCMR_to_tibble
#'
#' @importFrom dplyr contains select rename
#' @importFrom PMCMRplus toTidy
#'
#' @keywords internal
#' @noRd

# function body
PMCMR_to_tibble <- function(mod, ...) {
  dplyr::select(PMCMRplus::toTidy(mod), -dplyr::contains("method")) %>%
    dplyr::rename(group2 = group1, group1 = group2)
}

#' @importFrom BayesFactor ttestBF
#' @importFrom dplyr mutate
#' @importFrom parameters model_parameters standardize_names
#' @importFrom rlang exec new_formula !!!
#'
#' @noRd
#' @keywords internal

bf_internal_ttest <- function(data,
                              x,
                              y,
                              paired = FALSE,
                              bf.prior = 0.707,
                              ...) {
  # have a proper cleanup with NA removal
  data %<>%
    ipmisc::long_to_wide_converter(
      data = .,
      x = {{ x }},
      y = {{ y }},
      paired = paired,
      spread = paired
    )

  # relevant arguments
  if (isTRUE(paired)) bf.args <- list(x = data[[2]], y = data[[3]])
  if (isFALSE(paired)) bf.args <- list(formula = rlang::new_formula(y, x))

  # creating a BayesFactor object
  bf_object <-
    rlang::exec(
      .fn = BayesFactor::ttestBF,
      rscale = bf.prior,
      paired = paired,
      data = as.data.frame(data),
      !!!bf.args
    )

  # extracting Bayes Factors and other details
  parameters::model_parameters(bf_object, verbose = FALSE, ...) %>%
    parameters::standardize_names(data = ., style = "broom") %>%
    dplyr::rename("bf10" = "bayes.factor") %>%
    dplyr::mutate(log_e_bf10 = log(bf10))
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
