
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

### Step 1: data preparation

Example data is provided on the *Home* tab of the web application and
[here](https://github.com/mattlee821/EpiViz/tree/master/app). When using
your own data, your data frame needs to include:

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

effect\_extimate

</th>

<th style="text-align:right;">

p\_value

</th>

<th style="text-align:right;">

lower\_confidence\_interval

</th>

<th style="text-align:right;">

upper\_confidence\_interval

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

### Step 2: plotting

Follow the instructions provided on the *How to* tab of the web
application. You can use example data provided with the app to produce
the following plot:

<img src="www/gallery/3_track_example_legend.svg" width="100%" />

## Session info

    ## R version 3.6.2 (2019-12-12)
    ## Platform: x86_64-apple-darwin15.6.0 (64-bit)
    ## Running under: macOS Catalina 10.15.3
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/3.6/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/3.6/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_1.0.3        rstudioapi_0.10   knitr_1.27        xml2_1.2.2       
    ##  [5] magrittr_1.5      hms_0.5.3         munsell_0.5.0     rvest_0.3.5      
    ##  [9] viridisLite_0.3.0 colorspace_1.4-1  R6_2.4.1          rlang_0.4.4      
    ## [13] highr_0.8         stringr_1.4.0     httr_1.4.1        tools_3.6.2      
    ## [17] webshot_0.5.2     xfun_0.12         htmltools_0.4.0   yaml_2.2.1       
    ## [21] digest_0.6.24     lifecycle_0.1.0   tibble_2.1.3      crayon_1.3.4     
    ## [25] kableExtra_1.1.0  readr_1.3.1       vctrs_0.2.3       glue_1.3.1       
    ## [29] evaluate_0.14     rmarkdown_2.1.1   stringi_1.4.5     compiler_3.6.2   
    ## [33] pillar_1.4.3      scales_1.1.0      pkgconfig_2.0.3
