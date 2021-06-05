#' @description Handy shorthand for `model_parameters`
#' @noRd

tidy_model_parameters <- function(model, ...) {
  parameters::model_parameters(model, verbose = FALSE, ...) %>%
    parameters::standardize_names(style = "broom")
}

#' @importFrom BayesFactor ttestBF
#' @importFrom dplyr mutate
#' @importFrom parameters model_parameters standardize_names
#' @importFrom rlang exec new_formula !!!
#'
#' @noRd
#' @keywords internal

bf_ttest <- function(data, x, y, paired = FALSE, bf.prior = 0.707, ...) {
  # have a proper cleanup with NA removal
  data %<>%
    ipmisc::long_to_wide_converter(
      x = {{ x }},
      y = {{ y }},
      paired = paired,
      spread = paired
    )

  # relevant arguments
  if (isTRUE(paired)) bf.args <- list(x = data[[2]], y = data[[3]])
  if (isFALSE(paired)) bf.args <- list(formula = rlang::new_formula(y, x))

  # creating a BayesFactor object
  bf_object <- rlang::exec(
    .fn = BayesFactor::ttestBF,
    rscale = bf.prior,
    paired = paired,
    data = as.data.frame(data),
    !!!bf.args
  )

  # extracting Bayes Factors and other details
  dplyr::filter(tidy_model_parameters(bf_object), !is.na(bayes.factor)) %>%
    dplyr::rename("bf10" = "bayes.factor") %>%
    dplyr::mutate(log_e_bf10 = log(bf10))
}


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
#' @param pairwise.display Decides which pairwise comparisons to display.
#'   Available options are `"significant"` (abbreviation accepted: `"s"`) or
#'   `"non-significant"` (abbreviation accepted: `"ns"`) or
#'   `"everything"`/`"all"`. The default is `"significant"`.
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

#' @name ggsignif_xy
#' @importFrom utils combn
#'
#' @inheritParams ggbetweenstats
#'
#' @keywords internal
#' @noRd

ggsignif_xy <- function(x, y) {
  # number of comparisons
  n_comparions <- length(utils::combn(x = unique(x), m = 2L, simplify = FALSE))

  # start position on `y`-axis for the `ggsignif` lines
  y_start <- max(y, na.rm = TRUE) * (1 + 0.025)

  # steps in which the y values need to increase
  step_length <- (max(y, na.rm = TRUE) - min(y, na.rm = TRUE)) / 20

  # end position on `y`-axis for the `ggsignif` lines
  y_end <- y_start + (step_length * n_comparions)

  # creating a vector of positions for the `ggsignif` lines
  seq(y_start, y_end, length.out = n_comparions)
}
