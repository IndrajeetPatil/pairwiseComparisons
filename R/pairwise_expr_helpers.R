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
    BH = "Benjamini & Hochberg",
    fdr = "Benjamini & Hochberg",
    BY = "Benjamini & Yekutieli",
    "Holm"
  )
}


#' @name pairwise_caption
#' @title Expression containing details about pairwise comparison test
#' @description This returns an expression containing details about the pairwise
#'   comparison test and the *p*-value adjustment method. These details are
#'   typically included in `ggstatsplot` package plots as a caption.
#'
#' @inheritParams pairwise_comparisons
#' @param test.description Text describing the details of the test.
#' @param caption Additional text to be included in the plot.
#'
#' @examples
#' library(pairwiseComparisons)
#' pairwise_caption("my caption", "Student's t-test", "holm")
#' @export

pairwise_caption <- function(caption, test.description, p.adjust.method) {
  substitute(
    atop(
      displaystyle(top.text),
      expr = paste(
        "Pairwise comparisons: ",
        bold(test.description),
        "; Adjustment (p-value): ",
        bold(p.adjust.method.text)
      )
    ),
    env = list(
      top.text = caption,
      test.description = test.description,
      p.adjust.method.text = p_adjust_text(p.adjust.method)
    )
  )
}
