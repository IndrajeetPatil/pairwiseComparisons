#' @title Multiple pairwise comparison tests with tidy data
#' @name pairwise_comparisons
#'
#' @description
#'
#' \Sexpr[results=rd, stage=render]{rlang:::lifecycle("maturing")}
#'
#' Calculate parametric, non-parametric, robust, and Bayes Factor pairwise
#' comparisons between group levels with corrections for multiple testing.
#'
#' @param data A dataframe from which variables specified are to be taken. A
#'   matrix or tables will **not** be accepted.
#' @param x The grouping variable from the dataframe `data`.
#' @param y The response (a.k.a. outcome or dependent) variable from the
#'   dataframe `data`.
#' @param type Type of statistic expected (`"parametric"` or `"nonparametric"`
#'   or `"robust"` or `"bayes"`).Corresponding abbreviations are also accepted:
#'   `"p"` (for parametric), `"np"` (nonparametric), `"r"` (robust), or
#'   `"bf"`resp.
#' @param tr Trim level for the mean when carrying out `robust` tests. If you
#'   get error stating "Standard error cannot be computed because of Winsorized
#'   variance of 0 (e.g., due to ties). Try to decrease the trimming level.",
#'   try to play around with the value of `tr`, which is by default set to
#'   `0.1`. Lowering the value might help.
#' @param p.adjust.method Adjustment method for *p*-values for multiple
#'   comparisons. Possible methods are: `"holm"` (default), `"hochberg"`,
#'   `"hommel"`, `"bonferroni"`, `"BH"`, `"BY"`, `"fdr"`, `"none"`.
#' @param paired Logical that decides whether the experimental design is
#'   repeated measures/within-subjects or between-subjects. The default is
#'   `FALSE`.
#' @param k Number of digits after decimal point (should be an integer)
#'   (Default: `k = 2L`).
#' @param ... Current ignored.
#' @inheritParams ipmisc::long_to_wide_converter
#' @inheritParams stats::t.test
#' @inheritParams WRS2::rmmcp
#' @inheritParams tidyBF::bf_ttest
#'
#' @return A tibble dataframe containing two columns corresponding to group
#'   levels being compared with each other (`group1` and `group2`) and `p.value`
#'   column corresponding to this comparison. The dataframe will also contain a
#'   `p.value.label` column containing a *label* for this *p*-value, in case
#'   this needs to be displayed in `ggsignif::geom_ggsignif`. In addition to
#'   these common columns across the different types of statistics, there will
#'   be additional columns specific to the `type` of test being run.
#'
#'   This function provides a unified syntax to carry out pairwise comparison
#'   tests and internally relies on other packages to carry out these tests. For
#'   more details about the included tests, see the documentation for the
#'   respective functions:
#'   \itemize{
#'   \item *parametric* : [stats::pairwise.t.test()] (paired) and
#'   [PMCMRplus::gamesHowellTest()] (unpaired)
#'   \item *non-parametric* :
#'   [PMCMRplus::durbinAllPairsTest()] (paired) and
#'   [PMCMRplus::kwAllPairsDunnTest()] (unpaired)
#'   \item *robust* :
#'   [WRS2::rmmcp()] (paired) and  [WRS2::lincon()] (unpaired)
#'   \item *Bayes Factor* : [BayesFactor::ttestBF()]
#'   }
#'
#' @importFrom dplyr select rename mutate everything mutate_if across starts_with
#' @importFrom dplyr bind_cols matches rowwise ungroup
#' @importFrom stats p.adjust pairwise.t.test na.omit aov
#' @importFrom WRS2 lincon rmmcp
#' @importFrom PMCMRplus durbinAllPairsTest kwAllPairsDunnTest gamesHowellTest
#' @importFrom rlang !!! ensym exec
#' @importFrom purrr map2 map_dfr
#' @importFrom ipmisc stats_type_switch format_num long_to_wide_converter
#' @importFrom insight standardize_names
#'
#' @examples
#'
#' \donttest{
#' # for reproducibility
#' set.seed(123)
#' library(pairwiseComparisons)
#'
#' # show me all columns and make the column titles bold
#' options(tibble.width = Inf, pillar.bold = TRUE, pillar.subtle_num = TRUE)
#'
#' #------------------- between-subjects design ----------------------------
#'
#' # parametric
#' # if `var.equal = TRUE`, then Student's t-test will be run
#' pairwise_comparisons(
#'   data = mtcars,
#'   x = cyl,
#'   y = wt,
#'   type = "parametric",
#'   var.equal = TRUE,
#'   paired = FALSE,
#'   p.adjust.method = "none"
#' )
#'
#' # if `var.equal = FALSE`, then Games-Howell test will be run
#' pairwise_comparisons(
#'   data = mtcars,
#'   x = cyl,
#'   y = wt,
#'   type = "parametric",
#'   var.equal = FALSE,
#'   paired = FALSE,
#'   p.adjust.method = "bonferroni"
#' )
#'
#' # non-parametric (Dunn test)
#' pairwise_comparisons(
#'   data = mtcars,
#'   x = cyl,
#'   y = wt,
#'   type = "nonparametric",
#'   paired = FALSE,
#'   p.adjust.method = "none"
#' )
#'
#' # robust (Yuen's trimmed means t-test)
#' pairwise_comparisons(
#'   data = mtcars,
#'   x = cyl,
#'   y = wt,
#'   type = "robust",
#'   paired = FALSE,
#'   p.adjust.method = "fdr"
#' )
#'
#' # Bayes Factor (Student's t-test)
#' pairwise_comparisons(
#'   data = mtcars,
#'   x = cyl,
#'   y = wt,
#'   type = "bayes",
#'   paired = FALSE
#' )
#'
#' #------------------- within-subjects design ----------------------------
#'
#' # parametric (Student's t-test)
#' pairwise_comparisons(
#'   data = bugs_long,
#'   x = condition,
#'   y = desire,
#'   subject.id = subject,
#'   type = "parametric",
#'   paired = TRUE,
#'   p.adjust.method = "BH"
#' )
#'
#' # non-parametric (Durbin-Conover test)
#' pairwise_comparisons(
#'   data = bugs_long,
#'   x = condition,
#'   y = desire,
#'   subject.id = subject,
#'   type = "nonparametric",
#'   paired = TRUE,
#'   p.adjust.method = "BY"
#' )
#'
#' # robust (Yuen's trimmed means t-test)
#' pairwise_comparisons(
#'   data = bugs_long,
#'   x = condition,
#'   y = desire,
#'   subject.id = subject,
#'   type = "robust",
#'   paired = TRUE,
#'   p.adjust.method = "hommel"
#' )
#'
#' # Bayes Factor (Student's t-test)
#' pairwise_comparisons(
#'   data = bugs_long,
#'   x = condition,
#'   y = desire,
#'   subject.id = subject,
#'   type = "bayes",
#'   paired = TRUE
#' )
#' }
#' @export

