# defining global variables and functions to appease R CMD Check

utils::globalVariables(
  names = c(
    ".",
    "bayes.factor",
    "bf10",
    "group1",
    "group2",
    "log_e_bf10",
    "p.value",
    "psihat"
  ),
  package = "pairwiseComparisons",
  add = FALSE
)
