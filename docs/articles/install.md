# 1. Installation

## Installation

The `EpiViz` package can be installed directly from GitHub.

``` r

# Install devtools if you haven't already
if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")

# Install EpiViz
devtools::install_github("mattlee821/EpiViz")
library(EpiViz)
```

### Handling ComplexHeatmap installation errors

A common issue during installation is that `ComplexHeatmap` (a core
dependency) might not be automatically available via CRAN for your R
version.

If you see an error like `package ‘ComplexHeatmap’ is not available`,
you should install it directly from Bioconductor before installing
`EpiViz`:

``` r

# Install BiocManager
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# Install ComplexHeatmap
BiocManager::install("ComplexHeatmap")

# Now install EpiViz
devtools::install_github("mattlee821/EpiViz/R_package")
```

Once installed, you can check the version with:

``` r

packageVersion("EpiViz")
```
