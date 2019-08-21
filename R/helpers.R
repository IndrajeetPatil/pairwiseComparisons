#' @title Preparing text to describe which *p*-value adjustment method was used
#' @name p_adjust_text
#' @author Indrajeet Patil
#' @return Standardized text description for what method was used.
#'
#' @inheritParams pairwise_comparisons
#'
#' @keywords internal

p_adjust_text <- function(p.adjust.method) {
  switch(
    EXPR = p.adjust.method,
    none = "None",
    bonferroni = "Bonferroni",
    holm = "Holm",
    hochberg = "Hochberg",
    hommel = "Hommel",
    BH = "Benjamini & Hochberg",
    fdr = "Benjamini & Hochberg",
    BY = "Benjamini & Yekutieli",
    "Holm"
  )
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
