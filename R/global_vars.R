# defining global variables and functions to appease R CMD Check

utils::globalVariables(
  names = c(
    ".",
    "Group...1",
    "Group...2",
    "bf10",
    "ci.lower",
    "ci.upper",
    "group1",
    "group2",
    "log_e_bf10",
    "p.value",
    "psihat"
  ),
  package = "pairwiseComparisons",
  add = FALSE
)
