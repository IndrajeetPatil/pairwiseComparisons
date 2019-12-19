# pairwiseComparisons 0.1.3.9000

# pairwiseComparisons 0.1.3

MINOR CHANGES

  - Instead of cluttering the terminal with messages, `pairwise_comparisons`
    function now instead adds two columns (`test.details` and
    `p.value.adjustment`) to all outputs specifying which test was carried out
    and which adjustment method is being used for *p*-value correction.
  - Gets rid of `groupedstats` and `crayon` from dependencies.

# pairwiseComparisons 0.1.2

MINOR CHANGES

  - With `jmv 1.0.8`, the results from the Dwass-Steel-Crichtlow-Fligner test
    will be slightly different.

# pairwiseComparisons 0.1.1

BREAKING CHANGES

  - The `p.value.label` in the output dataframe has been renamed to `label` to
    consider the possibility that Bayes Factor tests might also be supported in
    future.
  - The label now specified whether the *p*-value was adjusted or not for
    multiple comparisons.

# pairwiseComparisons 0.1.0

  - First release of the package.
