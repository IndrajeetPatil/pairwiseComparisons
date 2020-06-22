#' @title Multiple pairwise comparison tests with tidy data
#' @name pairwise_comparisons
#' @description Calculate parametric, non-parametric, and robust pairwise
#'   comparisons between group levels with corrections for multiple testing.
#'
#' @param data A dataframe (or a tibble) from which variables specified are to
#'   be taken. A matrix or tables will **not** be accepted.
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
#' @importFrom stats p.adjust pairwise.t.test na.omit aov TukeyHSD
#' @importFrom WRS2 lincon rmmcp
#' @importFrom tidyr gather spread separate
#' @importFrom dunn.test dunn.test
#' @importFrom PMCMRplus durbinAllPairsTest
#' @importFrom rlang !! enquo as_string ensym
#' @importFrom forcats fct_relabel
#' @importFrom purrr map2 map_dfr
#' @importFrom broomExtra tidy easystats_to_tidy_names
#' @importFrom ipmisc stats_type_switch
#' @importFrom tidyBF bf_ttest
#' @importFrom utils capture.output
#'
#' @examples
#'
#' \donttest{
#' # for reproducibility
#' set.seed(123)
#' library(pairwiseComparisons)
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
  x <- rlang::ensym(x)
  y <- rlang::ensym(y)

  # ---------------------------- data cleanup -------------------------------

  # creating a dataframe
  df_internal <-
    long_to_wide_converter(
      data = data,
      x = {{ x }},
      y = {{ y }},
      paired = paired,
      spread = FALSE
    )

  # ---------------------------- parametric ---------------------------------

  if (type %in% c("parametric", "bayes")) {
    if (isTRUE(var.equal) || isTRUE(paired)) {
      # anova model
      aovmodel <- stats::aov(
        formula = rlang::new_formula({{ y }}, {{ x }}),
        data = df_internal
      )

      # safeguarding against edge cases
      aovmodel$model %<>%
        dplyr::mutate(
          .data = .,
          {{ x }} := forcats::fct_relabel(
            .f = {{ x }},
            .fun = ~ gsub(
              x = .x,
              pattern = "-",
              replacement = "_"
            )
          )
        )

      # extracting and cleaning up Tukey's HSD output
      df_tukey <-
        stats::TukeyHSD(x = aovmodel, conf.level = 0.95) %>%
        broomExtra::tidy(.)

      # breaking change in `broom 0.7.0`
      if ("contrast" %in% names(df_tukey)) {
        df_tukey %<>% dplyr::rename(.data = ., comparison = contrast)
      }

      # cleanup
      df_tukey %<>%
        dplyr::select(.data = ., comparison, estimate) %>%
        tidyr::separate(
          data = .,
          col = comparison,
          into = c("group1", "group2"),
          sep = "-"
        ) %>%
        dplyr::rename(.data = ., mean.difference = estimate) %>%
        dplyr::mutate_at(
          .tbl = .,
          .vars = dplyr::vars(dplyr::matches("^group[0-9]$")),
          .funs = ~ gsub(
            x = .,
            pattern = "_",
            replacement = "-"
          )
        )

      # tidy dataframe with results from pairwise tests
      df_tidy <-
        broomExtra::tidy(
          stats::pairwise.t.test(
            x = df_internal %>% dplyr::pull({{ y }}),
            g = df_internal %>% dplyr::pull({{ x }}),
            p.adjust.method = "none",
            paired = paired,
            alternative = "two.sided",
            na.action = na.omit
          )
        ) %>%
        p_adjust_column_adder(df = ., p.adjust.method = p.adjust.method)

      # combining mean difference and results from pairwise t-test
      df <-
        dplyr::full_join(x = df_tukey, y = df_tidy, by = c("group1", "group2")) %>%
        dplyr::rename(.data = ., group2 = group1, group1 = group2)

      # test details
      test.details <- "Student's t-test"
    } else {
      # dataframe with Games-Howell test results
      df <-
        games_howell(data = df_internal, x = {{ x }}, y = {{ y }}) %>%
        p_adjust_column_adder(df = ., p.adjust.method = p.adjust.method) %>%
        dplyr::select(.data = ., -conf.low, -conf.high)

      # test details
      test.details <- "Games-Howell test"
    }
  }

  # ---------------------------- bayes factor --------------------------------

  # print a message telling the user that this is currently not supported
  if (type == "bayes") {
    # creating a list of dataframes with subsections of data
    df_list <-
      purrr::map2(
        .x = as.character(df$group1),
        .y = as.character(df$group2),
        .f = function(a, b) droplevels(dplyr::filter(df_internal, {{ x }} %in% c(a, b)))
      )

    # combining results into a single dataframe and returning it
    df_tidy <-
      purrr::map_dfr(
        .x = df_list,
        .f = ~ tidyBF::bf_ttest(
          data = .x,
          x = {{ x }},
          y = {{ y }},
          paired = paired,
          bf.prior = bf.prior,
          output = "results"
        )
      ) %>%
      dplyr::rowwise() %>%
      dplyr::mutate(label = paste(
        "list(~log[e](BF[10])",
        "==",
        specify_decimal_p(x = log_e_bf10, k = k),
        ")",
        sep = ""
      )) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(.data = ., test.details = "Student's t-test") %>%
      dplyr::mutate_if(
        .tbl = .,
        .predicate = is.factor,
        .funs = ~ as.character(.)
      )

    # early return (no further cleanup required)
    return(dplyr::bind_cols(dplyr::select(df, group1, group2), df_tidy))
  }

  # ---------------------------- nonparametric ----------------------------

  if (type == "nonparametric") {
    if (isFALSE(paired)) {
      # running Dunn test
      invisible(utils::capture.output(df <-
        as.data.frame(
          dunn.test::dunn.test(
            x = df_internal %>% dplyr::pull({{ y }}),
            g = df_internal %>% dplyr::pull({{ x }}),
            table = FALSE,
            kw = FALSE,
            label = FALSE,
            alpha = 0.05,
            method = "none",
            altp = TRUE
          )
        ), file = NULL))

      # cleanup
      df %<>%
        as_tibble(.) %>%
        broomExtra::easystats_to_tidy_names(.) %>%
        dplyr::mutate(z.value = abs(statistic)) %>%
        dplyr::select(
          .data = .,
          comparisons,
          z.value,
          "p.value" = "altp.adjusted",
          dplyr::everything(),
          -c(chi2:altp)
        ) %>%
        tidyr::separate(
          data = .,
          col = "comparisons",
          into = c("group1", "group2"),
          sep = " - ",
          remove = TRUE
        )

      # test details
      test.details <- "Dunn test"
    }

    # converting the entered long format data to wide format
    if (isTRUE(paired)) {
      x_vec <- df_internal %>% dplyr::pull({{ x }})
      y_vec <- df_internal %>% dplyr::pull({{ y }})

      # creating model object
      mod <-
        PMCMRplus::durbinAllPairsTest(
          y = na.omit(matrix(
            data = y_vec,
            ncol = length(unique(x_vec)),
            dimnames = list(
              seq(1, length(y_vec) / length(unique(x_vec))),
              unique(x_vec)
            )
          )),
          p.adjust.method = "none"
        )

      # combining into one dataframe
      df <-
        dplyr::bind_cols(
          matrix_to_tidy(m = mod$statistic, col_names = c("group1", "group2", "W")),
          dplyr::select(
            matrix_to_tidy(m = mod$p.value, col_names = c("group1", "group2", "p.value")),
            -dplyr::contains("group")
          )
        )

      # test details
      test.details <- "Durbin-Conover test"
    }

    # cleanup
    df %<>% p_adjust_column_adder(df = ., p.adjust.method = p.adjust.method)
  }

  # ---------------------------- robust ----------------------------------

  if (type == "robust") {
    if (isFALSE(paired)) {
      # object with all details about pairwise comparisons
      rob_pairwise_df <-
        WRS2::lincon(
          formula = rlang::new_formula({{ y }}, {{ x }}),
          data = df_internal,
          tr = tr
        )
    }

    # converting to long format and then getting it back in wide so that the
    # rowid variable can be used as the block variable
    if (isTRUE(paired)) {
      # running pairwise multiple comparison tests
      rob_pairwise_df <-
        WRS2::rmmcp(
          y = df_internal[[rlang::as_name(y)]],
          groups = df_internal[[rlang::as_name(x)]],
          blocks = df_internal[["rowid"]],
          tr = tr
        )
    }

    # extracting the robust pairwise comparisons and tidying up names
    rob_df_tidy <-
      suppressMessages(as_tibble(rob_pairwise_df$comp, .name_repair = "unique")) %>%
      dplyr::rename(group1 = Group...1, group2 = Group...2)

    # cleaning the raw object and getting it in the right format
    df <-
      dplyr::full_join(
        # dataframe comparing comparison details
        x = p_adjust_column_adder(df = rob_df_tidy, p.adjust.method = p.adjust.method) %>%
          tidyr::gather(
            data = .,
            key = "key",
            value = "rowid",
            group1:group2
          ),
        # dataframe with factor levels
        y = enframe(x = rob_pairwise_df$fnames, name = "rowid"),
        by = "rowid"
      ) %>%
      dplyr::select(.data = ., -rowid) %>%
      tidyr::spread(data = ., key = "key", value = "value")

    # for paired designs, there will be an unnecessary column to remove
    if (("p.crit") %in% names(df)) df %<>% dplyr::select(.data = ., -p.crit)

    # renaming confidence interval names
    df %<>% dplyr::rename(.data = ., conf.low = ci.lower, conf.high = ci.upper)

    # test details
    test.details <- "Yuen's trimmed means test"
  }

  # ---------------------------- cleanup ----------------------------------

  # formatting label
  adjust_text <- ifelse(p.adjust.method == "none", "unadjusted", "adjusted")

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
      label = dplyr::case_when(
        label == "< 0.001" ~ paste("list(~italic(p)[", adjust_text, "]<=", "0.001", ")", sep = " "),
        TRUE ~ paste("list(~italic(p)[", adjust_text, "]==", label, ")", sep = " ")
      )
    ) %>%
    dplyr::mutate(
      test.details = test.details,
      p.value.adjustment = p_adjust_text(p.adjust.method)
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