# function body
pairwise_comparisons <- function(data,
                                 x,
                                 y,
                                 subject.id = NULL,
                                 type = "parametric",
                                 paired = FALSE,
                                 var.equal = FALSE,
                                 tr = 0.1,
                                 bf.prior = 0.707,
                                 p.adjust.method = "holm",
                                 k = 2L,
                                 ...) {
  # standardize stats type
  type <- ipmisc::stats_type_switch(type)

  # ensure the arguments work quoted or unquoted
  c(x, y) %<-% c(rlang::ensym(x), rlang::ensym(y))

  # ---------------------------- data cleanup -------------------------------

  # creating a dataframe (it's important for the data to be sorted by `x`)
  df_int <-
    ipmisc::long_to_wide_converter(
      data = data,
      x = {{ x }},
      y = {{ y }},
      subject.id = {{ subject.id }},
      paired = paired,
      spread = FALSE
    )

  # for some tests, it's better to have these as vectors
  x_vec <- df_int %>% dplyr::pull({{ x }})
  y_vec <- df_int %>% dplyr::pull({{ y }})
  g_vec <- df_int$rowid
  .f.args <- list()

  # ---------------------------- parametric ---------------------------------

  if (type %in% c("parametric", "bayes")) {
    if (isTRUE(var.equal) || isTRUE(paired)) {
      c(.f, test.details) %<-% c(stats::pairwise.t.test, "Student's t-test")
    } else {
      c(.f, test.details) %<-% c(PMCMRplus::gamesHowellTest, "Games-Howell test")
    }
  }

  # ---------------------------- nonparametric ----------------------------

  if (type == "nonparametric") {
    if (isFALSE(paired)) c(.f, test.details) %<-% c(PMCMRplus::kwAllPairsDunnTest, "Dunn test")
    if (isTRUE(paired)) c(.f, test.details) %<-% c(PMCMRplus::durbinAllPairsTest, "Durbin-Conover test")

    # `exec` fails otherwise for `pairwise.t.test` because `y` is passed to `t.test`
    .f.args <- list(y = y_vec)
  }

  # running the appropriate test
  if (type != "robust") {
    df <-
      suppressWarnings(rlang::exec(
        .fn = .f,
        # Dunn, Games-Howell, Student test
        x = y_vec,
        g = x_vec,
        # Durbin-Conover test
        groups = x_vec,
        blocks = g_vec,
        # Student
        paired = paired,
        # common
        na.action = na.omit,
        p.adjust.method = "none",
        # problematic for other methods
        !!!.f.args
      )) %>%
      tidy_model_parameters(.) %>%
      dplyr::rename(group2 = group1, group1 = group2)
  }

  # ---------------------------- robust ----------------------------------

  # extracting the robust pairwise comparisons
  if (type == "robust") {
    if (isFALSE(paired)) {
      mod <-
        WRS2::lincon(
          formula = rlang::new_formula(y, x),
          data = df_int,
          tr = tr
        )
    } else {
      mod <-
        WRS2::rmmcp(
          y = y_vec,
          groups = x_vec,
          blocks = g_vec,
          tr = tr
        )
    }

    # cleaning the raw object and getting it in the right format
    df <- tidy_model_parameters(mod)

    # test details
    test.details <- "Yuen's trimmed means test"
  }

  # ---------------------------- bayes factor --------------------------------

  if (type == "bayes") {
    # combining results into a single dataframe and returning it
    df_tidy <-
      purrr::map_dfr(
        # creating a list of dataframes with subsections of data
        .x = purrr::map2(
          .x = as.character(df$group1),
          .y = as.character(df$group2),
          .f = function(a, b) droplevels(dplyr::filter(df_int, {{ x }} %in% c(a, b)))
        ),
        # internal function to carry out BF t-test
        .f = ~ bf_ttest(
          data = .x,
          x = {{ x }},
          y = {{ y }},
          paired = paired,
          bf.prior = bf.prior
        )
      ) %>%
      dplyr::rowwise() %>%
      dplyr::mutate(label = paste0("list(~log[e](BF['01'])==", format_num(-log_e_bf10, k), ")")) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(test.details = "Student's t-test")

    # combine it with the other details
    df <- dplyr::bind_cols(dplyr::select(df, group1, group2), df_tidy)
  }

  # ---------------------------- cleanup ----------------------------------

  # final cleanup for p-value labels
  df %<>%
    dplyr::mutate_if(.tbl = ., .predicate = is.factor, .funs = ~ as.character(.)) %>%
    dplyr::arrange(group1, group2) %>%
    dplyr::select(group1, group2, dplyr::everything())

  # clean-up for non-Bayes tests
  if (type != "bayes") {
    df %<>%
      dplyr::mutate(p.value = stats::p.adjust(p = p.value, method = p.adjust.method)) %>%
      dplyr::mutate(
        test.details = test.details,
        p.value.adjustment = p_adjust_text(p.adjust.method)
      ) %>%
      dplyr::rowwise() %>%
      dplyr::mutate(
        label = dplyr::case_when(
          p.value.adjustment != "None" ~
          paste0(
            "list(~italic(p)[",
            p.value.adjustment,
            "-corrected]==",
            format_num(p.value, k, TRUE),
            ")"
          ),
          TRUE ~ paste0("list(~italic(p)[uncorrected]==", format_num(p.value, k, TRUE), ")")
        )
      ) %>%
      dplyr::ungroup()
  }

  # return
  as_tibble(df)
}
