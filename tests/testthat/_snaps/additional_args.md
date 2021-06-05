# `pairwise_comparisons()` - test additional arguments

    Code
      list(df1, df2, df3, df4)
    Output
      [[1]]
      # A tibble: 6 x 7
        group1 group2  p.value test.details     p.value.adjustment
        <chr>  <chr>     <dbl> <chr>            <chr>             
      1 HDHF   HDLF   2.65e- 4 Student's t-test None              
      2 HDHF   LDHF   3.51e- 2 Student's t-test None              
      3 HDHF   LDLF   3.29e-13 Student's t-test None              
      4 HDLF   LDHF   9.72e- 1 Student's t-test None              
      5 HDLF   LDLF   6.62e- 4 Student's t-test None              
      6 LDHF   LDLF   1.11e- 9 Student's t-test None              
        label                                   y_position
        <chr>                                        <dbl>
      1 list(~italic(p)[uncorrected]==2.65e-04)       10.2
      2 list(~italic(p)[uncorrected]==0.035)          10.8
      3 list(~italic(p)[uncorrected]==3.29e-13)       11.4
      4 list(~italic(p)[uncorrected]==0.972)          12.0
      5 list(~italic(p)[uncorrected]==0.001)          12.6
      6 list(~italic(p)[uncorrected]==1.11e-09)       13.2
      
      [[2]]
      # A tibble: 6 x 7
        group1 group2 p.value test.details     p.value.adjustment
        <chr>  <chr>    <dbl> <chr>            <chr>             
      1 HDHF   HDLF    1.00   Student's t-test None              
      2 HDHF   LDHF    0.965  Student's t-test None              
      3 HDHF   LDLF    1.00   Student's t-test None              
      4 HDLF   LDHF    0.0281 Student's t-test None              
      5 HDLF   LDLF    0.999  Student's t-test None              
      6 LDHF   LDLF    1.00   Student's t-test None              
        label                                y_position
        <chr>                                     <dbl>
      1 list(~italic(p)[uncorrected]==1.000)       10.2
      2 list(~italic(p)[uncorrected]==0.965)       10.8
      3 list(~italic(p)[uncorrected]==1.000)       11.4
      4 list(~italic(p)[uncorrected]==0.028)       12.0
      5 list(~italic(p)[uncorrected]==0.999)       12.6
      6 list(~italic(p)[uncorrected]==1.000)       13.2
      
      [[3]]
      # A tibble: 3 x 7
        group1 group2 p.value test.details     p.value.adjustment
        <chr>  <chr>    <dbl> <chr>            <chr>             
      1 4      6        0.995 Student's t-test None              
      2 4      8        1.00  Student's t-test None              
      3 6      8        0.997 Student's t-test None              
        label                                y_position
        <chr>                                     <dbl>
      1 list(~italic(p)[uncorrected]==0.995)       5.56
      2 list(~italic(p)[uncorrected]==1.000)       5.85
      3 list(~italic(p)[uncorrected]==0.997)       6.15
      
      [[4]]
      # A tibble: 3 x 7
        group1 group2     p.value test.details     p.value.adjustment
        <chr>  <chr>        <dbl> <chr>            <chr>             
      1 4      6      0.00532     Student's t-test None              
      2 4      8      0.000000103 Student's t-test None              
      3 6      8      0.00258     Student's t-test None              
        label                                   y_position
        <chr>                                        <dbl>
      1 list(~italic(p)[uncorrected]==0.005)          5.56
      2 list(~italic(p)[uncorrected]==1.03e-07)       5.85
      3 list(~italic(p)[uncorrected]==0.003)          6.15
      

