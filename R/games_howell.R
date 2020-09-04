#' @title Games-Howell post-hoc test
#' @name games_howell
#' @description This function produces results from Games-Howell post-hoc tests
#'   for Welch's one-way analysis of variance (ANOVA) (`stats::oneway.test()`).
#'
#' @inheritParams pairwise_comparisons
#'
#' @importFrom stats ptukey qtukey
#' @importFrom utils combn
#' @importFrom dplyr select everything
#'
#' @note This is based on the implementation of Games-Howell test by Aaron
#'   Schlegel (https://rpubs.com/aaronsc32)  and published on RPubs
#'   (https://rpubs.com/aaronsc32/games-howell-test).
#'
#' @keywords internal

# function body
games_howell <- function(data, x, y) {

  # ============================ data preparation ==========================

  # creating a dataframe
  data <-
    dplyr::select(
      .data = data,
      x = !!rlang::enquo(x),
      y = !!rlang::enquo(y)
    ) %>%
    tidyr::drop_na(.) %>%
    dplyr::mutate(.data = ., x = droplevels(as.factor(x))) %>%
    as_tibble(.)

  # variables of interest for running the test
  grp <- data$x
  obs <- data$y

  # create combinations
  combs <- utils::combn(x = unique(grp), m = 2)

  # Statistics that will be used throughout the calculations:
  # n = sample size of each group
  # groups = number of groups in data
  # Mean = means of each group sample
  # std = variance of each group sample
  n <- tapply(X = obs, INDEX = grp, FUN = length)
  groups <- length(tapply(X = obs, INDEX = grp, FUN = length))
  Mean <- tapply(X = obs, INDEX = grp, FUN = mean)
  std <- tapply(X = obs, INDEX = grp, FUN = var)

  # ============================ analysis ===============================

  statistics <- lapply(X = 1:NCOL(combs), FUN = function(x) {

    # mean difference
    mean.diff <- Mean[combs[2, x]] - Mean[combs[1, x]]

    # t-values
    t <-
      (abs(Mean[combs[1, x]] - Mean[combs[2, x]])) /
        (sqrt((std[combs[1, x]] / n[combs[1, x]]) +
          (std[combs[2, x]] / n[combs[2, x]])))

    # degrees of freedom (df)
    df <-
      ((std[combs[1, x]] / n[combs[1, x]] +
        std[combs[2, x]] / n[combs[2, x]])^2) /
        ((((std[combs[1, x]] / n[combs[1, x]])^2 / (n[combs[1, x]] - 1)) +
          ((std[combs[2, x]] / n[combs[2, x]])^2 / (n[combs[2, x]] - 1))))

    # p-values
    p <-
      stats::ptukey(
        q = t * sqrt(2),
        nmeans = groups,
        df = df,
        lower.tail = FALSE
      )

    # sigma standard error
    se <- sqrt(x = 0.5 * (std[combs[1, x]] / n[combs[1, x]] + std[combs[2, x]] / n[combs[2, x]]))

    # upper confidence limit for mean difference
    conf.high <-
      lapply(
        X = 1:NCOL(combs),
        FUN = function(x) mean.diff + stats::qtukey(p = 0.95, nmeans = groups, df = df) * se
      )

    # lower confidence limit for mean difference
    conf.low <-
      lapply(
        X = 1:NCOL(combs),
        FUN = function(x) mean.diff - stats::qtukey(p = 0.95, nmeans = groups, df = df) * se
      )

    # Group Combinations
    group1 <- as.character(combs[1, x])
    group2 <- as.character(combs[2, x])

    # Collect all statistics into list
    stats <- list(group1, group2, mean.diff, se, t, df, p, conf.high[[1]], conf.low[[1]])
  })

  # unlist statistics collected earlier
  stats.unlisted <- lapply(statistics, function(x) unlist(x))

  # create dataframe from flattened list
  results <-
    data.frame(matrix(
      unlist(stats.unlisted),
      nrow = length(stats.unlisted),
      byrow = TRUE
    ))

  # select columns that should be numeric and change with as.numeric
  results[, 3:ncol(results)] <- round(as.numeric(as.matrix(results[, 3:ncol(results)])), digits = 3)

  # Rename data frame columns
  colnames(results) <-
    c(
      "group1",
      "group2",
      "mean.difference",
      "se",
      "t.value",
      "df",
      "p.value",
      "conf.high",
      "conf.low"
    )

  # converting it to tibble
  results %>%
    as_tibble(.) %>%
    dplyr::select(
      .data = .,
      group1:mean.difference,
      conf.low,
      conf.high,
      dplyr::everything()
    )
}
