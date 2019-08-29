#' @title Multiple pairwise comparison tests
#' @name pairwise_comparisons
#' @description Calculate parametric, non-parametric, and robust pairwise
#'   comparisons between group levels with corrections for multiple testing.
#' @author \href{https://github.com/IndrajeetPatil}{Indrajeet Patil}
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
#' @param messages Decides whether messages references, notes, and warnings are
#'   to be displayed (Default: `TRUE`).
#' @param k Number of digits after decimal point (should be an integer)
#'   (Default: `k = 2`).
#' @param ... Current ignored.
#' @inheritParams stats::t.test
#' @inheritParams WRS2::rmmcp
#'
#' @return A tibble dataframe containing two columns corresponding to group
#'   levels being compared with each other (`group1` and `group2`) and `p.value`
#'   column corresponding to this comparison. The dataframe will also contain a
#'   `p.value.label` column containing a *label* for this *p*-value, in case
#'   this needs to be displayed in `geom_ggsignif`. In addition to these common
#'   columns across the different types of statistics, there will be additional
#'   columns specific to the `type` of test being run.
#'
#'   The `significance` column will display asterisks to indicate significance
#'   of *p*-values in the American Psychological Association (APA) mandated
#'   format:
#'   \itemize{
#'   \item `ns` : > 0.05
#'   \item `*` : < 0.05
#'   \item `**` : < 0.01
#'   \item `***` : < 0.001
#'   }
#'
#' @importFrom dplyr select rename mutate mutate_if everything full_join vars
#' @importFrom dplyr group_nest
#' @importFrom stats p.adjust pairwise.t.test na.omit aov TukeyHSD var sd
#' @importFrom stringr str_replace
#' @importFrom WRS2 lincon rmmcp
#' @importFrom tidyr gather spread separate unnest nest
#' @importFrom rlang !! enquo as_string ensym
#' @importFrom tibble as_tibble rowid_to_column enframe
#' @importFrom jmv anovaNP anovaRMNP
#' @importFrom forcats fct_relabel
#' @importFrom purrr map
#'
#' @examples
#'
#' \donttest{
#' # show all columns in a tibble
#' options(tibble.width = Inf)
#'
#' #------------------- between-subjects design ----------------------------
#'
#' # for reproducibility
#' set.seed(123)
#' library(pairwiseComparisons)
#'
#' # parametric
#' # if `var.equal = TRUE`, then Student's *t*-test will be run
#' pairwise_comparisons(
#'   data = ggplot2::msleep,
#'   x = vore,
#'   y = brainwt,
#'   type = "parametric",
#'   var.equal = TRUE,
#'   paired = FALSE,
#'   p.adjust.method = "bonferroni"
#' )
#'
#' # if `var.equal = FALSE`, then Games-Howell test will be run
#' pairwise_comparisons(
#'   data = ggplot2::msleep,
#'   x = vore,
#'   y = brainwt,
#'   type = "parametric",
#'   var.equal = FALSE,
#'   paired = FALSE,
#'   p.adjust.method = "bonferroni"
#' )
#'
#' # non-parametric
#' pairwise_comparisons(
#'   data = ggplot2::msleep,
#'   x = vore,
#'   y = brainwt,
#'   type = "nonparametric",
#'   paired = FALSE,
#'   p.adjust.method = "none"
#' )
#'
#' # robust
#' pairwise_comparisons(
#'   data = ggplot2::msleep,
#'   x = vore,
#'   y = brainwt,
#'   type = "robust",
#'   paired = FALSE,
#'   p.adjust.method = "fdr"
#' )
#'
#' #------------------- within-subjects design ----------------------------
#'
#' # for reproducibility
#' set.seed(123)
#'
#' # parametric
#' pairwise_comparisons(
#'   data = bugs_long,
#'   x = condition,
#'   y = desire,
#'   type = "parametric",
#'   paired = TRUE,
#'   p.adjust.method = "BH"
#' )
#'
#' # non-parametric
#' pairwise_comparisons(
#'   data = bugs_long,
#'   x = condition,
#'   y = desire,
#'   type = "nonparametric",
#'   paired = TRUE,
#'   p.adjust.method = "BY"
#' )
#'
#' # robust
#' pairwise_comparisons(
#'   data = bugs_long,
#'   x = condition,
#'   y = desire,
#'   type = "robust",
#'   paired = TRUE,
#'   p.adjust.method = "hommel"
#' )
#' }
#' @export

