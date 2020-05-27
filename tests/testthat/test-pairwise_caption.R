# pairwise_caption works ------------------------------------------------

testthat::test_that(
  desc = "pairwise_caption works",
  code = {
    expr1 <- pairwise_caption("my caption", "Student's t-test", "holm")
    expr2 <- pairwise_caption(NULL, "Yuen's t-test", "none")

    testthat::expect_identical(
      as.character(expr1),
      c(
        "atop",
        "displaystyle(\"my caption\")",
        "paste(\"Pairwise comparisons: \", bold(\"Student's t-test\"), \"; Adjustment (p-value): \", bold(\"Holm\"))"
      )
    )

    testthat::expect_identical(
      as.character(expr2),
      c(
        "atop",
        "displaystyle(NULL)",
        "paste(\"Pairwise comparisons: \", bold(\"Yuen's t-test\"), \"; Adjustment (p-value): \", bold(\"None\"))"
      )
    )
  }
)
