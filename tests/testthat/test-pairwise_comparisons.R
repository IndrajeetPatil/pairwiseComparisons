# between-subjects design --------------------------------------------------

testthat::test_that(
  desc = "`pairwise_comparisons()` works for between-subjects design",
  code = {
    set.seed(123)

    # student's t
    df1 <-
      pairwiseComparisons::pairwise_comparisons(
        data = ggplot2::msleep,
        x = vore,
        y = "brainwt",
        type = "p",
        var.equal = TRUE,
        paired = FALSE,
        p.adjust.method = "bonferroni"
      )

    # games-howell
    df_msleep <- ggplot2::msleep

    # adding empty factor level (shouldn't change results)
    df_msleep %<>%
      dplyr::mutate(
        vore = as.factor(vore),
        vore = forcats::fct_expand(vore, "random")
      )

    df2 <-
      pairwiseComparisons::pairwise_comparisons(
        data = df_msleep,
        x = "vore",
        y = brainwt,
        type = "p",
        var.equal = FALSE,
        paired = FALSE,
        p.adjust.method = "bonferroni"
      )

    # Dwass-Steel-Crichtlow-Fligner test
    df3 <-
      pairwiseComparisons::pairwise_comparisons(
        data = ggplot2::msleep,
        x = vore,
        y = brainwt,
        type = "np",
        paired = FALSE,
        p.adjust.method = "none"
      )

    # robust t test
    df4 <-
      pairwiseComparisons::pairwise_comparisons(
        data = ggplot2::msleep,
        x = vore,
        y = brainwt,
        type = "r",
        paired = FALSE,
        p.adjust.method = "fdr"
      )

    # checking the edge case where factor level names contain `-`
    set.seed(123)
    df5 <-
      pairwiseComparisons::pairwise_comparisons(
        data = movies_wide,
        x = mpaa,
        y = rating,
        var.equal = TRUE
      )

    # bayes test
    df6 <-
      pairwiseComparisons::pairwise_comparisons(
        data = ggplot2::msleep,
        x = vore,
        y = brainwt,
        type = "bf",
        k = 3
      )

    # checking dimensions of the results dataframe
    testthat::expect_equal(dim(df1), c(6L, 8L))
    testthat::expect_equal(dim(df2), c(6L, 11L))
    testthat::expect_equal(dim(df3), c(6L, 8L))
    testthat::expect_equal(dim(df4), c(6L, 10L))
    testthat::expect_equal(dim(df5), c(3L, 8L))
    testthat::expect_equal(dim(df6), c(6L, 12L))

    # test details
    testthat::expect_identical(unique(df1$test.details), "Student's t-test")
    testthat::expect_identical(unique(df2$test.details), "Games-Howell test")
    testthat::expect_identical(unique(df3$test.details), "Dwass-Steel-Crichtlow-Fligner test")
    testthat::expect_identical(unique(df4$test.details), "Yuen's trimmed means test")
    testthat::expect_identical(unique(df5$test.details), "Student's t-test")
    testthat::expect_identical(unique(df6$test.details), "Student's t-test")

    # adjustment method
    testthat::expect_identical(unique(df1$p.value.adjustment), "Bonferroni")
    testthat::expect_identical(unique(df2$p.value.adjustment), "Bonferroni")
    testthat::expect_identical(unique(df3$p.value.adjustment), "None")
    testthat::expect_identical(unique(df4$p.value.adjustment), "Benjamini & Hochberg")
    testthat::expect_identical(unique(df5$p.value.adjustment), "Holm")

    # testing exact values
    testthat::expect_equal(
      df1$mean.difference,
      c(
        0.54234194,
        -0.05770556,
        0.06647562,
        -0.60004750,
        -0.47586632,
        0.12418118
      ),
      tolerance = 0.001
    )

    testthat::expect_equal(
      df2$mean.difference,
      c(0.476, -0.066, -0.124, -0.542, -0.600, -0.058),
      tolerance = 0.001
    )

    testthat::expect_equal(
      df3$W,
      c(
        -0.8000000,
        -2.3570226,
        -1.7152791,
        -2.4019223,
        -0.9483623,
        1.6070259
      ),
      tolerance = 0.001
    )

    testthat::expect_equal(
      df4$psihat,
      c(
        -0.055602667,
        -0.052966319,
        0.002102889,
        0.055069208,
        0.057705556,
        0.110671875
      ),
      tolerance = 0.001
    )

    testthat::expect_equal(
      df1$group1,
      c("carni", "carni", "carni", "herbi", "herbi", "insecti")
    )
    testthat::expect_equal(
      df1$group2,
      c("herbi", "insecti", "omni", "insecti", "omni", "omni")
    )
    testthat::expect_equal(df5$group1, c("PG", "PG", "PG-13"))
    testthat::expect_equal(df5$group2, c("PG-13", "R", "R"))
    testthat::expect_equal(df5$mean.difference,
      c(0.1042746, 0.3234094, 0.2191348),
      tolerance = 0.001
    )
    testthat::expect_equal(df5$p.value,
      c(0.315931518, 0.002825407, 0.003100279),
      tolerance = 0.001
    )

    # checking labels
    testthat::expect_identical(
      df1$label,
      c(
        "list(~italic(p)[ adjusted ]== 1.000 )",
        "list(~italic(p)[ adjusted ]== 1.000 )",
        "list(~italic(p)[ adjusted ]== 1.000 )",
        "list(~italic(p)[ adjusted ]== 1.000 )",
        "list(~italic(p)[ adjusted ]== 0.979 )",
        "list(~italic(p)[ adjusted ]== 1.000 )"
      )
    )

    testthat::expect_identical(
      df2$label,
      c(
        "list(~italic(p)[ adjusted ]== 1.000 )",
        "list(~italic(p)[ adjusted ]== 1.000 )",
        "list(~italic(p)[ adjusted ]== 1.000 )",
        "list(~italic(p)[ adjusted ]== 1.000 )",
        "list(~italic(p)[ adjusted ]== 1.000 )",
        "list(~italic(p)[ adjusted ]== 1.000 )"
      )
    )

    testthat::expect_identical(
      df3$label,
      c(
        "list(~italic(p)[ unadjusted ]== 0.942 )",
        "list(~italic(p)[ unadjusted ]== 0.342 )",
        "list(~italic(p)[ unadjusted ]== 0.619 )",
        "list(~italic(p)[ unadjusted ]== 0.325 )",
        "list(~italic(p)[ unadjusted ]== 0.908 )",
        "list(~italic(p)[ unadjusted ]== 0.667 )"
      )
    )

    testthat::expect_identical(
      df4$label,
      c(
        "list(~italic(p)[ adjusted ]== 0.969 )",
        "list(~italic(p)[ adjusted ]== 0.969 )",
        "list(~italic(p)[ adjusted ]== 0.969 )",
        "list(~italic(p)[ adjusted ]== 0.969 )",
        "list(~italic(p)[ adjusted ]== 0.969 )",
        "list(~italic(p)[ adjusted ]== 0.969 )"
      )
    )

    testthat::expect_identical(
      df6$label,
      c(
        "list(~log[e](BF[10])==-0.560)",
        "list(~log[e](BF[10])==-0.851)",
        "list(~log[e](BF[10])==-0.606)",
        "list(~log[e](BF[10])==-0.617)",
        "list(~log[e](BF[10])==-0.616)",
        "list(~log[e](BF[10])==-0.332)"
      )
    )

    # checking tibble
    testthat::expect_is(df1, "tbl_df")
    testthat::expect_is(df2, "tbl_df")
    testthat::expect_is(df3, "tbl_df")
    testthat::expect_is(df4, "tbl_df")
    testthat::expect_is(df5, "tbl_df")
  }
)


