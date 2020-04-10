# pairwise_caption works ------------------------------------------------

testthat::test_that(
  desc = "pairwise_caption works",
  code = {
    expr1 <- pairwise_caption("my caption", "Student's t-test", "holm")
    expr2 <- pairwise_caption(NULL, "Yuen's t-test", "none")

    testthat::expect_identical(
      expr1,
      ggplot2::expr(atop(
        displaystyle("my caption"),
        expr = paste(
          "Pairwise comparisons: ",
          bold("Student's t-test"),
          "; Adjustment (p-value): ",
          bold("Holm")
        )
      ))
    )

    testthat::expect_identical(
      expr2,
      ggplot2::expr(atop(
        displaystyle(NULL),
        expr = paste(
          "Pairwise comparisons: ",
          bold("Yuen's t-test"),
          "; Adjustment (p-value): ",
          bold("None")
        )
      ))
    )
  }
)
