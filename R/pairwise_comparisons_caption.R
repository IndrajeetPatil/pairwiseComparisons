#' @title Preparing caption in case pairwise comparisons are displayed.
#' @author  \href{https://github.com/IndrajeetPatil}{Indrajeet Patil}
#' @name pairwise_comparisons_caption
#'
#' @inheritParams pairwise_comparisons
#' @param caption Text to display as caption (will be displayed on top of the
#'   description of pairwise comparison test).
#'
#' @return An expression containing details about the pairwise comparison test
#'   carried out. These details are intended to be displayed in the caption of a
#'   plot.
#'
#' @examples
#'
#' pairwiseComparisons::pairwise_comparisons_caption(
#'   type = "robust",
#'   paired = FALSE,
#'   p.adjust.method = "holm",
#'   caption = "this is caption"
#' )
#' @export

pairwise_comparisons_caption <- function(type,
                                         var.equal = FALSE,
                                         paired = FALSE,
                                         p.adjust.method = "holm",
                                         caption = NULL,
                                         ...) {

  # ======================= pairwise test run ==============================

  # figuring out type of test needed to run
  test.type <-
    switch(
      EXPR = type,
      parametric = "p",
      p = "p",
      robust = "r",
      r = "r",
      nonparametric = "np",
      np = "np",
      bayes = "bf",
      bf = "bf"
    )

  # figuring out which pairwise comparison test was run
  # parametric
  if (test.type == "p") {
    if (isTRUE(paired) || isTRUE(var.equal)) {
      test.description <- "Student's t-test"
    } else {
      test.description <- "Games-Howell test"
    }
  }

  # non-parametric
  if (test.type == "np") {
    if (isTRUE(paired)) {
      test.description <- "Durbin-Conover test"
    } else {
      test.description <- "Dwass-Steel-Crichtlow-Fligner test"
    }
  }

  # robust
  if (test.type == "r") {
    test.description <- "Yuen's trimmed means test"
  }

  # ==================== combining into a caption ==========================

  # prepare the caption containing details about which pairwise test was run
  pairwise_caption <-
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

  # return the caption
  return(pairwise_caption)
}

#' @name pairwise_comparisons_caption
#' @aliases  pairwise_comparisons_caption
#' @export

pairwise_p_caption <- pairwise_comparisons_caption