# within-subjects design --------------------------------------------------

testthat::test_that(
  desc = "`pairwise_comparisons()` works for within-subjects design",
  code = {

    # student's t test
    set.seed(123)
    df1 <-
      pairwiseComparisons::pairwise_comparisons(
        data = pairwiseComparisons::bugs_long,
        x = condition,
        y = desire,
        type = "p",
        k = 3,
        paired = TRUE,
        p.adjust.method = "bonferroni"
      )

    # Durbin-Conover test
    set.seed(123)
    df2 <-
      pairwiseComparisons::pairwise_comparisons(
        data = pairwiseComparisons::bugs_long,
        x = condition,
        y = desire,
        type = "np",
        k = 3,
        paired = TRUE,
        p.adjust.method = "BY"
      )

    # robust t test
    set.seed(123)
    df3 <-
      pairwiseComparisons::pairwise_comparisons(
        data = pairwiseComparisons::bugs_long,
        x = condition,
        y = desire,
        type = "r",
        k = 3,
        paired = TRUE,
        p.adjust.method = "hommel"
      )

    # bf
    df4 <-
      pairwiseComparisons::pairwise_comparisons(
        data = bugs_long,
        x = condition,
        y = desire,
        type = "bf",
        k = 4,
        bf.prior = 0.9,
        paired = TRUE
      )

    # test details
    testthat::expect_identical(unique(df1$test.details), "Student's t-test")
    testthat::expect_identical(unique(df2$test.details), "Durbin-Conover test")
    testthat::expect_identical(unique(df3$test.details), "Yuen's trimmed means test")
    testthat::expect_identical(unique(df4$test.details), "Student's t-test")

    # adjustment method
    testthat::expect_identical(unique(df1$p.value.adjustment), "Bonferroni")
    testthat::expect_identical(unique(df2$p.value.adjustment), "Benjamini & Yekutieli")
    testthat::expect_identical(unique(df3$p.value.adjustment), "Hommel")

    # checking exact values
    testthat::expect_equal(
      df1$mean.difference,
      c(
        -1.1115026,
        -0.4741400,
        -2.1382071,
        0.6373626,
        -1.0267045,
        -1.6640671
      ),
      tolerance = 0.001
    )

    testthat::expect_identical(
      df1$label,
      c(
        "list(~italic(p)[ adjusted ]== 0.003 )",
        "list(~italic(p)[ adjusted ]== 0.424 )",
        "list(~italic(p)[ adjusted ]<= 0.001 )",
        "list(~italic(p)[ adjusted ]== 0.274 )",
        "list(~italic(p)[ adjusted ]== 0.006 )",
        "list(~italic(p)[ adjusted ]<= 0.001 )"
      )
    )

    testthat::expect_identical(
      df1$significance,
      c("**", "ns", "***", "ns", "**", "***")
    )

    testthat::expect_equal(
      df2$statistic,
      c(4.780042, 2.443931, 8.014657, 2.336111, 3.234615, 5.570726),
      tolerance = 0.001
    )

    testthat::expect_identical(
      df2$label,
      c(
        "list(~italic(p)[ adjusted ]<= 0.001 )",
        "list(~italic(p)[ adjusted ]== 0.045 )",
        "list(~italic(p)[ adjusted ]<= 0.001 )",
        "list(~italic(p)[ adjusted ]== 0.050 )",
        "list(~italic(p)[ adjusted ]== 0.005 )",
        "list(~italic(p)[ adjusted ]<= 0.001 )"
      )
    )

    testthat::expect_identical(
      df2$significance,
      c("***", "*", "***", "*", "**", "***")
    )

    testthat::expect_equal(
      df3$psihat,
      c(
        -0.7013889,
        0.5000000,
        0.9375000,
        1.1597222,
        1.5416667,
        2.0972222
      ),
      tolerance = 0.001
    )

    testthat::expect_identical(
      df3$label,
      c(
        "list(~italic(p)[ adjusted ]== 0.062 )",
        "list(~italic(p)[ adjusted ]== 0.062 )",
        "list(~italic(p)[ adjusted ]== 0.014 )",
        "list(~italic(p)[ adjusted ]== 0.001 )",
        "list(~italic(p)[ adjusted ]<= 0.001 )",
        "list(~italic(p)[ adjusted ]<= 0.001 )"
      )
    )

    testthat::expect_identical(
      df3$significance,
      c("ns", "ns", "*", "**", "***", "***")
    )

    testthat::expect_identical(
      df4$label,
      c(
        "list(~log[e](BF[10])==1.5536)",
        "list(~log[e](BF[10])==-1.0261)",
        "list(~log[e](BF[10])==10.5197)",
        "list(~log[e](BF[10])==-0.9107)",
        "list(~log[e](BF[10])==0.9789)",
        "list(~log[e](BF[10])==6.9598)"
      )
    )

    # checking dimensions of the results dataframe
    testthat::expect_equal(dim(df1), c(6L, 8L))
    testthat::expect_equal(dim(df2), c(6L, 8L))
    testthat::expect_equal(dim(df3), c(6L, 10L))
    testthat::expect_equal(dim(df4), c(6L, 12L))

    # checking if it is a tibble
    testthat::expect_is(df1, "tbl_df")
    testthat::expect_is(df2, "tbl_df")
    testthat::expect_is(df3, "tbl_df")
    testthat::expect_is(df4, "tbl_df")
  }
)

