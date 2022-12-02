
# [`EpiViz`](https://mattlee.shinyapps.io/EpiViz/): web application

The [`EpiViz`](https://mattlee.shinyapps.io/EpiViz/) application enables
users to create efficient Circos plots for a range of data common to
epidemiology. <br>

The functionality of the web application is limited to:

- Point estimate and confidence interval
- P-value signified by solid colour
- P-value threshold selection
- Legend - automatically populated by group
- Two colour themes

For additional features use the [`R`
package](https://github.com/mattlee821/EpiViz/tree/master/R_package)

## How to

### data preparation

Example data is provided on with the web application and can be
downloaded directly from the app or this repo. When using your own data,
your data frame needs to include:

- label column
- effect estimate column
- p-value column
- lower confidence interval column
- upper confidence interval column
- section column

<table>
<thead>
<tr>
<th style="text-align:left;">
label
</th>
<th style="text-align:right;">
effect_extimate
</th>
<th style="text-align:right;">
p_value
</th>
<th style="text-align:right;">
lower_confidence_interval
</th>
<th style="text-align:right;">
upper_confidence_interval
</th>
<th style="text-align:left;">
group
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
label1
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
0.01
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:left;">
Group1
</td>
</tr>
<tr>
<td style="text-align:left;">
label2
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:left;">
Group1
</td>
</tr>
<tr>
<td style="text-align:left;">
label3
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:left;">
Group2
</td>
</tr>
<tr>
<td style="text-align:left;">
label4
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:left;">
Group3
</td>
</tr>
<tr>
<td style="text-align:left;">
label5
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:left;">
Group3
</td>
</tr>
</tbody>
</table>

## Session info

    ## R version 4.2.1 (2022-06-23)
    ## Platform: x86_64-apple-darwin17.0 (64-bit)
    ## Running under: macOS Big Sur ... 10.16
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/4.2/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/4.2/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] rstudioapi_0.14   knitr_1.41        xml2_1.3.3        magrittr_2.0.3   
    ##  [5] rvest_1.0.3       munsell_0.5.0     colorspace_2.0-3  viridisLite_0.4.1
    ##  [9] R6_2.5.1          rlang_1.0.6       fastmap_1.1.0     highr_0.9        
    ## [13] stringr_1.4.1     httr_1.4.4        tools_4.2.1       webshot_0.5.4    
    ## [17] xfun_0.35         cli_3.4.1         htmltools_0.5.3   systemfonts_1.0.4
    ## [21] yaml_2.3.6        digest_0.6.30     lifecycle_1.0.3   kableExtra_1.3.4 
    ## [25] glue_1.6.2        evaluate_0.18     rmarkdown_2.18    stringi_1.7.8    
    ## [29] compiler_4.2.1    scales_1.2.1      svglite_2.1.0
