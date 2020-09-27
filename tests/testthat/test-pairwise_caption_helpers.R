# pairwise_caption works ------------------------------------------------

testthat::test_that(
  desc = "pairwise_caption works",
  code = {
    expr1 <- pairwise_caption("my caption", "Student's t-test", "s")
    expr2 <- pairwise_caption(NULL, "Yuen's t-test", "ns")
    expr3 <- pairwise_caption(NULL, "Yuen's t-test", "all")
    expr4 <- pairwise_caption("my caption", "Student's t-test", "sig")

    testthat::expect_identical(
      as.character(expr1),
      c(
        "atop",
        "displaystyle(\"my caption\")",
        "paste(\"Pairwise test: \", bold(\"Student's t-test\"), \"; Comparisons shown: \", bold(\"only significant\"))"
      )
    )

    testthat::expect_identical(
      as.character(expr2),
      c(
        "atop",
        "displaystyle(NULL)",
        "paste(\"Pairwise test: \", bold(\"Yuen's t-test\"), \"; Comparisons shown: \", bold(\"only non-significant\"))"
      )
    )

    testthat::expect_identical(
      as.character(expr3),
      c(
        "atop",
        "displaystyle(NULL)",
        "paste(\"Pairwise test: \", bold(\"Yuen's t-test\"), \"; Comparisons shown: \", bold(\"all\"))"
      )
    )

    testthat::expect_identical(as.character(expr1), as.character(expr4))
  }
)

# switch for p adjustment ------------------------------------------------

testthat::test_that(
  desc = "switch for p adjustment works",
  code = {
    testthat::expect_error(p_adjust_text(NULL))
    testthat::expect_identical(p_adjust_text("none"), "None")
    testthat::expect_identical(
      p_adjust_text("fdr"),
      p_adjust_text("BH")
    )
    testthat::expect_identical(p_adjust_text("hochberg"), "Hochberg")
    testthat::expect_identical(p_adjust_text("bonferroni"), "Bonferroni")
    testthat::expect_identical(p_adjust_text("holm"), "Holm")
    testthat::expect_identical(p_adjust_text("hommel"), "Hommel")
    testthat::expect_identical(p_adjust_text("BY"), "BY")
    testthat::expect_identical(p_adjust_text("xyz"), "Holm")
  }
)