# dropped levels --------------------------------------------------

testthat::test_that(
  desc = "dropped levels are not included",
  code = {
    set.seed(123)

    # drop levels
    msleep2 <- dplyr::filter(
      .data = ggplot2::msleep,
      vore %in% c("carni", "omni")
    )

    # check those levels are not included
    df1 <-
      pairwiseComparisons::pairwise_comparisons(
        data = msleep2,
        x = vore,
        y = brainwt,
        p.adjust.method = "none"
      )

    df2 <-
      pairwiseComparisons::pairwise_comparisons(
        data = ggplot2::msleep,
        x = vore,
        y = brainwt,
        p.adjust.method = "none"
      ) %>%
      dplyr::filter(.data = ., group1 == "omni", group2 == "carni")

    # tests
    testthat::expect_equal(dim(df1), c(1L, 11L))
    testthat::expect_equal(df1$mean.difference, df2$mean.difference, tolerance = 0.01)
    testthat::expect_equal(df1$se, df2$se, tolerance = 0.01)
    testthat::expect_equal(df1$t.value, df2$t.value, tolerance = 0.01)
    testthat::expect_equal(df1$df, df2$df, tolerance = 0.01)
    testthat::expect_identical(df2$label, "list(~italic(p)[ unadjusted ]== 0.865 )")
  }
)

# irregular names --------------------------------------------------

testthat::test_that(
  desc = "check if everything works fine with irregular factor level names",
  code = {
    set.seed(123)

    df <-
      pairwiseComparisons::pairwise_comparisons(
        data = movies_wide,
        x = mpaa,
        y = rating,
        type = "p",
        var.equal = TRUE
      )

    testthat::expect_equal(dim(df), c(3L, 8L))
    testthat::expect_equal(df$group1, c("PG", "PG", "PG-13"))
    testthat::expect_equal(df$group2, c("PG-13", "R", "R"))
  }
)
