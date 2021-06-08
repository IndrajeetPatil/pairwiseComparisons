#' @title *p*-value adjustment method text
#' @name p_adjust_text
#'
#' @description
#'
#' Preparing text to describe which *p*-value adjustment method was used
#'
#' @return Standardized text description for what method was used.
#'
#' @inheritParams pairwise_comparisons
#'
#' @importFrom dplyr case_when
#'
#' @examples
#' library(pairwiseComparisons)
#' p_adjust_text("none")
#' p_adjust_text("BY")
#' @export

p_adjust_text <- function(p.adjust.method) {
  dplyr::case_when(
    grepl("^n|^bo|^h", p.adjust.method) ~ paste0(
      toupper(substr(p.adjust.method, 1, 1)),
      substr(p.adjust.method, 2, nchar(p.adjust.method))
    ),
    grepl("^BH|^f", p.adjust.method) ~ "FDR",
    grepl("^BY", p.adjust.method) ~ "BY",
    TRUE ~ "Holm"
  )
}


#' @name pairwise_caption
#' @title Pairwise comparison test expression
#'
#' @description
#'
#' This returns an expression containing details about the pairwise comparison
#' test and the *p*-value adjustment method. These details are typically
#' included in the `ggstatsplot` package plots as a caption.
#'
#' @param test.description Text describing the details of the test.
#' @param caption Additional text to be included in the plot.
#' @param pairwise.display Decides *which* pairwise comparisons to display.
#'   Available options are:
#'   - `"significant"` (abbreviation accepted: `"s"`)
#'   - `"non-significant"` (abbreviation accepted: `"ns"`)
#'   - `"all"`
#'
#'   You can use this argument to make sure that your plot is not uber-cluttered
#'   when you have multiple groups being compared and scores of pairwise
#'   comparisons being displayed.
#' @param ... Ignored.
#'
#' @importFrom dplyr case_when
#'
#' @examples
#' library(pairwiseComparisons)
#' pairwise_caption("my caption", "Student's t-test")
#' @export

pairwise_caption <- function(caption,
                             test.description,
                             pairwise.display = "significant",
                             ...) {
  # create expression
  substitute(
    atop(
      displaystyle(top.text),
      expr = paste("Pairwise test: ", bold(test), "; Comparisons shown: ", bold(display))
    ),
    env = list(
      top.text = caption,
      test = test.description,
      display = dplyr::case_when(
        substr(pairwise.display, 1L, 1L) == "s" ~ "only significant",
        substr(pairwise.display, 1L, 1L) == "n" ~ "only non-significant",
        TRUE ~ "all"
      )
    )
  )
}
