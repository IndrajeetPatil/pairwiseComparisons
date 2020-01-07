Tests and Coverage
================
06 January, 2020 23:45:53

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                                   | Coverage (%) |
| :------------------------------------------------------- | :----------: |
| pairwiseComparisons                                      |     100      |
| [R/games\_howell.R](../R/games_howell.R)                 |     100      |
| [R/helpers.R](../R/helpers.R)                            |     100      |
| [R/pairwise\_comparisons.R](../R/pairwise_comparisons.R) |     100      |
| [R/utils\_formatting.R](../R/utils_formatting.R)         |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                                       |  n |  time | error | failed | skipped | warning |
| :------------------------------------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: |
| [test-long\_to\_wide\_converter.R](testthat/test-long_to_wide_converter.R) |  4 |  0.06 |     0 |      0 |       0 |       0 |
| [test-pairwise\_comparisons.R](testthat/test-pairwise_comparisons.R)       | 63 | 10.14 |     0 |      0 |       0 |       0 |
| [test-switch\_statements.R](testthat/test-switch_statements.R)             |  9 |  0.00 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                                           | context                   |                               test                               | status |  n | time |
| :----------------------------------------------------------------------------- | :------------------------ | :--------------------------------------------------------------: | :----- | -: | ---: |
| [test-long\_to\_wide\_converter.R](testthat/test-long_to_wide_converter.R#L26) | long\_to\_wide\_converter |                 long\_to\_wide\_converter works                  | PASS   |  4 | 0.06 |
| [test-pairwise\_comparisons.R](testthat/test-pairwise_comparisons.R#L62)       | pairwise\_comparisons     |    `pairwise_comparisons()` works for between-subjects design    | PASS   | 32 | 9.13 |
| [test-pairwise\_comparisons.R](testthat/test-pairwise_comparisons.R#L240_L248) | pairwise\_comparisons     |    `pairwise_comparisons()` works for within-subjects design     | PASS   | 22 | 0.37 |
| [test-pairwise\_comparisons.R](testthat/test-pairwise_comparisons.R#L386)      | pairwise\_comparisons     |                 dropped levels are not included                  | PASS   |  6 | 0.61 |
| [test-pairwise\_comparisons.R](testthat/test-pairwise_comparisons.R#L410)      | pairwise\_comparisons     | check if everything works fine with irregular factor level names | PASS   |  3 | 0.03 |
| [test-switch\_statements.R](testthat/test-switch_statements.R#L8)              | switch statements         |                  switch for p adjustment works                   | PASS   |  9 | 0.00 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                            |
| :------- | :------------------------------- |
| Version  | R version 3.6.2 (2019-12-12)     |
| Platform | x86\_64-w64-mingw32/x64 (64-bit) |
| Running  | Windows 10 x64 (build 16299)     |
| Language | English\_United States           |
| Timezone | Europe/Berlin                    |

| Package  | Version |
| :------- | :------ |
| testthat | 2.3.1   |
| covr     | 3.4.0   |
| covrpage | 0.0.70  |

</details>

<!--- Final Status : pass --->
