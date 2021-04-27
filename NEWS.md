# pairwiseComparisons 3.1.5

  - To avoid confusion among users, the trimming level for all functions is now
    changed from `tr = 0.1` to `tr = 0.2` (which is what `WRS2` defaults to).

  - The `...` are now passed to other methods. This can be used to specify
    additional arguments, like `alternative` (#28).

  - Gets rid of `iris_long` dataset, which was not used in the package.

# pairwiseComparisons 3.1.3

  - Minor internal refactoring.

  - Removes `insight` from dependencies.

# pairwiseComparisons 3.1.2

  - Minor internal refactoring.

# pairwiseComparisons 3.1.1

  - Minor internal refactoring.

  - Removes the unnecessary (and confusing) `significance` column from all
    outputs.

# pairwiseComparisons 3.1.0

  - To be consistent with the rest of the `ggstatsverse`, the Bayes Factor
    results are now always shown in favor of null over alternative (`BF01`).

  - `pairwise_comparisons` function gets `subject.id` argument relevant for
    repeated measures design.

# pairwiseComparisons 3.0.0

  - The `label` column returned in `pairwise_comparisons` now displays the
    p-value adjustment method in the label itself.

  - `pairwise_caption` function has changed its output to reflect changes made
    to the *p*-value labels.

  - Major internal refactoring to get rid of the following dependencies:
    `broomExtra`, `dunn.test`, `forcats`, and `tidyr`. This comes at the cost of
    omission of few of the details that were previously included in the output
    (e.g., `mean.difference` column for Student's *t*-test).

# pairwiseComparisons 2.0.1

  - Hotfix release to fix failing tests due to release of `tidyBF 0.3.0`.

# pairwiseComparisons 2.0.0

  - Fixes a bug which affected results for within-subjects design when the
    dataframe wasn't sorted by `x` (#19).

  - This fix also now makes the results more consistent, such that irrespective
    of which type of statistics is chosen the `group1` and `group2` columns are
    in identical order.

# pairwiseComparisons 1.1.2

  - Hot fix release to address failing tests on the old release of `R` (`3.6`).

# pairwiseComparisons 1.1.1

  - For repeated measures datasets with `NA`s present, the Bayes Factor values
    were incorrect. This is fixed.

  - Internal refactoring to improve data wrangling using `ipmisc`.

# pairwiseComparisons 1.0.0

  - Removes dependence on `jmv` and instead relies on `dunn.test` and
    `PMCMRplus`. This significantly reduces number of dependencies.

  - The non-parametric Dwass test has been changed to Dunn test.

# pairwiseComparisons 0.3.1

  - Adapts to breaking changes in upcoming release of `broom 0.7.0`.

  - Thanks to Sarah, the package has a hexsticker. :)

# pairwiseComparisons 0.3.0

  - Due to changes made to downstream dependencies, the minimum R version
    expected is bumped to `3.6.0`.

  - Adds support for the Bayes Factor tests.

  - Exports the internal helper function `pairwise_caption`.

# pairwiseComparisons 0.2.5

  - Maintenance release to import functions from `ipmisc`.

# pairwiseComparisons 0.2.0

  - `pairwise_comparisons_caption` is removed since it was helpful only for
    `ggstatsplot`'s internal graphics display and wasn't of much utility outside
    of that context.

# pairwiseComparisons 0.1.3

  - Instead of cluttering the terminal with messages, `pairwise_comparisons`
    function now instead adds two columns (`test.details` and
    `p.value.adjustment`) to all outputs specifying which test was carried out
    and which adjustment method is being used for *p*-value correction.

  - Gets rid of `groupedstats` and `crayon` from dependencies.

# pairwiseComparisons 0.1.2

  - With `jmv 1.0.8`, the results from the Dwass-Steel-Crichtlow-Fligner test
    will be slightly different.

# pairwiseComparisons 0.1.1

  - The `p.value.label` in the output dataframe has been renamed to `label` to
    consider the possibility that Bayes Factor tests might also be supported in
    future.

  - The label now specified whether the *p*-value was adjusted or not for
    multiple comparisons.

# pairwiseComparisons 0.1.0

  - First release of the package.