# function body
pairwise_comparisons <- function(data,
                                 x,
                                 y,
                                 type = "parametric",
                                 tr = 0.1,
                                 paired = FALSE,
                                 var.equal = FALSE,
                                 p.adjust.method = "holm",
                                 k = 2,
                                 messages = TRUE,
                                 ...) {

  # ensure the arguments work quoted or unquoted
  x <- rlang::ensym(x)
  y <- rlang::ensym(y)

  # ---------------------------- data cleanup -------------------------------

  # creating a dataframe
  data %<>%
    dplyr::select(.data = ., {{ x }}, {{ y }}) %>%
    dplyr::mutate(.data = ., {{ x }} := droplevels(as.factor({{ x }}))) %>%
    tibble::as_tibble(x = .)

  # ---------------------------- parametric ---------------------------------

  if (type %in% c("parametric", "p")) {
    if (isTRUE(var.equal) || isTRUE(paired)) {
      # anova model
      aovmodel <- stats::aov(
        formula = rlang::new_formula({{ y }}, {{ x }}),
        data = data
      )

      # safeguarding against edge cases
      aovmodel$model %<>%
        dplyr::mutate(
          .data = .,
          {{ x }} := forcats::fct_relabel(
            .f = {{ x }},
            .fun = ~ stringr::str_replace(
              string = .x,
              pattern = "-",
              replacement = "_"
            )
          )
        )

      # extracting and cleaning up Tukey's HSD output
      df_tukey <-
        stats::TukeyHSD(x = aovmodel, conf.level = 0.95) %>%
        broomExtra::tidy(x = .) %>%
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
          .funs = ~ stringr::str_replace(
            string = .,
            pattern = "_",
            replacement = "-"
          )
        )

      # tidy dataframe with results from pairwise tests
      df_tidy <-
        broomExtra::tidy(
          stats::pairwise.t.test(
            x = data %>% dplyr::pull({{ y }}),
            g = data %>% dplyr::pull({{ x }}),
            p.adjust.method = p.adjust.method,
            paired = paired,
            alternative = "two.sided",
            na.action = na.omit
          )
        ) %>%
        signif_column(data = ., p = p.value)

      # combining mean difference and results from pairwise t-test
      df <-
        dplyr::full_join(
          x = df_tukey,
          y = df_tidy,
          by = c("group1", "group2")
        ) %>% # the group columns need to be swapped to be consistent
        dplyr::rename(.data = ., group2 = group1, group1 = group2) %>%
        dplyr::select(.data = ., group1, group2, dplyr::everything())

      # display message about the post hoc tests run
      if (isTRUE(messages)) {
        message(cat(
          crayon::green("Note: "),
          crayon::blue(
            "The parametric pairwise multiple comparisons test used-\n",
            "Student's t-test.\n",
            "Adjustment method for p-values: "
          ),
          crayon::yellow(p.adjust.method),
          sep = ""
        ))
      }
    } else {

      # dataframe with Games-Howell test results
      df <-
        games_howell(data = data, x = {{ x }}, y = {{ y }}) %>%
        p_adjust_column_adder(df = ., p.adjust.method = p.adjust.method) %>%
        dplyr::select(.data = ., -conf.low, -conf.high)

      # display message about the post hoc tests run
      if (isTRUE(messages)) {
        message(cat(
          crayon::green("Note: "),
          crayon::blue(
            "The parametric pairwise multiple comparisons test used-\n",
            "Games-Howell test.\n",
            "Adjustment method for p-values: "
          ),
          crayon::yellow(p.adjust.method),
          sep = ""
        ))
      }
    }
  }

  # ---------------------------- nonparametric ----------------------------

  if (type %in% c("nonparametric", "np")) {
    if (isFALSE(paired)) {
      # running Dwass-Steel-Crichtlow-Fligner test using `jmv` package
      jmv_pairs <-
        jmv::anovaNP(
          data = data,
          deps = rlang::as_string(y),
          group = rlang::as_string(x),
          pairs = TRUE
        )

      # extracting the pairwise tests and formatting the output
      df <-
        as.data.frame(x = jmv_pairs$comparisons[[1]]) %>%
        tibble::as_tibble(x = .) %>%
        dplyr::rename(
          .data = .,
          group1 = p1,
          group2 = p2,
          p.value = p
        ) %>%
        p_adjust_column_adder(df = ., p.adjust.method = p.adjust.method)

      # letting the user know which test was run
      if (isTRUE(messages)) {
        message(cat(
          crayon::green("Note: "),
          crayon::blue(
            "The nonparametric pairwise multiple comparisons test used-\n",
            "Dwass-Steel-Crichtlow-Fligner test.\n",
            "Adjustment method for p-values: "
          ),
          crayon::yellow(p.adjust.method),
          sep = ""
        ))
      }
    }

    # converting the entered long format data to wide format
    if (isTRUE(paired)) {
      data_wide <-
        long_to_wide_converter(data = data, x = {{ x }}, y = {{ y }})

      # running Durbin-Conover test using `jmv` package
      jmv_pairs <-
        jmv::anovaRMNP(
          data = data_wide,
          measures = names(data_wide[, -1]),
          pairs = TRUE
        )

      # extracting the pairwise tests and formatting the output
      df <-
        as.data.frame(x = jmv_pairs$comp) %>%
        tibble::as_tibble(x = .) %>%
        dplyr::select(.data = ., -sep) %>%
        dplyr::rename(
          .data = .,
          group1 = i1,
          group2 = i2,
          statistic = stat,
          p.value = p
        ) %>%
        p_adjust_column_adder(df = ., p.adjust.method = p.adjust.method)

      # letting the user know which test was run
      if (isTRUE(messages)) {
        message(cat(
          crayon::green("Note: "),
          crayon::blue(
            "The nonparametric pairwise multiple comparisons test used-\n",
            "Durbin-Conover test.\n",
            "Adjustment method for p-values: "
          ),
          crayon::yellow(p.adjust.method),
          sep = ""
        ))
      }
    }
  }

  # ---------------------------- robust ----------------------------------

  if (type %in% c("robust", "r")) {
    if (isFALSE(paired)) {
      # object with all details about pairwise comparisons
      rob_pairwise_df <-
        WRS2::lincon(
          formula = rlang::new_formula({{ y }}, {{ x }}),
          data = data,
          tr = tr
        )
    }

    # converting to long format and then getting it back in wide so that the
    # rowid variable can be used as the block variable
    if (isTRUE(paired)) {
      data %<>% df_cleanup_paired(data = ., x = {{ x }}, y = {{ y }})

      # running pairwise multiple comparison tests
      rob_pairwise_df <-
        WRS2::rmmcp(
          y = data[[rlang::as_name(y)]],
          groups = data[[rlang::as_name(x)]],
          blocks = data[["rowid"]],
          tr = tr
        )
    }

    # extracting the robust pairwise comparisons and tidying up names
    rob_df_tidy <-
      suppressMessages(tibble::as_tibble(
        x = rob_pairwise_df$comp,
        .name_repair = "unique"
      )) %>%
      dplyr::rename(
        .data = .,
        group1 = Group...1,
        group2 = Group...2
      )

    # cleaning the raw object and getting it in the right format
    df <-
      dplyr::full_join(
        # dataframe comparing comparison details
        x = rob_df_tidy %>%
          p_adjust_column_adder(df = ., p.adjust.method = p.adjust.method) %>%
          tidyr::gather(
            data = .,
            key = "key",
            value = "rowid",
            group1:group2
          ),
        # dataframe with factor levels
        y = rob_pairwise_df$fnames %>%
          tibble::enframe(x = ., name = "rowid"),
        by = "rowid"
      ) %>%
      dplyr::select(.data = ., -rowid) %>%
      tidyr::spread(data = ., key = "key", value = "value") %>%
      dplyr::select(.data = ., group1, group2, dplyr::everything())

    # for paired designs, there will be an unnecessary column to remove
    if (("p.crit") %in% names(df)) df %<>% dplyr::select(.data = ., -p.crit)

    # renaming confidence interval names
    df %<>% dplyr::rename(.data = ., conf.low = ci.lower, conf.high = ci.upper)

    # message about which test was run
    if (isTRUE(messages)) {
      message(cat(
        crayon::green("Note: "),
        crayon::blue(
          "The robust pairwise multiple comparisons test used-\n",
          "Yuen's trimmed means comparisons test.\n",
          "Adjustment method for p-values: "
        ),
        crayon::yellow(p.adjust.method),
        sep = ""
      ))
    }
  }

  # ---------------------------- bayes factor --------------------------------

  # print a message telling the user that this is currently not supported
  if (type %in% c("bf", "bayes")) {
    stop(message(cat(
      crayon::red("Warning: "),
      crayon::blue("No Bayes Factor pairwise comparisons currently available.\n"),
      sep = ""
    )),
    call. = FALSE
    )
  }

  # ---------------------------- cleanup ----------------------------------

  # if there are factors, covert them to character to make life easy
  df %<>%
    dplyr::mutate_if(
      .tbl = .,
      .predicate = is.factor,
      .funs = ~ as.character(.)
    ) %>%
    dplyr::mutate(.data = ., rowid = dplyr::row_number()) %>%
    dplyr::group_nest(.tbl = ., rowid) %>%
    dplyr::mutate(
      .data = .,
      label = data %>%
        purrr::map(
          .x = .,
          .f = ~ specify_decimal_p(x = .$p.value, k = k, p.value = TRUE)
        )
    )

  # unnesting the dataframe
  if (utils::packageVersion("tidyr") <= "0.8.9") {
    df %<>%tidyr::unnest(.)
  } else {
    df%<>% tidyr::unnest(., cols = c(data, label))
  }


  # formatting label
  df %<>%
    dplyr::mutate(
      .data = .,
      p.value.label = dplyr::case_when(
        label == "< 0.001" ~ paste("list(~italic(p)<=", "0.001", ")", sep = " "),
        TRUE ~ paste("list(~italic(p)==", label, ")", sep = " ")
      )
    ) %>%
    dplyr::select(.data = ., -label, -rowid)

  # return
  return(tibble::as_tibble(df))
}


#' @name pairwise_comparisons
#' @aliases  pairwise_comparisons
#' @export

pairwise_p <- pairwise_comparisons
