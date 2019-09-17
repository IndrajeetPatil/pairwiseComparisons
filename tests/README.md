Tests and Coverage
================
17 September, 2019 09:56:46

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                                                    | Coverage (%) |
| :------------------------------------------------------------------------ | :----------: |
| pairwiseComparisons                                                       |     100      |
| [R/games\_howell.R](../R/games_howell.R)                                  |     100      |
| [R/helpers.R](../R/helpers.R)                                             |     100      |
| [R/long\_to\_wide\_converter.R](../R/long_to_wide_converter.R)            |     100      |
| [R/pairwise\_comparisons.R](../R/pairwise_comparisons.R)                  |     100      |
| [R/pairwise\_comparisons\_caption.R](../R/pairwise_comparisons_caption.R) |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                                                  |  n |  time | error | failed | skipped | warning |
| :------------------------------------------------------------------------------------ | -: | ----: | ----: | -----: | ------: | ------: |
| [test-long\_to\_wide\_converter.R](testthat/test-long_to_wide_converter.R)            |  4 |  0.08 |     0 |      0 |       0 |       0 |
| [test-pairwise\_comparisons.R](testthat/test-pairwise_comparisons.R)                  | 62 | 20.45 |     0 |      0 |       0 |       0 |
| [test-pairwise\_comparisons\_caption.R](testthat/test-pairwise_comparisons_caption.R) |  5 |  0.00 |     0 |      0 |       0 |       0 |
| [test-switch\_statements.R](testthat/test-switch_statements.R)                        |  9 |  0.01 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                                                          | context                        | test                                                               | status |  n | time |
| :-------------------------------------------------------------------------------------------- | :----------------------------- | :----------------------------------------------------------------- | :----- | -: | ---: |
| [test-long\_to\_wide\_converter.R](testthat/test-long_to_wide_converter.R#L26)                | long\_to\_wide\_converter      | long\_to\_wide\_converter works                                    | PASS   |  4 | 0.08 |
| [test-pairwise\_comparisons.R](testthat/test-pairwise_comparisons.R#L67)                      | pairwise\_comparisons          | `pairwise_comparisons()` works for between-subjects design         | PASS   | 22 | 9.73 |
| [test-pairwise\_comparisons.R](testthat/test-pairwise_comparisons.R#L234_L245)                | pairwise\_comparisons          | `pairwise_comparisons()` works for within-subjects design          | PASS   | 15 | 0.22 |
| [test-pairwise\_comparisons.R](testthat/test-pairwise_comparisons.R#L348)                     | pairwise\_comparisons          | `pairwise_comparisons()` messages are correct for between-subjects | PASS   |  9 | 9.38 |
| [test-pairwise\_comparisons.R](testthat/test-pairwise_comparisons.R#L427)                     | pairwise\_comparisons          | `pairwise_comparisons()` messages are correct for within-subjects  | PASS   |  7 | 0.40 |
| [test-pairwise\_comparisons.R](testthat/test-pairwise_comparisons.R#L505)                     | pairwise\_comparisons          | dropped levels are not included                                    | PASS   |  6 | 0.66 |
| [test-pairwise\_comparisons.R](testthat/test-pairwise_comparisons.R#L530)                     | pairwise\_comparisons          | check if everything works fine with irregular factor level names   | PASS   |  3 | 0.06 |
| [test-pairwise\_comparisons\_caption.R](testthat/test-pairwise_comparisons_caption.R#L46_L57) | pairwise\_comparisons\_caption | `pairwise_comparisons_caption()` works                             | PASS   |  5 | 0.00 |
| [test-switch\_statements.R](testthat/test-switch_statements.R#L8)                             | switch statements              | switch for p adjustment works                                      | PASS   |  9 | 0.01 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                            |
| :------- | :------------------------------- |
| Version  | R version 3.6.1 (2019-07-05)     |
| Platform | x86\_64-w64-mingw32/x64 (64-bit) |
| Running  | Windows 10 x64 (build 16299)     |
| Language | English\_United States           |
| Timezone | Europe/Berlin                    |

| Package  | Version |
| :------- | :------ |
| testthat | 2.2.1   |
| covr     | 3.3.1   |
| covrpage | 0.0.70  |

</details>

<!--- Final Status : pass --->
