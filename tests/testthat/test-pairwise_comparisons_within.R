# within-subjects design - NAs --------------------------------------------------

testthat::test_that(
  desc = "`pairwise_comparisons()` works for within-subjects design - NAs",
  code = {

    # student's t test
    set.seed(123)
    df1 <-
      pairwiseComparisons::pairwise_comparisons(
        data = pairwiseComparisons::bugs_long,
        x = "condition",
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
        y = "desire",
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
        -1.14772727272727,
        -0.471590909090914,
        -2.16477272727272,
        0.676136363636358,
        -1.01704545454545,
        -1.69318181818181
      ),
      tolerance = 0.001
    )

    testthat::expect_identical(
      df1$label,
      c(
        "list(~italic(p)[adjusted]==0.003)",
        "list(~italic(p)[adjusted]==0.421)",
        "list(~italic(p)[adjusted]<=0.001)",
        "list(~italic(p)[adjusted]==0.337)",
        "list(~italic(p)[adjusted]==0.008)",
        "list(~italic(p)[adjusted]<=0.001)"
      )
    )

    testthat::expect_identical(
      df1$significance,
      c("**", "ns", "***", "ns", "**", "***")
    )

    testthat::expect_equal(
      df2$W,
      c(
        4.78004208516409,
        2.44393129166284,
        8.01465703001196,
        2.33611079350124,
        3.23461494484788,
        5.57072573834912
      ),
      tolerance = 0.001
    )

    testthat::expect_identical(
      df2$label,
      c(
        "list(~italic(p)[adjusted]<=0.001)",
        "list(~italic(p)[adjusted]==0.045)",
        "list(~italic(p)[adjusted]<=0.001)",
        "list(~italic(p)[adjusted]==0.050)",
        "list(~italic(p)[adjusted]==0.005)",
        "list(~italic(p)[adjusted]<=0.001)"
      )
    )

    testthat::expect_identical(
      df2$significance,
      c("***", "*", "***", "*", "**", "***")
    )

    testthat::expect_equal(
      df3$psihat,
      c(
        1.15972222222222,
        0.5,
        2.09722222222222,
        -0.701388888888889,
        0.9375,
        1.54166666666667
      ),
      tolerance = 0.001
    )

    testthat::expect_identical(
      df3$label,
      c(
        "list(~italic(p)[adjusted]==0.001)",
        "list(~italic(p)[adjusted]==0.062)",
        "list(~italic(p)[adjusted]<=0.001)",
        "list(~italic(p)[adjusted]==0.062)",
        "list(~italic(p)[adjusted]==0.014)",
        "list(~italic(p)[adjusted]<=0.001)"
      )
    )

    testthat::expect_identical(
      df3$significance,
      c("**", "ns", "***", "ns", "*", "***")
    )

    testthat::expect_identical(
      df4$label,
      c(
        "list(~log[e](BF[10])==3.7273)",
        "list(~log[e](BF[10])==-0.5394)",
        "list(~log[e](BF[10])==23.2071)",
        "list(~log[e](BF[10])==-0.3589)",
        "list(~log[e](BF[10])==2.8966)",
        "list(~log[e](BF[10])==15.3854)"
      )
    )

    # checking if it is a tibble
    testthat::expect_is(df1, "tbl_df")
    testthat::expect_is(df2, "tbl_df")
    testthat::expect_is(df3, "tbl_df")
    testthat::expect_is(df4, "tbl_df")

    # columns should be same no matter the test
    testthat::expect_identical(df1$group1, df2$group1)
    testthat::expect_identical(df1$group1, df3$group1)
    testthat::expect_identical(df1$group1, df4$group1)
    testthat::expect_identical(df1$group2, df2$group2)
    testthat::expect_identical(df1$group2, df3$group2)
    testthat::expect_identical(df1$group2, df4$group2)
  }
)



# within-subjects design - no NAs ---------------------------------------------

