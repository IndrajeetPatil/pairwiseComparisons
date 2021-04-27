# `pairwise_comparisons()` - test additional arguments

    Code
      list(df1, df2, df3, df4)
    Output
      [[1]]
      # A tibble: 6 x 6
        group1 group2  p.value test.details     p.value.adjustment
        <chr>  <chr>     <dbl> <chr>            <chr>             
      1 HDHF   HDLF   2.65e- 4 Student's t-test None              
      2 HDHF   LDHF   3.51e- 2 Student's t-test None              
      3 HDHF   LDLF   3.29e-13 Student's t-test None              
      4 HDLF   LDHF   9.72e- 1 Student's t-test None              
      5 HDLF   LDLF   6.62e- 4 Student's t-test None              
      6 LDHF   LDLF   1.11e- 9 Student's t-test None              
        label                                  
        <chr>                                  
      1 list(~italic(p)[uncorrected]==2.65e-04)
      2 list(~italic(p)[uncorrected]==0.035)   
      3 list(~italic(p)[uncorrected]==3.29e-13)
      4 list(~italic(p)[uncorrected]==0.972)   
      5 list(~italic(p)[uncorrected]==0.001)   
      6 list(~italic(p)[uncorrected]==1.11e-09)
      
      [[2]]
      # A tibble: 6 x 6
        group1 group2 p.value test.details     p.value.adjustment
        <chr>  <chr>    <dbl> <chr>            <chr>             
      1 HDHF   HDLF    1.00   Student's t-test None              
      2 HDHF   LDHF    0.965  Student's t-test None              
      3 HDHF   LDLF    1.00   Student's t-test None              
      4 HDLF   LDHF    0.0281 Student's t-test None              
      5 HDLF   LDLF    0.999  Student's t-test None              
      6 LDHF   LDLF    1.00   Student's t-test None              
        label                               
        <chr>                               
      1 list(~italic(p)[uncorrected]==1.000)
      2 list(~italic(p)[uncorrected]==0.965)
      3 list(~italic(p)[uncorrected]==1.000)
      4 list(~italic(p)[uncorrected]==0.028)
      5 list(~italic(p)[uncorrected]==0.999)
      6 list(~italic(p)[uncorrected]==1.000)
      
      [[3]]
      # A tibble: 6 x 11
        group1  group2  statistic p.value alternative method            distribution
        <chr>   <chr>       <dbl>   <dbl> <chr>       <chr>             <chr>       
      1 carni   herbi        2.17   0.437 two.sided   Games-Howell test q           
      2 carni   insecti     -2.17   0.452 two.sided   Games-Howell test q           
      3 carni   omni         1.10   0.865 two.sided   Games-Howell test q           
      4 herbi   insecti     -2.41   0.348 two.sided   Games-Howell test q           
      5 herbi   omni        -1.87   0.560 two.sided   Games-Howell test q           
      6 insecti omni         2.19   0.433 two.sided   Games-Howell test q           
        p.adjustment test.details      p.value.adjustment
        <chr>        <chr>             <chr>             
      1 none         Games-Howell test None              
      2 none         Games-Howell test None              
      3 none         Games-Howell test None              
      4 none         Games-Howell test None              
      5 none         Games-Howell test None              
      6 none         Games-Howell test None              
        label                               
        <chr>                               
      1 list(~italic(p)[uncorrected]==0.437)
      2 list(~italic(p)[uncorrected]==0.452)
      3 list(~italic(p)[uncorrected]==0.865)
      4 list(~italic(p)[uncorrected]==0.348)
      5 list(~italic(p)[uncorrected]==0.560)
      6 list(~italic(p)[uncorrected]==0.433)
      
      [[4]]
      # A tibble: 6 x 11
        group1  group2  statistic p.value alternative method            distribution
        <chr>   <chr>       <dbl>   <dbl> <chr>       <chr>             <chr>       
      1 carni   herbi        2.17   0.437 two.sided   Games-Howell test q           
      2 carni   insecti     -2.17   0.452 two.sided   Games-Howell test q           
      3 carni   omni         1.10   0.865 two.sided   Games-Howell test q           
      4 herbi   insecti     -2.41   0.348 two.sided   Games-Howell test q           
      5 herbi   omni        -1.87   0.560 two.sided   Games-Howell test q           
      6 insecti omni         2.19   0.433 two.sided   Games-Howell test q           
        p.adjustment test.details      p.value.adjustment
        <chr>        <chr>             <chr>             
      1 none         Games-Howell test None              
      2 none         Games-Howell test None              
      3 none         Games-Howell test None              
      4 none         Games-Howell test None              
      5 none         Games-Howell test None              
      6 none         Games-Howell test None              
        label                               
        <chr>                               
      1 list(~italic(p)[uncorrected]==0.437)
      2 list(~italic(p)[uncorrected]==0.452)
      3 list(~italic(p)[uncorrected]==0.865)
      4 list(~italic(p)[uncorrected]==0.348)
      5 list(~italic(p)[uncorrected]==0.560)
      6 list(~italic(p)[uncorrected]==0.433)
      

