# within-subjects design - NAs --------------------------------------------------

test_that(
  desc = "`pairwise_comparisons()` works for within-subjects design - NAs",
  code = {
    options(tibble.width = Inf)

    # student's t test
    set.seed(123)
    df1 <-
      pairwise_comparisons(
        data = bugs_long,
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
      pairwise_comparisons(
        data = bugs_long,
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
      pairwise_comparisons(
        data = bugs_long,
        x = condition,
        y = desire,
        type = "r",
        k = 3,
        paired = TRUE,
        p.adjust.method = "hommel"
      )

    # bf
    set.seed(123)
    df4 <-
      pairwise_comparisons(
        data = bugs_long,
        x = condition,
        y = desire,
        type = "bf",
        k = 4,
        paired = TRUE
      )

    set.seed(123)
    expect_snapshot(list(df1, df2, df3, df4))
  }
)



# within-subjects design - no NAs ---------------------------------------------

test_that(
  desc = "`pairwise_comparisons()` works for within-subjects design - without NAs",
  code = {
    options(tibble.width = Inf)

    # student's t test
    set.seed(123)
    df1 <-
      pairwise_comparisons(
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
      pairwise_comparisons(
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
      pairwise_comparisons(
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
      pairwise_comparisons(
        data = WRS2::WineTasting,
        x = Wine,
        y = Taste,
        type = "bf",
        k = 4,
        paired = TRUE
      )

    expect_snapshot(list(df1, df2, df3, df4))
  }
)

# works with subject id ------------------------------------------------------

test_that(
  desc = "works with subject id",
  code = {
    skip_if(getRversion() < "3.6")

    set.seed(123)
    df1 <-
      dplyr::bind_rows(
        pairwise_comparisons(
          data = WRS2::WineTasting,
          x = Wine,
          y = "Taste",
          type = "p",
          k = 3,
          subject.id = "Taster",
          paired = TRUE
        ),
        pairwise_comparisons(
          data = WRS2::WineTasting,
          x = Wine,
          y = "Taste",
          type = "np",
          k = 3,
          subject.id = "Taster",
          paired = TRUE
        ),
        pairwise_comparisons(
          data = WRS2::WineTasting,
          x = Wine,
          y = "Taste",
          type = "r",
          k = 3,
          subject.id = "Taster",
          paired = TRUE
        ),
        pairwise_comparisons(
          data = WRS2::WineTasting,
          x = Wine,
          y = "Taste",
          type = "bf",
          k = 3,
          subject.id = "Taster",
          paired = TRUE
        )
      )

    set.seed(123)
    df2 <-
      dplyr::bind_rows(
        pairwise_comparisons(
          data = dplyr::arrange(WRS2::WineTasting, Taster),
          x = Wine,
          y = "Taste",
          type = "p",
          k = 3,
          paired = TRUE
        ),
        pairwise_comparisons(
          data = dplyr::arrange(WRS2::WineTasting, Taster),
          x = Wine,
          y = "Taste",
          type = "np",
          k = 3,
          paired = TRUE
        ),
        pairwise_comparisons(
          data = dplyr::arrange(WRS2::WineTasting, Taster),
          x = Wine,
          y = "Taste",
          type = "r",
          k = 3,
          paired = TRUE
        ),
        pairwise_comparisons(
          data = dplyr::arrange(WRS2::WineTasting, Taster),
          x = Wine,
          y = "Taste",
          type = "bf",
          k = 3,
          paired = TRUE
        )
      )

    # columns should be same no matter the test
    expect_equal(as.data.frame(df1), as.data.frame(df2))
  }
)
