#' @title Multiple pairwise comparison tests with tidy data
#' @name pairwise_comparisons
#' @description Calculate parametric, non-parametric, robust, and Bayes Factor
#'   pairwise comparisons between group levels with corrections for multiple
#'   testing.
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
#' @inheritParams stats::t.test
#' @inheritParams WRS2::rmmcp
#' @inheritParams tidyBF::bf_ttest
#'
#' @return A tibble dataframe containing two columns corresponding to group
#'   levels being compared with each other (`group1` and `group2`) and `p.value`
#'   column corresponding to this comparison. The dataframe will also contain a
#'   `p.value.label` column containing a *label* for this *p*-value, in case
#'   this needs to be displayed in `geom_ggsignif`. In addition to these common
#'   columns across the different types of statistics, there will be additional
#'   columns specific to the `type` of test being run.
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
#'   The `significance` column asterisks indicate significance levels of
#'   *p*-values in the American Psychological Association (APA) mandated format:
#'   \itemize{
#'   \item `ns` : > 0.05
#'   \item `*` : < 0.05
#'   \item `**` : < 0.01
#'   \item `***` : < 0.001
#'   }
#'
#' @importFrom dplyr select rename mutate everything full_join vars mutate_if
#' @importFrom dplyr bind_cols rename_all recode matches rowwise ungroup
#' @importFrom stats p.adjust pairwise.t.test na.omit aov
#' @importFrom WRS2 lincon rmmcp
#' @importFrom tidyr gather spread separate
#' @importFrom PMCMRplus durbinAllPairsTest kwAllPairsDunnTest gamesHowellTest
#' @importFrom rlang !! enquo as_string ensym
#' @importFrom purrr map2 map_dfr
#' @importFrom broom tidy
#' @importFrom ipmisc stats_type_switch
#'
#' @examples
#'
#' \donttest{
#' # for reproducibility
#' set.seed(123)
#' library(pairwiseComparisons)
#'
#' # show me all columns and make the column titles bold
#' options(tibble.width = Inf, pillar.bold = TRUE)
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
#'   type = "bayes",
#'   paired = TRUE
#' )
#' }
#' @export

