# `pairwise_comparisons()` works for between-subjects design

    Code
      list(df1, df2, df3, df4, df5, df6)
    Output
      [[1]]
      # A tibble: 6 x 6
        group1  group2  p.value test.details     p.value.adjustment
        <chr>   <chr>     <dbl> <chr>            <chr>             
      1 carni   herbi     1     Student's t-test Bonferroni        
      2 carni   insecti   1     Student's t-test Bonferroni        
      3 carni   omni      1     Student's t-test Bonferroni        
      4 herbi   insecti   1     Student's t-test Bonferroni        
      5 herbi   omni      0.979 Student's t-test Bonferroni        
      6 insecti omni      1     Student's t-test Bonferroni        
        label                                        
        <chr>                                        
      1 list(~italic(p)[Bonferroni-corrected]==1.000)
      2 list(~italic(p)[Bonferroni-corrected]==1.000)
      3 list(~italic(p)[Bonferroni-corrected]==1.000)
      4 list(~italic(p)[Bonferroni-corrected]==1.000)
      5 list(~italic(p)[Bonferroni-corrected]==0.979)
      6 list(~italic(p)[Bonferroni-corrected]==1.000)
      
      [[2]]
      # A tibble: 6 x 11
        group1  group2  statistic p.value alternative method            distribution
        <chr>   <chr>       <dbl>   <dbl> <chr>       <chr>             <chr>       
      1 carni   herbi        2.17       1 two.sided   Games-Howell test q           
      2 carni   insecti     -2.17       1 two.sided   Games-Howell test q           
      3 carni   omni         1.10       1 two.sided   Games-Howell test q           
      4 herbi   insecti     -2.41       1 two.sided   Games-Howell test q           
      5 herbi   omni        -1.87       1 two.sided   Games-Howell test q           
      6 insecti omni         2.19       1 two.sided   Games-Howell test q           
        p.adjustment test.details      p.value.adjustment
        <chr>        <chr>             <chr>             
      1 none         Games-Howell test Bonferroni        
      2 none         Games-Howell test Bonferroni        
      3 none         Games-Howell test Bonferroni        
      4 none         Games-Howell test Bonferroni        
      5 none         Games-Howell test Bonferroni        
      6 none         Games-Howell test Bonferroni        
        label                                        
        <chr>                                        
      1 list(~italic(p)[Bonferroni-corrected]==1.000)
      2 list(~italic(p)[Bonferroni-corrected]==1.000)
      3 list(~italic(p)[Bonferroni-corrected]==1.000)
      4 list(~italic(p)[Bonferroni-corrected]==1.000)
      5 list(~italic(p)[Bonferroni-corrected]==1.000)
      6 list(~italic(p)[Bonferroni-corrected]==1.000)
      
      [[3]]
      # A tibble: 6 x 11
        group1  group2  statistic p.value alternative method               
        <chr>   <chr>       <dbl>   <dbl> <chr>       <chr>                
      1 carni   herbi       0.582  0.561  two.sided   Dunn's all-pairs test
      2 carni   insecti     1.88   0.0595 two.sided   Dunn's all-pairs test
      3 carni   omni        1.14   0.254  two.sided   Dunn's all-pairs test
      4 herbi   insecti     1.63   0.102  two.sided   Dunn's all-pairs test
      5 herbi   omni        0.717  0.474  two.sided   Dunn's all-pairs test
      6 insecti omni        1.14   0.254  two.sided   Dunn's all-pairs test
        distribution p.adjustment test.details p.value.adjustment
        <chr>        <chr>        <chr>        <chr>             
      1 z            none         Dunn test    None              
      2 z            none         Dunn test    None              
      3 z            none         Dunn test    None              
      4 z            none         Dunn test    None              
      5 z            none         Dunn test    None              
      6 z            none         Dunn test    None              
        label                               
        <chr>                               
      1 list(~italic(p)[uncorrected]==0.561)
      2 list(~italic(p)[uncorrected]==0.060)
      3 list(~italic(p)[uncorrected]==0.254)
      4 list(~italic(p)[uncorrected]==0.102)
      5 list(~italic(p)[uncorrected]==0.474)
      6 list(~italic(p)[uncorrected]==0.254)
      
      [[4]]
      # A tibble: 6 x 10
        group1  group2  estimate conf.level conf.low conf.high p.value
        <chr>   <chr>      <dbl>      <dbl>    <dbl>     <dbl>   <dbl>
      1 carni   herbi   -0.0323        0.95  -0.248     0.184    0.898
      2 carni   insecti  0.0451        0.95  -0.0484    0.139    0.898
      3 carni   omni     0.00520       0.95  -0.114     0.124    0.898
      4 herbi   insecti  0.0774        0.95  -0.133     0.288    0.898
      5 herbi   omni     0.0375        0.95  -0.182     0.257    0.898
      6 insecti omni    -0.0399        0.95  -0.142     0.0625   0.898
        test.details              p.value.adjustment
        <chr>                     <chr>             
      1 Yuen's trimmed means test FDR               
      2 Yuen's trimmed means test FDR               
      3 Yuen's trimmed means test FDR               
      4 Yuen's trimmed means test FDR               
      5 Yuen's trimmed means test FDR               
      6 Yuen's trimmed means test FDR               
        label                                 
        <chr>                                 
      1 list(~italic(p)[FDR-corrected]==0.898)
      2 list(~italic(p)[FDR-corrected]==0.898)
      3 list(~italic(p)[FDR-corrected]==0.898)
      4 list(~italic(p)[FDR-corrected]==0.898)
      5 list(~italic(p)[FDR-corrected]==0.898)
      6 list(~italic(p)[FDR-corrected]==0.898)
      
      [[5]]
      # A tibble: 3 x 6
        group1 group2 p.value test.details     p.value.adjustment
        <chr>  <chr>    <dbl> <chr>            <chr>             
      1 PG     PG-13  0.316   Student's t-test Holm              
      2 PG     R      0.00283 Student's t-test Holm              
      3 PG-13  R      0.00310 Student's t-test Holm              
        label                                  
        <chr>                                  
      1 list(~italic(p)[Holm-corrected]==0.316)
      2 list(~italic(p)[Holm-corrected]==0.003)
      3 list(~italic(p)[Holm-corrected]==0.003)
      
      [[6]]
      # A tibble: 6 x 17
        group1  group2  term       estimate conf.level conf.low conf.high    pd
        <chr>   <chr>   <chr>         <dbl>      <dbl>    <dbl>     <dbl> <dbl>
      1 carni   herbi   Difference   0.376        0.89  -0.349     1.15   0.800
      2 carni   insecti Difference  -0.0348       0.89  -0.105     0.0272 0.818
      3 carni   omni    Difference   0.0440       0.89  -0.0962    0.208  0.693
      4 herbi   insecti Difference  -0.394        0.89  -1.34      0.596  0.758
      5 herbi   omni    Difference  -0.362        0.89  -0.938     0.191  0.859
      6 insecti omni    Difference   0.0762       0.89  -0.141     0.261  0.732
        rope.percentage prior.distribution prior.location prior.scale  bf10
                  <dbl> <chr>                       <dbl>       <dbl> <dbl>
      1           0.183 cauchy                          0       0.707 0.540
      2           0.143 cauchy                          0       0.707 0.718
      3           0.252 cauchy                          0       0.707 0.427
      4           0.177 cauchy                          0       0.707 0.540
      5           0.172 cauchy                          0       0.707 0.571
      6           0.172 cauchy                          0       0.707 0.545
        method          log_e_bf10 label                          test.details    
        <chr>                <dbl> <chr>                          <chr>           
      1 Bayesian t-test     -0.617 list(~log[e](BF['01'])==0.617) Student's t-test
      2 Bayesian t-test     -0.332 list(~log[e](BF['01'])==0.332) Student's t-test
      3 Bayesian t-test     -0.851 list(~log[e](BF['01'])==0.851) Student's t-test
      4 Bayesian t-test     -0.616 list(~log[e](BF['01'])==0.616) Student's t-test
      5 Bayesian t-test     -0.560 list(~log[e](BF['01'])==0.560) Student's t-test
      6 Bayesian t-test     -0.606 list(~log[e](BF['01'])==0.606) Student's t-test
      

