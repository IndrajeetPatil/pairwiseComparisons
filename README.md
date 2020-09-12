
<!-- README.md is generated from README.Rmd. Please edit that file -->

`pairwiseComparisons`: Multiple Pairwise Comparison Tests
=========================================================

| Package                                                                                                                                                                         | Status                                                                                                                                                                                                       | Usage                                                                                                                                                                                 | GitHub                                                                                                                                                                         | References                                                                                                                                                                      |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [![CRAN\_Release\_Badge](http://www.r-pkg.org/badges/version-ago/pairwiseComparisons)](https://CRAN.R-project.org/package=pairwiseComparisons)                                  | [![Travis Build Status](https://travis-ci.org/IndrajeetPatil/pairwiseComparisons.svg?branch=master)](https://travis-ci.org/IndrajeetPatil/pairwiseComparisons)                                               | [![Daily downloads badge](https://cranlogs.r-pkg.org/badges/last-day/pairwiseComparisons?color=blue)](https://CRAN.R-project.org/package=pairwiseComparisons)                         | [![GitHub version](https://img.shields.io/badge/GitHub-2.0.0-orange.svg?style=flat-square)](https://github.com/IndrajeetPatil/pairwiseComparisons/)                            | [![Website](https://img.shields.io/badge/website-pairwiseComparisons-orange.svg?colorB=E91E63)](https://indrajeetpatil.github.io/pairwiseComparisons/)                          |
| [![CRAN Checks](https://cranchecks.info/badges/summary/pairwiseComparisons)](https://cran.r-project.org/web/checks/check_results_pairwiseComparisons.html)                      | [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/IndrajeetPatil/pairwiseComparisons?branch=master&svg=true)](https://ci.appveyor.com/project/IndrajeetPatil/pairwiseComparisons) | [![Weekly downloads badge](https://cranlogs.r-pkg.org/badges/last-week/pairwiseComparisons?color=blue)](https://CRAN.R-project.org/package=pairwiseComparisons)                       | [![Forks](https://img.shields.io/badge/forks-3-blue.svg)](https://github.com/IndrajeetPatil/pairwiseComparisons/)                                                              | [![Rdoc](https://www.rdocumentation.org/badges/version/pairwiseComparisons)](https://www.rdocumentation.org/packages/pairwiseComparisons)                                       |
| [![minimal R version](https://img.shields.io/badge/R%3E%3D-3.6.0-6666ff.svg)](https://cran.r-project.org/)                                                                      | [![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/)                                                                                               | [![Monthly downloads badge](https://cranlogs.r-pkg.org/badges/last-month/pairwiseComparisons?color=blue)](https://CRAN.R-project.org/package=pairwiseComparisons)                     | [![Github Issues](https://img.shields.io/badge/issues-0-red.svg)](https://github.com/IndrajeetPatil/pairwiseComparisons/issues)                                                | [![vignettes](https://img.shields.io/badge/vignettes-2.0.0-orange.svg?colorB=FF5722)](https://github.com/IndrajeetPatil/pairwiseComparisons/blob/master/README.md)              |
| [![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/IndrajeetPatil/pairwiseComparisons.svg)](https://github.com/IndrajeetPatil/pairwiseComparisons) | [![Coverage Status](https://coveralls.io/repos/github/IndrajeetPatil/pairwiseComparisons/badge.svg?branch=master)](https://coveralls.io/github/IndrajeetPatil/pairwiseComparisons?branch=master)             | [![Total downloads badge](https://cranlogs.r-pkg.org/badges/grand-total/pairwiseComparisons?color=blue)](https://CRAN.R-project.org/package=pairwiseComparisons)                      | [![Github Stars](https://img.shields.io/github/stars/IndrajeetPatil/pairwiseComparisons.svg?style=social&label=Github)](https://github.com/IndrajeetPatil/pairwiseComparisons) | [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.2074621.svg)](https://doi.org/10.5281/zenodo.2074621)                                                                       |
| [![Licence](https://img.shields.io/badge/licence-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)                                                                | [![Codecov test coverage](https://codecov.io/gh/IndrajeetPatil/pairwiseComparisons/branch/master/graph/badge.svg)](https://codecov.io/gh/IndrajeetPatil/pairwiseComparisons?branch=master)                   | [![Covrpage Summary](https://img.shields.io/badge/covrpage-Last_Build_2020_05_29-brightgreen.svg)](https://github.com/IndrajeetPatil/pairwiseComparisons/blob/master/tests/README.md) | [![Last-changedate](https://img.shields.io/badge/last%20change-2020--09--12-yellowgreen.svg)](https://github.com/IndrajeetPatil/pairwiseComparisons/commits/master)            | [![GitHub last commit](https://img.shields.io/github/last-commit/IndrajeetPatil/pairwiseComparisons.svg)](https://github.com/IndrajeetPatil/pairwiseComparisons/commits/master) |
| [![status](https://tinyverse.netlify.com/badge/pairwiseComparisons)](https://CRAN.R-project.org/package=pairwiseComparisons)                                                    | [![R build status](https://github.com/IndrajeetPatil/pairwiseComparisons/workflows/R-CMD-check/badge.svg)](https://github.com/IndrajeetPatil/pairwiseComparisons)                                            | [![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/pairwiseComparisons/community)                                                                       | [![Project Status](http://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)                                                                    | [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/IndrajeetPatil/pairwiseComparisons/issues)         |

Introduction <img src="man/figures/logo.png" align="right" width="240" />
=========================================================================

[`pairwiseComparisons`](https://indrajeetpatil.github.io/pairwiseComparisons/)
provides a tidy data friendly way to carry out pairwise comparison
tests.

It currently supports *post hoc* multiple pairwise comparisons tests for
both between-subjects and within-subjects one-way analysis of variance
designs. For both of these designs, parametric, non-parametric, robust,
and Bayes Factor statistical tests are available.

Installation
------------

To get the latest, stable `CRAN` release:

    install.packages("pairwiseComparisons")

You can get the **development** version of the package from `GitHub`. To
see what new changes (and bug fixes) have been made to the package since
the last release on `CRAN`, you can check the detailed log of changes
here:
<a href="https://indrajeetpatil.github.io/pairwiseComparisons/news/index.html" class="uri">https://indrajeetpatil.github.io/pairwiseComparisons/news/index.html</a>

If you are in hurry and want to reduce the time of installation, prefer-

    # needed package to download from GitHub repo
    install.packages("remotes")

    # downloading the package from GitHub
    remotes::install_github(
      repo = "IndrajeetPatil/pairwiseComparisons", # package path on GitHub
      dependencies = FALSE, # assumes you have already installed needed packages
      quick = TRUE # skips docs, demos, and vignettes
    )

If time is not a constraint-

    remotes::install_github(
      repo = "IndrajeetPatil/pairwiseComparisons", # package path on GitHub
      dependencies = TRUE, # installs packages which pairwiseComparisons depends on
      upgrade_dependencies = TRUE # updates any out of date dependencies
    )

Summary of types of statistical analyses
========================================

Following table contains a brief summary of the currently supported
pairwise comparison tests-

Between-subjects design
-----------------------

| Type           | Equal variance? | Test                      | *p*-value adjustment?          |
|----------------|-----------------|---------------------------|--------------------------------|
| Parametric     | No              | Games-Howell test         | <font color="green">Yes</font> |
| Parametric     | Yes             | Student’s *t*-test        | <font color="green">Yes</font> |
| Non-parametric | No              | Dunn test                 | <font color="green">Yes</font> |
| Robust         | No              | Yuen’s trimmed means test | <font color="green">Yes</font> |
| Bayes Factor   | `NA`            | Student’s *t*-test        | `NA`                           |

Within-subjects design
----------------------

| Type           | Test                      | *p*-value adjustment?          |
|----------------|---------------------------|--------------------------------|
| Parametric     | Student’s *t*-test        | <font color="green">Yes</font> |
| Non-parametric | Durbin-Conover test       | <font color="green">Yes</font> |
| Robust         | Yuen’s trimmed means test | <font color="green">Yes</font> |
| Bayes Factor   | Student’s *t*-test        | `NA`                           |

Examples
========

Here we will see specific examples of how to use this function for
different types of

-   designs (between or within subjects)
-   statistics (parametric, non-parametric, robust, Bayes Factor)
-   *p*-value adjustment methods

Between-subjects design
-----------------------

    # for reproducibility
    set.seed(123)
    library(pairwiseComparisons)

    # parametric
    # if `var.equal = TRUE`, then Student's *t*-test will be run
    pairwise_comparisons(
      data = ggplot2::msleep,
      x = vore,
      y = brainwt,
      type = "parametric",
      var.equal = TRUE,
      paired = FALSE,
      p.adjust.method = "bonferroni"
    )
    #> # A tibble: 6 x 8
    #>   group1  group2  mean.difference p.value significance
    #>   <chr>   <chr>             <dbl>   <dbl> <chr>       
    #> 1 carni   herbi            0.542    1     ns          
    #> 2 carni   insecti         -0.0577   1     ns          
    #> 3 carni   omni             0.0665   1     ns          
    #> 4 herbi   insecti         -0.600    1     ns          
    #> 5 herbi   omni            -0.476    0.979 ns          
    #> 6 insecti omni             0.124    1     ns          
    #>   label                             test.details     p.value.adjustment
    #>   <chr>                             <chr>            <chr>             
    #> 1 list(~italic(p)[adjusted]==1.000) Student's t-test Bonferroni        
    #> 2 list(~italic(p)[adjusted]==1.000) Student's t-test Bonferroni        
    #> 3 list(~italic(p)[adjusted]==1.000) Student's t-test Bonferroni        
    #> 4 list(~italic(p)[adjusted]==1.000) Student's t-test Bonferroni        
    #> 5 list(~italic(p)[adjusted]==0.979) Student's t-test Bonferroni        
    #> 6 list(~italic(p)[adjusted]==1.000) Student's t-test Bonferroni

    # if `var.equal = FALSE`, then Games-Howell test will be run
    pairwise_comparisons(
      data = ggplot2::msleep,
      x = vore,
      y = brainwt,
      type = "parametric",
      var.equal = FALSE,
      paired = FALSE,
      p.adjust.method = "bonferroni"
    )
    #> # A tibble: 6 x 11
    #>   group1  group2  mean.difference    se t.value    df p.value significance
    #>   <chr>   <chr>             <dbl> <dbl>   <dbl> <dbl>   <dbl> <chr>       
    #> 1 carni   herbi             0.542 0.25    1.54   19.4       1 ns          
    #> 2 carni   insecti          -0.058 0.027   1.53   10.7       1 ns          
    #> 3 carni   omni              0.066 0.061   0.774  21.1       1 ns          
    #> 4 herbi   insecti          -0.6   0.249   1.70   19.1       1 ns          
    #> 5 herbi   omni             -0.476 0.255   1.32   20.9       1 ns          
    #> 6 insecti omni              0.124 0.057   1.55   17.2       1 ns          
    #>   label                             test.details      p.value.adjustment
    #>   <chr>                             <chr>             <chr>             
    #> 1 list(~italic(p)[adjusted]==1.000) Games-Howell test Bonferroni        
    #> 2 list(~italic(p)[adjusted]==1.000) Games-Howell test Bonferroni        
    #> 3 list(~italic(p)[adjusted]==1.000) Games-Howell test Bonferroni        
    #> 4 list(~italic(p)[adjusted]==1.000) Games-Howell test Bonferroni        
    #> 5 list(~italic(p)[adjusted]==1.000) Games-Howell test Bonferroni        
    #> 6 list(~italic(p)[adjusted]==1.000) Games-Howell test Bonferroni

    # non-parametric
    pairwise_comparisons(
      data = ggplot2::msleep,
      x = vore,
      y = brainwt,
      type = "nonparametric",
      paired = FALSE,
      p.adjust.method = "none"
    )
    #> # A tibble: 6 x 8
    #>   group1  group2  z.value p.value significance
    #>   <chr>   <chr>     <dbl>   <dbl> <chr>       
    #> 1 carni   herbi     0.582  0.561  ns          
    #> 2 carni   insecti   1.88   0.0595 ns          
    #> 3 carni   omni      1.14   0.254  ns          
    #> 4 herbi   insecti   1.63   0.102  ns          
    #> 5 herbi   omni      0.717  0.474  ns          
    #> 6 insecti omni      1.14   0.254  ns          
    #>   label                               test.details p.value.adjustment
    #>   <chr>                               <chr>        <chr>             
    #> 1 list(~italic(p)[unadjusted]==0.561) Dunn test    None              
    #> 2 list(~italic(p)[unadjusted]==0.060) Dunn test    None              
    #> 3 list(~italic(p)[unadjusted]==0.254) Dunn test    None              
    #> 4 list(~italic(p)[unadjusted]==0.102) Dunn test    None              
    #> 5 list(~italic(p)[unadjusted]==0.474) Dunn test    None              
    #> 6 list(~italic(p)[unadjusted]==0.254) Dunn test    None

    # robust
    pairwise_comparisons(
      data = ggplot2::msleep,
      x = vore,
      y = brainwt,
      type = "robust",
      paired = FALSE,
      p.adjust.method = "fdr"
    )
    #> # A tibble: 6 x 10
    #>   group1  group2    psihat conf.low conf.high p.value significance
    #>   <chr>   <chr>      <dbl>    <dbl>     <dbl>   <dbl> <chr>       
    #> 1 carni   herbi   -0.0530   -0.274     0.168    0.969 ns          
    #> 2 carni   insecti  0.0577   -0.0609    0.176    0.969 ns          
    #> 3 carni   omni     0.00210  -0.151     0.155    0.969 ns          
    #> 4 herbi   insecti  0.111    -0.0983    0.320    0.969 ns          
    #> 5 herbi   omni     0.0551   -0.173     0.283    0.969 ns          
    #> 6 insecti omni    -0.0556   -0.184     0.0728   0.969 ns          
    #>   label                             test.details             
    #>   <chr>                             <chr>                    
    #> 1 list(~italic(p)[adjusted]==0.969) Yuen's trimmed means test
    #> 2 list(~italic(p)[adjusted]==0.969) Yuen's trimmed means test
    #> 3 list(~italic(p)[adjusted]==0.969) Yuen's trimmed means test
    #> 4 list(~italic(p)[adjusted]==0.969) Yuen's trimmed means test
    #> 5 list(~italic(p)[adjusted]==0.969) Yuen's trimmed means test
    #> 6 list(~italic(p)[adjusted]==0.969) Yuen's trimmed means test
    #>   p.value.adjustment  
    #>   <chr>               
    #> 1 Benjamini & Hochberg
    #> 2 Benjamini & Hochberg
    #> 3 Benjamini & Hochberg
    #> 4 Benjamini & Hochberg
    #> 5 Benjamini & Hochberg
    #> 6 Benjamini & Hochberg

    # Bayes Factor
    pairwise_comparisons(
      data = ggplot2::msleep,
      x = vore,
      y = brainwt,
      type = "bayes",
      paired = FALSE
    )
    #> # A tibble: 6 x 21
    #>   group1  group2  term       estimate conf.low conf.high    pd rope.percentage
    #>   <chr>   <chr>   <chr>         <dbl>    <dbl>     <dbl> <dbl>           <dbl>
    #> 1 carni   herbi   Difference  -0.383   -1.15       0.349 0.801           0.135
    #> 2 carni   insecti Difference   0.0348  -0.0271     0.104 0.812           0.975
    #> 3 carni   omni    Difference  -0.0460  -0.195      0.107 0.692           0.749
    #> 4 herbi   insecti Difference   0.358   -0.586      1.33  0.744           0.126
    #> 5 herbi   omni    Difference   0.371   -0.234      0.884 0.856           0.144
    #> 6 insecti omni    Difference  -0.0755  -0.286      0.102 0.742           0.586
    #>   prior.distribution prior.location prior.scale effects component    bf10  bf01
    #>   <chr>                       <dbl>       <dbl> <chr>   <chr>       <dbl> <dbl>
    #> 1 cauchy                          0       0.707 fixed   conditional 0.540  1.85
    #> 2 cauchy                          0       0.707 fixed   conditional 0.718  1.39
    #> 3 cauchy                          0       0.707 fixed   conditional 0.427  2.34
    #> 4 cauchy                          0       0.707 fixed   conditional 0.540  1.85
    #> 5 cauchy                          0       0.707 fixed   conditional 0.571  1.75
    #> 6 cauchy                          0       0.707 fixed   conditional 0.545  1.83
    #>   log_e_bf10 log_e_bf01 log_10_bf10 log_10_bf01 label                       
    #>        <dbl>      <dbl>       <dbl>       <dbl> <chr>                       
    #> 1     -0.617      0.617      -0.268       0.268 list(~log[e](BF[10])==-0.62)
    #> 2     -0.332      0.332      -0.144       0.144 list(~log[e](BF[10])==-0.33)
    #> 3     -0.851      0.851      -0.369       0.369 list(~log[e](BF[10])==-0.85)
    #> 4     -0.616      0.616      -0.267       0.267 list(~log[e](BF[10])==-0.62)
    #> 5     -0.560      0.560      -0.243       0.243 list(~log[e](BF[10])==-0.56)
    #> 6     -0.606      0.606      -0.263       0.263 list(~log[e](BF[10])==-0.61)
    #>   test.details    
    #>   <chr>           
    #> 1 Student's t-test
    #> 2 Student's t-test
    #> 3 Student's t-test
    #> 4 Student's t-test
    #> 5 Student's t-test
    #> 6 Student's t-test

Within-subjects design
----------------------

    # for reproducibility
    set.seed(123)

    # parametric
    pairwise_comparisons(
      data = bugs_long,
      x = condition,
      y = desire,
      type = "parametric",
      paired = TRUE,
      p.adjust.method = "BH"
    )
    #> # A tibble: 6 x 8
    #>   group1 group2 mean.difference  p.value significance
    #>   <chr>  <chr>            <dbl>    <dbl> <chr>       
    #> 1 HDHF   HDLF            -1.15  1.06e- 3 **          
    #> 2 HDHF   LDHF            -0.472 7.02e- 2 ns          
    #> 3 HDHF   LDLF            -2.16  3.95e-12 ***         
    #> 4 HDLF   LDHF             0.676 6.74e- 2 ns          
    #> 5 HDLF   LDLF            -1.02  1.99e- 3 **          
    #> 6 LDHF   LDLF            -1.69  6.66e- 9 ***         
    #>   label                             test.details     p.value.adjustment  
    #>   <chr>                             <chr>            <chr>               
    #> 1 list(~italic(p)[adjusted]==0.001) Student's t-test Benjamini & Hochberg
    #> 2 list(~italic(p)[adjusted]==0.070) Student's t-test Benjamini & Hochberg
    #> 3 list(~italic(p)[adjusted]<=0.001) Student's t-test Benjamini & Hochberg
    #> 4 list(~italic(p)[adjusted]==0.067) Student's t-test Benjamini & Hochberg
    #> 5 list(~italic(p)[adjusted]==0.002) Student's t-test Benjamini & Hochberg
    #> 6 list(~italic(p)[adjusted]<=0.001) Student's t-test Benjamini & Hochberg

    # non-parametric
    pairwise_comparisons(
      data = bugs_long,
      x = condition,
      y = desire,
      type = "nonparametric",
      paired = TRUE,
      p.adjust.method = "BY"
    )
    #> # A tibble: 6 x 8
    #>   group1 group2     W  p.value significance label                            
    #>   <chr>  <chr>  <dbl>    <dbl> <chr>        <chr>                            
    #> 1 HDHF   HDLF    4.78 1.44e- 5 ***          list(~italic(p)[adjusted]<=0.001)
    #> 2 HDHF   LDHF    2.44 4.47e- 2 *            list(~italic(p)[adjusted]==0.045)
    #> 3 HDHF   LDLF    8.01 5.45e-13 ***          list(~italic(p)[adjusted]<=0.001)
    #> 4 HDLF   LDHF    2.34 4.96e- 2 *            list(~italic(p)[adjusted]==0.050)
    #> 5 HDLF   LDLF    3.23 5.05e- 3 **           list(~italic(p)[adjusted]==0.005)
    #> 6 LDHF   LDLF    5.57 4.64e- 7 ***          list(~italic(p)[adjusted]<=0.001)
    #>   test.details        p.value.adjustment   
    #>   <chr>               <chr>                
    #> 1 Durbin-Conover test Benjamini & Yekutieli
    #> 2 Durbin-Conover test Benjamini & Yekutieli
    #> 3 Durbin-Conover test Benjamini & Yekutieli
    #> 4 Durbin-Conover test Benjamini & Yekutieli
    #> 5 Durbin-Conover test Benjamini & Yekutieli
    #> 6 Durbin-Conover test Benjamini & Yekutieli

    # robust
    pairwise_comparisons(
      data = bugs_long,
      x = condition,
      y = desire,
      type = "robust",
      paired = TRUE,
      p.adjust.method = "hommel"
    )
    #> # A tibble: 6 x 10
    #>   group1 group2 psihat conf.low conf.high  p.value significance
    #>   <chr>  <chr>   <dbl>    <dbl>     <dbl>    <dbl> <chr>       
    #> 1 HDHF   HDLF    1.16    0.318      2.00  1.49e- 3 **          
    #> 2 HDHF   LDHF    0.5    -0.188      1.19  6.20e- 2 ns          
    #> 3 HDHF   LDLF    2.10    1.37       2.82  1.79e-10 ***         
    #> 4 HDLF   LDHF   -0.701  -1.71       0.303 6.20e- 2 ns          
    #> 5 HDLF   LDLF    0.938   0.0694     1.81  1.36e- 2 *           
    #> 6 LDHF   LDLF    1.54    0.810      2.27  1.16e- 6 ***         
    #>   label                             test.details              p.value.adjustment
    #>   <chr>                             <chr>                     <chr>             
    #> 1 list(~italic(p)[adjusted]==0.001) Yuen's trimmed means test Hommel            
    #> 2 list(~italic(p)[adjusted]==0.062) Yuen's trimmed means test Hommel            
    #> 3 list(~italic(p)[adjusted]<=0.001) Yuen's trimmed means test Hommel            
    #> 4 list(~italic(p)[adjusted]==0.062) Yuen's trimmed means test Hommel            
    #> 5 list(~italic(p)[adjusted]==0.014) Yuen's trimmed means test Hommel            
    #> 6 list(~italic(p)[adjusted]<=0.001) Yuen's trimmed means test Hommel

    # Bayes Factor
    pairwise_comparisons(
      data = WRS2::WineTasting,
      x = Wine,
      y = Taste,
      type = "bayes",
      paired = TRUE,
      bf.prior = 0.77
    )
    #> # A tibble: 3 x 21
    #>   group1 group2 term       estimate conf.low conf.high    pd rope.percentage
    #>   <chr>  <chr>  <chr>         <dbl>    <dbl>     <dbl> <dbl>           <dbl>
    #> 1 Wine A Wine B Difference  0.0150   0.00797    0.0228     1               1
    #> 2 Wine A Wine C Difference  0.0222   0.0119     0.0332     1               1
    #> 3 Wine B Wine C Difference  0.00807  0.00439    0.0126     1               1
    #>   prior.distribution prior.location prior.scale effects component     bf10
    #>   <chr>                       <dbl>       <dbl> <chr>   <chr>        <dbl>
    #> 1 cauchy                          0        0.77 fixed   conditional  0.219
    #> 2 cauchy                          0        0.77 fixed   conditional  3.60 
    #> 3 cauchy                          0        0.77 fixed   conditional 50.5  
    #>     bf01 log_e_bf10 log_e_bf01 log_10_bf10 log_10_bf01
    #>    <dbl>      <dbl>      <dbl>       <dbl>       <dbl>
    #> 1 4.57        -1.52       1.52      -0.660       0.660
    #> 2 0.277        1.28      -1.28       0.557      -0.557
    #> 3 0.0198       3.92      -3.92       1.70       -1.70 
    #>   label                        test.details    
    #>   <chr>                        <chr>           
    #> 1 list(~log[e](BF[10])==-1.52) Student's t-test
    #> 2 list(~log[e](BF[10])==1.28)  Student's t-test
    #> 3 list(~log[e](BF[10])==3.92)  Student's t-test

Using `pairwiseComparisons` with `ggsignif` to display results
==============================================================

Example-1: between-subjects
---------------------------

    # needed libraries
    library(ggplot2)
    library(pairwiseComparisons)
    library(ggsignif)

    # converting to factor
    mtcars$cyl <- as.factor(mtcars$cyl)

    # creating a basic plot
    p <- ggplot(mtcars, aes(cyl, wt)) +
      geom_boxplot()

    # using `pairwiseComparisons` package to create a dataframe with results
    (df <-
      pairwise_comparisons(mtcars, cyl, wt, messages = FALSE) %>%
      dplyr::mutate(.data = ., groups = purrr::pmap(.l = list(group1, group2), .f = c)) %>%
      dplyr::arrange(.data = ., group1))
    #> # A tibble: 3 x 12
    #>   group1 group2 mean.difference    se t.value    df p.value significance
    #>   <chr>  <chr>            <dbl> <dbl>   <dbl> <dbl>   <dbl> <chr>       
    #> 1 4      6                0.831 0.154    3.81  16.0   0.008 **          
    #> 2 4      8                1.71  0.188    6.44  23.0   0     ***         
    #> 3 6      8                0.882 0.172    3.62  19.0   0.008 **          
    #>   label                             test.details      p.value.adjustment
    #>   <chr>                             <chr>             <chr>             
    #> 1 list(~italic(p)[adjusted]==0.008) Games-Howell test Holm              
    #> 2 list(~italic(p)[adjusted]<=0.001) Games-Howell test Holm              
    #> 3 list(~italic(p)[adjusted]==0.008) Games-Howell test Holm              
    #>   groups   
    #>   <list>   
    #> 1 <chr [2]>
    #> 2 <chr [2]>
    #> 3 <chr [2]>

    # using `geom_signif` to display results
    p +
      ggsignif::geom_signif(
        comparisons = df$groups,
        map_signif_level = TRUE,
        tip_length = 0.01,
        y_position = c(5.5, 5.75, 6),
        annotations = df$label,
        test = NULL,
        na.rm = TRUE,
        parse = TRUE
      )

<img src="man/figures/README-ggsignif-1.png" width="100%" />

Example-2: within-subjects
--------------------------

    # needed libraries
    library(ggplot2)
    library(pairwiseComparisons)
    library(ggsignif)

    # creating a basic plot
    p <- ggplot(WRS2::WineTasting, aes(Wine, Taste)) + geom_boxplot()

    # using `pairwiseComparisons` package to create a dataframe with results
    (df <-
      pairwise_comparisons(WRS2::WineTasting, Wine, Taste, type = "bayes", paired = TRUE) %>%
      dplyr::mutate(.data = ., groups = purrr::pmap(.l = list(group1, group2), .f = c)) %>%
      dplyr::arrange(.data = ., group1))
    #> # A tibble: 3 x 22
    #>   group1 group2 term       estimate conf.low conf.high    pd rope.percentage
    #>   <chr>  <chr>  <chr>         <dbl>    <dbl>     <dbl> <dbl>           <dbl>
    #> 1 Wine A Wine B Difference  0.0151   0.00817    0.0226     1               1
    #> 2 Wine A Wine C Difference  0.0224   0.0129     0.0349     1               1
    #> 3 Wine B Wine C Difference  0.00808  0.00463    0.0128     1               1
    #>   prior.distribution prior.location prior.scale effects component     bf10
    #>   <chr>                       <dbl>       <dbl> <chr>   <chr>        <dbl>
    #> 1 cauchy                          0       0.707 fixed   conditional  0.235
    #> 2 cauchy                          0       0.707 fixed   conditional  3.71 
    #> 3 cauchy                          0       0.707 fixed   conditional 50.5  
    #>     bf01 log_e_bf10 log_e_bf01 log_10_bf10 log_10_bf01
    #>    <dbl>      <dbl>      <dbl>       <dbl>       <dbl>
    #> 1 4.25        -1.45       1.45      -0.628       0.628
    #> 2 0.269        1.31      -1.31       0.570      -0.570
    #> 3 0.0198       3.92      -3.92       1.70       -1.70 
    #>   label                        test.details     groups   
    #>   <chr>                        <chr>            <list>   
    #> 1 list(~log[e](BF[10])==-1.45) Student's t-test <chr [2]>
    #> 2 list(~log[e](BF[10])==1.31)  Student's t-test <chr [2]>
    #> 3 list(~log[e](BF[10])==3.92)  Student's t-test <chr [2]>

    # using `geom_signif` to display results
    p +
      ggsignif::geom_signif(
        comparisons = df$groups,
        map_signif_level = TRUE,
        tip_length = 0.01,
        y_position = c(6.5, 6.65, 6.8),
        annotations = df$label,
        test = NULL,
        na.rm = TRUE,
        parse = TRUE
      )

<img src="man/figures/README-ggsignif2-1.png" width="100%" />

Acknowledgments
===============

The hexsticker was generously designed by Sarah Otterstetter (Max Planck
Institute for Human Development, Berlin).

Contributing
============

I’m happy to receive bug reports, suggestions, questions, and (most of
all) contributions to fix problems and add features. I personally prefer
using the `GitHub` issues system over trying to reach out to me in other
ways (personal e-mail, Twitter, etc.). Pull Requests for contributions
are encouraged.

Here are some simple ways in which you can contribute (in the increasing
order of commitment):

-   Read and correct any inconsistencies in the
    [documentation](https://indrajeetpatil.github.io/pairwiseComparisons/)

-   Raise issues about bugs or wanted features

-   Review code

-   Add new functionality

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/IndrajeetPatil/pairwiseComparisons/blob/master/.github/CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.