# function body
pairwise_comparisons <- function(data,
                                 x,
                                 y,
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
  df_internal <-
    long_to_wide_converter(
      data = dplyr::arrange(data, {{ x }}),
      x = {{ x }},
      y = {{ y }},
      paired = paired,
      spread = FALSE
    )

  # for some tests, it's better to have these as vectors
  x_vec <- df_internal %>% dplyr::pull({{ x }})
  y_vec <- df_internal %>% dplyr::pull({{ y }})

  # ---------------------------- parametric ---------------------------------

  if (type %in% c("parametric", "bayes")) {
    if (isTRUE(var.equal) || isTRUE(paired)) {
      # tidy dataframe with results from pairwise tests
      df <-
        stats::pairwise.t.test(
          x = y_vec,
          g = x_vec,
          p.adjust.method = "none",
          paired = paired,
          alternative = "two.sided",
          na.action = na.omit
        ) %>%
        broom::tidy(.) %>%
        p_adjust_column_adder(df = ., p.adjust.method = p.adjust.method) %>%
        dplyr::rename(.data = ., group2 = group1, group1 = group2)

      # test details
      test.details <- "Student's t-test"
    } else {
      # anova model
      aovmodel <-
        stats::aov(
          formula = rlang::new_formula({{ y }}, {{ x }}),
          data = df_internal
        )

      # dataframe with Games-Howell test results
      df <-
        PMCMR_to_tibble(PMCMRplus::gamesHowellTest(aovmodel, p.adjust.method = "none")) %>%
        p_adjust_column_adder(df = ., p.adjust.method = p.adjust.method)

      # test details
      test.details <- "Games-Howell test"
    }
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
          .f = function(a, b) droplevels(dplyr::filter(df_internal, {{ x }} %in% c(a, b)))
        ),
        # internal function to carry out BF t-test
        .f = ~ bf_internal_ttest(
          data = .x,
          x = {{ x }},
          y = {{ y }},
          paired = paired,
          bf.prior = bf.prior
        )
      ) %>%
      dplyr::rowwise() %>%
      dplyr::mutate(label = paste0(
        "list(~log[e](BF[10])", "==", specify_decimal_p(x = log_e_bf10, k = k), ")"
      )) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(.data = ., test.details = "Student's t-test")

    # early return (no further cleanup required)
    return(
      dplyr::mutate_if(
        .tbl = dplyr::bind_cols(dplyr::select(df, group1, group2), df_tidy),
        .predicate = is.factor,
        .funs = ~ as.character(.)
      ) %>%
        dplyr::arrange(group1, group2)
    )
  }

  # ---------------------------- nonparametric ----------------------------

  if (type == "nonparametric") {
    # # running Dunn test
    if (isFALSE(paired)) {
      mod <-
        suppressWarnings(PMCMRplus::kwAllPairsDunnTest(
          x = y_vec,
          g = x_vec,
          na.action = na.omit,
          p.adjust.method = "none"
        ))

      # test details
      test.details <- "Dunn test"
    }

    # # running Durbin-Conover test
    if (isTRUE(paired)) {
      mod <-
        PMCMRplus::durbinAllPairsTest(
          y = na.omit(matrix(
            data = y_vec,
            ncol = length(unique(x_vec)),
            dimnames = list(seq(1, length(y_vec) / length(unique(x_vec))), unique(x_vec))
          )),
          p.adjust.method = "none"
        )

      # test details
      test.details <- "Durbin-Conover test"
    }

    # cleanup
    df <-
      PMCMR_to_tibble(mod) %>%
      p_adjust_column_adder(df = ., p.adjust.method = p.adjust.method)
  }

  # ---------------------------- robust ----------------------------------

  if (type == "robust") {
    if (isFALSE(paired)) {
      wrs_obj <-
        WRS2::lincon(
          formula = rlang::new_formula({{ y }}, {{ x }}),
          data = df_internal,
          tr = tr
        )
    }

    if (isTRUE(paired)) {
      wrs_obj <-
        WRS2::rmmcp(
          y = df_internal[[rlang::as_name(y)]],
          groups = df_internal[[rlang::as_name(x)]],
          blocks = df_internal[["rowid"]],
          tr = tr
        )
    }

    # extracting the robust pairwise comparisons and tidying up names
    rob_df_tidy <-
      suppressMessages(as_tibble(wrs_obj$comp, .name_repair = "unique")) %>%
      dplyr::rename(group1 = Group...1, group2 = Group...2)

    # cleaning the raw object and getting it in the right format
    df <-
      dplyr::full_join(
        # dataframe comparing comparison details
        x = tidyr::gather(
          data = p_adjust_column_adder(rob_df_tidy, p.adjust.method),
          key = "key",
          value = "rowid",
          group1:group2
        ),
        # dataframe with factor levels
        y = enframe(x = wrs_obj$fnames, name = "rowid"),
        by = "rowid"
      ) %>%
      dplyr::select(.data = ., -rowid) %>%
      tidyr::spread(data = ., key = "key", value = "value")

    # for paired designs, there will be an unnecessary column to remove
    if (("p.crit") %in% names(df)) df %<>% dplyr::select(.data = ., -p.crit)

    # renaming confidence interval names
    df %<>% dplyr::rename(estimate = psihat, conf.low = ci.lower, conf.high = ci.upper)

    # test details
    test.details <- "Yuen's trimmed means test"
  }

  # ---------------------------- cleanup ----------------------------------

  # final cleanup for p-value labels
  df %<>%
    dplyr::mutate_if(
      .tbl = .,
      .predicate = is.factor,
      .funs = ~ as.character(.)
    ) %>%
    dplyr::rowwise() %>%
    dplyr::mutate(label = specify_decimal_p(x = p.value, k = k, p.value = TRUE)) %>%
    dplyr::mutate(
      test.details = test.details,
      p.value.adjustment = p_adjust_text(p.adjust.method)
    ) %>%
    dplyr::mutate(
      label = dplyr::case_when(
        label == "< 0.001" && p.value.adjustment != "None" ~ paste0(
          "list(~italic(p)[",
          p.value.adjustment,
          "-corrected]",
          "<=",
          "0.001",
          ")"
        ),
        label != "< 0.001" && p.value.adjustment != "None" ~ paste0(
          "list(~italic(p)[",
          p.value.adjustment,
          "-corrected]",
          "==",
          label,
          ")"
        ),
        label == "< 0.001" && p.value.adjustment == "None" ~ paste0(
          "list(~italic(p)[uncorrected]<=", "0.001", ")"
        ),
        label != "< 0.001" && p.value.adjustment == "None" ~ paste0(
          "list(~italic(p)[uncorrected]==", label, ")"
        )
      )
    ) %>%
    dplyr::select(.data = ., group1, group2, dplyr::everything()) %>%
    dplyr::arrange(group1, group2)

  # return
  return(dplyr::ungroup(df))
}

#' @name pairwise_comparisons
#' @aliases  pairwise_comparisons
#' @export

pairwise_p <- pairwise_comparisons