testthat::test_that(
  desc = "`pairwise_comparisons()` works for within-subjects design - NAs",
  code = {

    # student's t test
    set.seed(123)
    df1 <-
      pairwiseComparisons::pairwise_comparisons(
        data = WRS2::WineTasting,
        x = "Wine",
        y = Taste,
        type = "p",
        k = 3,
        paired = TRUE,
        p.adjust.method = "none"
      )

    # Durbin-Conover test
    set.seed(123)
    df2 <-
      pairwiseComparisons::pairwise_comparisons(
        data = WRS2::WineTasting,
        x = Wine,
        y = "Taste",
        type = "np",
        k = 3,
        paired = TRUE,
        p.adjust.method = "none"
      )

    # robust t test
    set.seed(123)
    df3 <-
      pairwiseComparisons::pairwise_comparisons(
        data = WRS2::WineTasting,
        x = Wine,
        y = Taste,
        type = "r",
        k = 3,
        paired = TRUE,
        p.adjust.method = "none"
      )

    # bf
    df4 <-
      pairwiseComparisons::pairwise_comparisons(
        data = WRS2::WineTasting,
        x = Wine,
        y = Taste,
        type = "bf",
        k = 4,
        paired = TRUE
      )

    # test details
    testthat::expect_identical(unique(df1$test.details), "Student's t-test")
    testthat::expect_identical(unique(df2$test.details), "Durbin-Conover test")
    testthat::expect_identical(unique(df3$test.details), "Yuen's trimmed means test")
    testthat::expect_identical(unique(df4$test.details), "Student's t-test")

    # adjustment method
    testthat::expect_identical(unique(df1$p.value.adjustment), "None")
    testthat::expect_identical(unique(df2$p.value.adjustment), "None")
    testthat::expect_identical(unique(df3$p.value.adjustment), "None")

    # checking exact values
    testthat::expect_equal(
      df1$mean.difference,
      c(
        -0.00909090909090882,
        -0.084090909090909,
        -0.0750000000000002
      ),
      tolerance = 0.001
    )

    testthat::expect_identical(
      df1$label,
      c(
        "list(~italic(p)[unadjusted]==0.732)",
        "list(~italic(p)[unadjusted]==0.014)",
        "list(~italic(p)[unadjusted]==0.001)"
      )
    )

    testthat::expect_identical(
      df1$significance,
      c("ns", "*", "***")
    )

    testthat::expect_equal(
      df2$W,
      c(1.04673405118638, 3.66356917915232, 2.61683512796594),
      tolerance = 0.001
    )

    testthat::expect_identical(
      df2$label,
      c(
        "list(~italic(p)[unadjusted]==0.301)",
        "list(~italic(p)[unadjusted]==0.001)",
        "list(~italic(p)[unadjusted]==0.012)"
      )
    )

    testthat::expect_identical(
      df2$significance,
      c("ns", "***", "*")
    )

    testthat::expect_equal(
      df3$psihat,
      c(0.0166666666666668, 0.1, 0.0777777777777778),
      tolerance = 0.001
    )

    testthat::expect_identical(
      df3$label,
      c(
        "list(~italic(p)[unadjusted]==0.380)",
        "list(~italic(p)[unadjusted]==0.011)",
        "list(~italic(p)[unadjusted]==0.003)"
      )
    )

    testthat::expect_identical(
      df3$significance,
      c("ns", "*", "**")
    )

    testthat::expect_identical(
      df4$label,
      c(
        "list(~log[e](BF[10])==-1.4462)",
        "list(~log[e](BF[10])==1.3122)",
        "list(~log[e](BF[10])==3.9214)"
      )
    )

    # columns should be same no matter the test
    testthat::expect_identical(df1$group1, df2$group1)
    testthat::expect_identical(df1$group1, df3$group1)
    testthat::expect_identical(df1$group1, df4$group1)
    testthat::expect_identical(df1$group2, df2$group2)
    testthat::expect_identical(df1$group2, df3$group2)
    testthat::expect_identical(df1$group2, df4$group2)
  }
)
