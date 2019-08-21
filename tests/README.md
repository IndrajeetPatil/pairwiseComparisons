Tests and Coverage
================
21 August, 2019 15:06:24

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                                                    | Coverage (%) |
| :------------------------------------------------------------------------ | :----------: |
| pairwiseComparisons                                                       |    99.29     |
| [R/helpers.R](../R/helpers.R)                                             |    93.75     |
| [R/pairwise\_comparisons\_caption.R](../R/pairwise_comparisons_caption.R) |    95.00     |
| [R/games\_howell.R](../R/games_howell.R)                                  |    100.00    |
| [R/long\_to\_wide\_converter.R](../R/long_to_wide_converter.R)            |    100.00    |
| [R/pairwise\_comparisons.R](../R/pairwise_comparisons.R)                  |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                                       |  n |  time | error | failed | skipped | warning |
| :------------------------------------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: |
| [test-long\_to\_wide\_converter.R](testthat/test-long_to_wide_converter.R) |  4 |  0.08 |     0 |      0 |       0 |       0 |
| [test-pairwise\_p.R](testthat/test-pairwise_p.R)                           | 60 | 17.58 |     0 |      0 |       0 |       0 |
| [test-switch\_statements.R](testthat/test-switch_statements.R)             |  7 |  0.00 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                                           | context                        | test                                                               | status |  n | time |
| :----------------------------------------------------------------------------- | :----------------------------- | :----------------------------------------------------------------- | :----- | -: | ---: |
| [test-long\_to\_wide\_converter.R](testthat/test-long_to_wide_converter.R#L26) | long\_to\_wide\_converter      | long\_to\_wide\_converter works                                    | PASS   |  4 | 0.08 |
| [test-pairwise\_p.R](testthat/test-pairwise_p.R#L67)                           | pairwise\_comparisons          | `pairwise_comparisons()` works for between-subjects design         | PASS   | 18 | 8.33 |
| [test-pairwise\_p.R](testthat/test-pairwise_p.R#L185_L196)                     | pairwise\_comparisons          | `pairwise_comparisons()` works for within-subjects design          | PASS   | 15 | 0.20 |
| [test-pairwise\_p.R](testthat/test-pairwise_p.R#L299)                          | pairwise\_comparisons          | `pairwise_comparisons()` messages are correct for between-subjects | PASS   |  9 | 8.25 |
| [test-pairwise\_p.R](testthat/test-pairwise_p.R#L378)                          | pairwise\_comparisons          | `pairwise_comparisons()` messages are correct for within-subjects  | PASS   |  7 | 0.21 |
| [test-pairwise\_p.R](testthat/test-pairwise_p.R#L456)                          | pairwise\_comparisons          | dropped levels are not included                                    | PASS   |  5 | 0.54 |
| [test-pairwise\_p.R](testthat/test-pairwise_p.R#L480)                          | pairwise\_comparisons          | check if everything works fine with irregular factor level names   | PASS   |  3 | 0.03 |
| [test-pairwise\_p.R](testthat/test-pairwise_p.R#L519_L530)                     | pairwise\_comparisons\_caption | `pairwise_comparisons_caption()` works                             | PASS   |  3 | 0.02 |
| [test-switch\_statements.R](testthat/test-switch_statements.R#L8)              | switch statements              | switch for p adjustment works                                      | PASS   |  7 | 0.00 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                            |
| :------- | :------------------------------- |
| Version  | R version 3.6.1 (2019-07-05)     |
| Platform | x86\_64-w64-mingw32/x64 (64-bit) |
| Running  | Windows 10 x64 (build 16299)     |
| Language | English\_United States           |
| Timezone | America/New\_York                |

| Package  | Version |
| :------- | :------ |
| testthat | 2.2.1   |
| covr     | 3.3.0   |
| covrpage | 0.0.70  |

</details>

<!--- Final Status : pass --->
