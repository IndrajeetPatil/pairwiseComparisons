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
